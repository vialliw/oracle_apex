--@C:\Users\edvw\Documents\trade\gen_correlation_report2.sql
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
SPOOL C:\Users\edvw\Documents\trade\Correlation_Report2.csv
SELECT '"Ticker A","Ticker B","From","To","No. of Months","Correlation"'
FROM DUAL
UNION ALL
SELECT '"' || a.ticker --ticker_a
||'","'|| b.ticker --ticker_b
||'","'|| MIN(a.data_date) --from_dt
||'","'|| MAX(a.data_date) --to_dt
||'","'|| ROUND(MONTHS_BETWEEN(MAX(a.data_date), MIN(a.data_date))) --NO_OF_MONTHS
||'","'|| CORR(TO_NUMBER(a.adj_close), TO_NUMBER(b.adj_close)) --correlation
||'"'
FROM price_data a, price_data b
   , (SELECT ticker_a, ticker_b
      FROM (SELECT DISTINCT r.ticker ticker_a
            FROM price_data r) a,
           (SELECT DISTINCT s.ticker ticker_b
            FROM price_data s) b
      WHERE ticker_a < ticker_b
      ) c
WHERE a.data_date = b.data_date
AND a.ticker = c.ticker_a
AND b.ticker = c.ticker_b
GROUP BY a.ticker, b.ticker;
SPOOL OFF;
-- SHOW COMPLETE MESSAGE
SET ECHO OFF;
SET PAGESIZE 14;
SET FEEDBACK ON;
SET TRIMSPOOL OFF;
SET FLUSH ON;
SET TERM ON;
