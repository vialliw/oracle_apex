SPOOL C:\Users\user\OneDrive\Documents\script\python\batch_dd.txt
SELECT DISTINCT 'python C:\Users\user\OneDrive\Documents\script\python\yfinance5.py ' || ticker 
--FROM ticker_list
FROM price_data
ORDER BY 1;
SPOOL OFF;
