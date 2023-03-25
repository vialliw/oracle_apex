ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY/MM/DD HH24:MI:SS';
SET PAGESIZE 0;
SET ECHO OFF;
SET FEEDBACK OFF;
SET TRIMSPOOL ON;
COLUMN min_data_date FORMAT A20;
COLUMN max_data_date FORMAT A20;
COLUMN ticker FORMAT A6;
SPOOL C:\Users\user\OneDrive\Documents\script\python\batch_hh_dd.txt
SELECT DISTINCT 'python C:\Users\user\OneDrive\Documents\script\python\yfinance4.py ' || ticker 
  || CHR(10) || 'python C:\Users\user\OneDrive\Documents\script\python\yfinance5.py ' || ticker 
cmdline_hh_dd
--FROM ticker_list
FROM price_data
ORDER BY 1;
SPOOL OFF;
