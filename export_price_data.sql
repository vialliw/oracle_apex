-- @C:\Users\edvw\Documents\trade\export_price_data.sql
SET ECHO OFF;
SET TERM OFF;
SET FEEDBACK OFF;
SET PAGESIZE 0;
SET HEADING OFF;
SET LINESIZE 500;
SET TRIMSPOOL ON;
SPOOL d:\prod_in\price_data.csv
SELECT '"DATA_DATE","OPEN","HIGH","LOW","CLOSE","ADJ_CLOSE","VOLUME","TICKER"' d FROM DUAL
UNION ALL
SELECT '"' || TO_CHAR(data_date,'yyyy/mm/dd')
   ||'","'|| TO_CHAR( OPEN ) 
   ||'","'|| TO_CHAR( HIGH ) 
   ||'","'|| TO_CHAR( LOW ) 
   ||'","'|| TO_CHAR( CLOSE ) 
   ||'","'|| TO_CHAR( ADJ_CLOSE ) 
   ||'","'|| TO_CHAR( VOLUME ) 
   ||'","'|| ticker ||'"' d 
FROM price_data
--WHERE ROWNUM < 3
/
SPOOL OFF;
SET HEADING ON;
SET ECHO ON;
SET TERM ON;
SET FEEDBACK ON;
