ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY/MM/DD HH24:MI:SS';
SET PAGESIZE 0;
SET LINESIZE 1000;
SET ECHO OFF;
SET FEEDBACK OFF;
SET TRIMSPOOL ON;
COLUMN min_data_date FORMAT A20;
COLUMN max_data_date FORMAT A20;
COLUMN ticker FORMAT A6;
SPOOL C:\Users\user\OneDrive\Documents\script\batch_import_hh_dd.txt
SELECT DISTINCT '   l_retval := pa_zfcc_07.import_yf_price(''' || ticker ||'.csv'', ''YYYY-MM-DD HH24:MI:SS'', ''1h'', ''ORA_DIR'');' || CHR(10)
|| '   l_retval := pa_zfcc_07.import_yf_price(''' || ticker ||'.csv'', ''YYYY-MM-DD'', ''EOD'', ''ORA_DIR_DD'');' cmd
FROM price_data
ORDER BY 1;
SPOOL OFF;
