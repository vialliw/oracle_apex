ALTER SESSION SET NLS_DATE_FORMAT = 'yyyy/mm/dd hh24:mi:ss';

--TRUNCATE TABLE IB_HH_PRICE;

SELECT ticker
, TO_CHAR(MIN(data_date), 'yyyy/mm/dd hh24:mi:ss') from_time
, TO_CHAR(MAX(data_date), 'yyyy/mm/dd hh24:mi:ss') to_time
, count(1)
FROM IB_HH_PRICE
GROUP BY ticker;

SELECT ticker, to_char(data_date, 'yyyy/mm/dd hh24:mi:ss') dtime, price
FROM IB_HH_PRICE
ORDER BY data_date;

SELECT data_date FROM ib_hh_price WHERE ticker = :pi_ticker_a
MINUS
SELECT data_date FROM ib_hh_price WHERE ticker = :pi_ticker_b
order by 1;

SELECT data_date FROM ib_hh_price WHERE ticker = :pi_ticker_b
MINUS
SELECT data_date FROM ib_hh_price WHERE ticker = :pi_ticker_a
order by 1;