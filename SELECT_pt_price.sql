SELECT ticker_a, ticker_b, MIN(data_time), MAX(data_time), MIN(seq_no), MAX(seq_no)
FROM pt_price
--WHERE ticker_a = :pi_ticker_a
--AND ticker_b = :pi_ticker_b
GROUP BY ticker_a, ticker_b;

SELECT ticker_a, ticker_b, MIN(data_time), MAX(data_time), MIN(seq_no), MAX(seq_no)
, ROUND(corr(price_a, price_b),5) correlation_coefficient
FROM pt_price
--WHERE ticker_a = :pi_ticker_a
--AND ticker_b = :pi_ticker_b
GROUP BY ticker_a, ticker_b;

SELECT *
FROM pt_price
WHERE ticker_a = 'RSG'
AND ticker_b = 'WM'
ORDER BY seq_no;