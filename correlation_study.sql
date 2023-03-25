SELECT a.col_a data_time, a.col_h ticker_a, a.col_f price_a, b.col_h ticker_b, b.col_f price_b
FROM rawdata a, rawdata b
WHERE a.col_a = b.col_a
AND a.col_h = :ticker_a
AND b.col_h = :ticker_b
ORDER BY TO_NUMBER(a.col_i);

-- one pair and correlation
SELECT a.col_h ticker_a
, b.col_h ticker_b
, CORR(TO_NUMBER(a.col_f), TO_NUMBER(b.col_f)) correlation 
FROM rawdata a, rawdata b
WHERE a.col_a = b.col_a
AND a.col_h = :ticker_a
AND b.col_h = :ticker_b
GROUP BY a.col_h, b.col_h;

-- one pair and correlation, date range
SELECT a.col_h ticker_a
, b.col_h ticker_b
, MIN(TO_DATE(a.col_a, 'DD-MM-YYYY')) from_dt
, MAX(TO_DATE(a.col_a, 'DD-MM-YYYY')) to_dt
, ROUND(MONTHS_BETWEEN(MAX(TO_DATE(a.col_a, 'DD-MM-YYYY')), MIN(TO_DATE(a.col_a, 'DD-MM-YYYY')))) NO_OF_MONTHS
, CORR(TO_NUMBER(a.col_f), TO_NUMBER(b.col_f)) correlation
FROM rawdata a, rawdata b
WHERE a.col_a = b.col_a
AND a.col_h = :ticker_a
AND b.col_h = :ticker_b
GROUP BY a.col_h, b.col_h;

-- Try to list two hard coded pairs
SELECT DISTINCT r.col_h ticker_a, 'DNN' ticker_b  
FROM rawdata r
WHERE r.col_h = 'CCJ'
UNION ALL
SELECT DISTINCT r.col_h ticker_a, 'LOW' ticker_b  
FROM rawdata r
WHERE r.col_h = 'HD'

-- Incorporate hard coded pairs into correlation query
SELECT a.col_h ticker_a
, b.col_h ticker_b
, MIN(TO_DATE(a.col_a, 'DD-MM-YYYY')) from_dt
, MAX(TO_DATE(a.col_a, 'DD-MM-YYYY')) to_dt
, ROUND(MONTHS_BETWEEN(MAX(TO_DATE(a.col_a, 'DD-MM-YYYY')), MIN(TO_DATE(a.col_a, 'DD-MM-YYYY')))) NO_OF_MONTHS
, CORR(TO_NUMBER(a.col_f), TO_NUMBER(b.col_f)) correlation
FROM rawdata a, rawdata b
   , (SELECT DISTINCT r.col_h ticker_a, 'DNN' ticker_b  
      FROM rawdata r
      WHERE r.col_h = 'CCJ'
      UNION ALL
      SELECT DISTINCT r.col_h ticker_a, 'LOW' ticker_b       
      FROM rawdata r
      WHERE r.col_h = 'HD') c
WHERE a.col_a = b.col_a
AND a.col_h = c.ticker_a
AND b.col_h = c.ticker_b
GROUP BY a.col_h, b.col_h;

-- List all possible pairs
SELECT ticker_a, ticker_b
FROM (SELECT DISTINCT r.col_h ticker_a
      FROM rawdata r) a,
     (SELECT DISTINCT s.col_h ticker_b
      FROM rawdata s) b
WHERE ticker_a < ticker_b

-- Incorporate many pairs into correlation query
SELECT a.col_h ticker_a
, b.col_h ticker_b
, MIN(TO_DATE(a.col_a, 'DD-MM-YYYY')) from_dt
, MAX(TO_DATE(a.col_a, 'DD-MM-YYYY')) to_dt
, ROUND(MONTHS_BETWEEN(MAX(TO_DATE(a.col_a, 'DD-MM-YYYY')), MIN(TO_DATE(a.col_a, 'DD-MM-YYYY')))) NO_OF_MONTHS
, CORR(TO_NUMBER(a.col_f), TO_NUMBER(b.col_f)) correlation
FROM rawdata a, rawdata b
   , (SELECT ticker_a, ticker_b
      FROM (SELECT DISTINCT r.col_h ticker_a
            FROM rawdata r) a,
           (SELECT DISTINCT s.col_h ticker_b
            FROM rawdata s) b
      WHERE ticker_a < ticker_b
      ) c
WHERE a.col_a = b.col_a
AND a.col_h = c.ticker_a
AND b.col_h = c.ticker_b
GROUP BY a.col_h, b.col_h;


-- Incorporate N pairs into correlation query
VARIABLE n NUMBER;
BEGIN
   :n := 3;
END;
/
SELECT a.col_h ticker_a
, b.col_h ticker_b
, MIN(TO_DATE(a.col_a, 'DD-MM-YYYY')) from_dt
, MAX(TO_DATE(a.col_a, 'DD-MM-YYYY')) to_dt
, ROUND(MONTHS_BETWEEN(MAX(TO_DATE(a.col_a, 'DD-MM-YYYY')), MIN(TO_DATE(a.col_a, 'DD-MM-YYYY')))) NO_OF_MONTHS
, CORR(TO_NUMBER(a.col_f), TO_NUMBER(b.col_f)) correlation
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
