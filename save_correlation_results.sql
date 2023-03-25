--@C:\Users\edvw\Documents\trade\save_correlation_results.sql
SET TIME ON;
DROP TABLE corr_reslt CASCADE CONSTRAINTS;
--
CREATE TABLE corr_reslt AS (
   SELECT a.ticker ticker_a
   , b.ticker ticker_b
   , MIN(a.data_date) from_dt
   , MAX(a.data_date) to_dt
   , ROUND(MONTHS_BETWEEN(MAX(a.data_date), MIN(a.data_date))) NO_OF_MONTHS
   , CORR(a.adj_close, b.adj_close) correlation
   , SYSDATE reslt_dt
   FROM price_data a, price_data b
      , (SELECT ticker_a, ticker_b
         FROM (SELECT DISTINCT r.ticker ticker_a
               FROM price_data r) a,
              (SELECT DISTINCT s.ticker ticker_b
               FROM price_data s) b
         WHERE ticker_a < ticker_b
         --AND ROWNUM < 3
         ) c
   WHERE a.data_date = b.data_date
   AND a.ticker = c.ticker_a
   AND b.ticker = c.ticker_b
   GROUP BY a.ticker, b.ticker
);
