SELECT a.data_date data_time, a.ticker ticker_a, a.OPEN open_a, a.high high_a, a.low low_a, a.CLOSE close_a, a.adj_close adj_close_a, a.volume volume_a 
, b.ticker ticker_b, b.OPEN open_b, b.high high_b, b.low low_b, b.CLOSE close_b, b.adj_close adj_close_b, b.volume volume_b
, TO_CHAR(a.data_date,'yyyymmddhh24miss') SEQ_NO
FROM price_data a, price_data b 
WHERE a.data_date = b.data_date 
AND a.ticker = :ticker_a 
AND b.ticker = :ticker_b 
ORDER BY SEQ_NO;
