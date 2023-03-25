-- Ticker list
SELECT DISTINCT col_h
FROM rawdata;

SELECT DISTINCT ticker

SELECT COUNT(1)
FROM price_data;

-- Price data list of specified ticker
SELECT col_a data_time, col_f adj_close
FROM rawdata
WHERE col_h = UPPER(:ticker)
--ORDER BY col_a;
ORDER BY TO_NUMBER(col_i) -- sequence no.

SELECT *
FROM price_data
WHERE ticker = UPPER(:ticker)

-- All tickers, no. of ticks, data range
SELECT col_h ticker
, COUNT(1) ticks
, MIN(TO_DATE(col_a,'DD-MM-YYYY')) range_from
, MAX(TO_DATE(col_a,'DD-MM-YYYY')) range_to
FROM rawdata
GROUP BY col_h

SELECT ticker
, COUNT(1) ticks
, MIN(data_date) range_from
, MAX(data_date) range_to
FROM price_data
GROUP BY ticker


-- Reset sequence number of specified ticker
DECLARE
BEGIN
   pa_zfcc_07.rawdata_set_seq_num('IHI');
   pa_zfcc_07.rawdata_set_seq_num('TMO');
END;

-- Change from YYYY-MM-DD to DD-MM-YYYY for col_a of specified ticker
UPDATE rawdata
SET col_a = SUBSTR(col_a, 9, 2) ||'-'|| SUBSTR(col_a, 6, 2) ||'-'|| SUBSTR(col_a, 1, 4)
WHERE col_h = UPPER(:ticker);

ROLLBACK;

