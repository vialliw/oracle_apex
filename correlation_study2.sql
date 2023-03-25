SELECT a.data_date data_time, a.ticker ticker_a, a.adj_close price_a, b.ticker ticker_b, b.adj_close price_b
FROM price_data a, price_data b
WHERE a.data_date = b.data_date
AND a.ticker = :ticker_a
AND b.ticker = :ticker_b
ORDER BY a.data_date;

-- one pair and correlation
SELECT a.ticker ticker_a
, b.ticker ticker_b
, CORR(TO_NUMBER(a.adj_close), TO_NUMBER(b.adj_close)) correlation 
FROM price_data a, price_data b
WHERE a.data_date = b.data_date
AND a.ticker = :ticker_a
AND b.ticker = :ticker_b
GROUP BY a.ticker, b.ticker;

-- one pair and correlation, date range
SELECT a.ticker ticker_a
, b.ticker ticker_b
, MIN(a.data_date) from_dt
, MAX(a.data_date) to_dt
, ROUND(MONTHS_BETWEEN(MAX(a.data_date), MIN(a.data_date))) NO_OF_MONTHS
, CORR(TO_NUMBER(a.adj_close), TO_NUMBER(b.adj_close)) correlation
FROM price_data a, price_data b
WHERE a.data_date = b.data_date
AND a.ticker = :ticker_a
AND b.ticker = :ticker_b
GROUP BY a.ticker, b.ticker;

-- Try to list two hard coded pairs
SELECT DISTINCT r.ticker ticker_a, 'DNN' ticker_b  
FROM price_data r
WHERE r.ticker = 'CCJ'
UNION ALL
SELECT DISTINCT r.ticker ticker_a, 'LOW' ticker_b  
FROM price_data r
WHERE r.ticker = 'HD'

-- Incorporate hard coded pairs into correlation query
SELECT a.ticker ticker_a
, b.ticker ticker_b
, MIN(a.data_date) from_dt
, MAX(a.data_date) to_dt
, ROUND(MONTHS_BETWEEN(MAX(a.data_date), MIN(a.data_date))) NO_OF_MONTHS
, CORR(TO_NUMBER(a.adj_close), TO_NUMBER(b.adj_close)) correlation
FROM price_data a, price_data b
   , (SELECT DISTINCT r.ticker ticker_a, 'SPY' ticker_b  
      FROM price_data r
      WHERE r.ticker = 'XLK'
      UNION ALL
      SELECT DISTINCT r.ticker ticker_a, 'AAPL' ticker_b       
      FROM price_data r
      WHERE r.ticker = 'AMD') c
WHERE a.data_date = b.data_date
AND a.ticker = c.ticker_a
AND b.ticker = c.ticker_b
GROUP BY a.ticker, b.ticker;

-- List all possible pairs
SELECT ticker_a, ticker_b
FROM (SELECT DISTINCT r.ticker ticker_a
      FROM price_data r) a,
     (SELECT DISTINCT s.ticker ticker_b
      FROM price_data s) b
WHERE ticker_a < ticker_b;

-- Price data and no of ticks
SELECT ticker, COUNT(1) 
FROM price_data
GROUP BY ticker
ORDER BY ticker;

-- Incorporate many pairs into correlation query
SELECT a.ticker ticker_a
, b.ticker ticker_b
, MIN(a.data_date) from_dt
, MAX(a.data_date) to_dt
, ROUND(MONTHS_BETWEEN(MAX(a.data_date), MIN(a.data_date))) NO_OF_MONTHS
, CORR(TO_NUMBER(a.adj_close), TO_NUMBER(b.adj_close)) correlation
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


-- Incorporate N pairs into correlation query
VARIABLE n NUMBER;
BEGIN
   :n := 3;
END;
/

SELECT a.ticker ticker_a
, b.ticker ticker_b
, MIN(a.data_date) from_dt
, MAX(a.data_date) to_dt
, ROUND(MONTHS_BETWEEN(MAX(a.data_date), MIN(a.data_date))) NO_OF_MONTHS
, CORR(TO_NUMBER(a.adj_close), TO_NUMBER(b.adj_close)) correlation
FROM price_data a, price_data b
   , (SELECT ticker_a, ticker_b
      FROM (SELECT DISTINCT r.ticker ticker_a
            FROM price_data r) a,
           (SELECT DISTINCT s.ticker ticker_b
            FROM price_data s) b
      WHERE ticker_a < ticker_b
      AND ROWNUM < (:n + 1)
      ) c
WHERE a.data_date = b.data_date
AND a.ticker = c.ticker_a
AND b.ticker = c.ticker_b
GROUP BY a.ticker, b.ticker;
