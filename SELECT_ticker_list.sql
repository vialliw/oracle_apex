select LIST_NAME, COUNT(1)
from ticker_list
GROUP BY LIST_NAME;

select ticker, COUNT(1)
from ticker_list
GROUP BY ticker
having count(1) > 1
ORDER BY 2 DESC,1;

SELECT * 
FROM ticker_list
--where TICKER = 'TLT'
order by ticker
;

select distinct ticker from ticker_list;

select distinct 'python C:\Users\user\OneDrive\Documents\script\python\yfinance4.py ' || ticker 
from ticker_list
ORDER BY 1;

select distinct 'python C:\Users\user\OneDrive\Documents\script\python\yfinance5.py ' || ticker 
from ticker_list
ORDER BY 1;

---l_retval := pa_zfcc_07.import_yf_hh_price('A.csv', 'YYYY-MM-DD HH24:MI:SS');

select distinct 'l_retval := pa_zfcc_07.import_yf_hh_price(''' || ticker ||'.csv'', ''YYYY-MM-DD HH24:MI:SS'');' plsql
from ticker_list
ORDER BY 1;

-- List tickers which belong to specified LIST_NAME (e.g. SPY, QQQ, XLY)
SELECT '"' || ticker || '",' for_concatentation
FROM ticker_list t
WHERE t.list_name = UPPER(:pi_list_name)
AND EXISTS (SELECT 1 FROM price_data p WHERE p.ticker = t.ticker);

-- Records appear in PRICE_DATA but not in TICKER_LIST
SELECT p.ticker 
FROM price_data p
WHERE 1=1
AND NOT EXISTS (SELECT 1 FROM ticker_list t WHERE p.ticker = t.ticker)
GROUP BY p.ticker;

-- Create ticker_list record which appears in PRICE_DATA
INSERT INTO ticker_list (list_name, ticker)
   (SELECT 'ETF' list_name, p.ticker 
    FROM price_data p
    WHERE NOT EXISTS (SELECT 1 FROM ticker_list t WHERE p.ticker = t.ticker)
    GROUP BY p.ticker);

COMMIT;