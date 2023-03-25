--@C:\Users\edvw\Documents\trade\gen_correlation_report.sql
SET TIME ON;
SET NEWPAGE 0;
SET SPACE 0;
SET LINESIZE 2000;
SET PAGESIZE 0;
SET ECHO OFF;
SET FEEDBACK OFF;
SET TERM OFF;
SET HEADING ON;
SET TRIMSPOOL ON;
SET FLUSH OFF;
-- Declare variables for report format and location
DEFINE g_format_mask = "YYYY/MM/DD";
-- Set NLS_DATE_FORMAT for session
ALTER SESSION SET NLS_DATE_FORMAT = '&g_format_mask';
VARIABLE n NUMBER;
BEGIN
   :n := 0;
   IF :n <= 0 THEN
      :n := 999999;
   END IF;
END;
/
SPOOL C:\Users\edvw\Documents\trade\Correlation_Report.csv
SELECT '"Ticker A","Ticker B","From","To","No. of Months","Correlation"'
FROM DUAL
UNION ALL
SELECT '"' || a.col_h --ticker_a
||'","'|| b.col_h --ticker_b
||'","'|| MIN(TO_DATE(a.col_a, 'DD-MM-YYYY')) --from_dt
||'","'|| MAX(TO_DATE(a.col_a, 'DD-MM-YYYY')) --to_dt
||'","'|| ROUND(MONTHS_BETWEEN(MAX(TO_DATE(a.col_a, 'DD-MM-YYYY')), MIN(TO_DATE(a.col_a, 'DD-MM-YYYY')))) --NO_OF_MONTHS
||'","'|| TO_CHAR(CORR(TO_NUMBER(a.col_f), TO_NUMBER(b.col_f))) ||'"' --correlation
FROM rawdata a, rawdata b
   , (SELECT ticker_a, ticker_b
      FROM (SELECT DISTINCT r.col_h ticker_a
            FROM rawdata r) a,
           (SELECT DISTINCT s.col_h ticker_b
            FROM rawdata s) b
      WHERE ticker_a < ticker_b
      AND ROWNUM < (:n + 1)
      ) c
WHERE a.col_a = b.col_a
AND a.col_h = c.ticker_a
AND b.col_h = c.ticker_b
GROUP BY a.col_h, b.col_h;
SPOOL OFF;
-- SHOW COMPLETE MESSAGE
SET ECHO OFF;
SET PAGESIZE 14;
SET FEEDBACK ON;
SET TRIMSPOOL OFF;
SET FLUSH ON;
SET TERM ON;
