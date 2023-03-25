ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';

SELECT DISTINCT ticker FROM price_data
MINUS
SELECT DISTINCT ticker FROM ticker_list
order by 1;

-- PV Check individual ticker price in descending date order
SELECT data_date, TO_CHAR(ROUND(adj_close, 2),'99,999.99') adj_close, bar_size
FROM price_data
where 1=1
AND data_date > to_date('20220731','yyyymmdd')
--AND bar_size = '1h'
--AND bar_size = 'EOD'
AND ticker = :pi_ticker
ORDER BY data_date DESC;

-- PV 4 Daily import count
SELECT bar_size, TRUNC(data_date,'DD'), COUNT(1)
FROM price_data
where 1=1
AND data_date >= TRUNC(SYSDATE -5, 'DD')
--AND bar_size = '1h'
--AND bar_size = 'EOD'
GROUP BY bar_size, TRUNC(data_date,'DD')
ORDER BY 1,2 DESC;

-- PV4B
SELECT DISTINCT ticker FROM price_data
WHERE data_date = TO_DATE('20230130','YYYYMMDD')
AND bar_size = 'EOD'
MINUS
SELECT DISTINCT ticker FROM price_data
WHERE data_date = TO_DATE('20230131','YYYYMMDD')
AND bar_size = 'EOD';


SELECT data_date price_dt, adj_close close_price
FROM price_data
where bar_size = 'EOD'
AND ticker = :pi_ticker
ORDER BY data_date;

-- PV 1 after import price
SELECT p.ticker, count(1), MIN(p.data_date), MAX(p.data_date), ROUND(max(p.data_date) - min(p.data_date)) days, TO_CHAR(ROUND(AVG(p.adj_close * p.volume) / 1000000)) ||'M' "Avg_vol"
from price_data p
WHERE p.bar_size = 'EOD'
--AND EXISTS (SELECT 1 FROM ticker_list t WHERE t.ticker = p.ticker AND t.list_name = 'XLY')
group by p.ticker
ORDER BY AVG(p.adj_close * p.volume) DESC;

-- PV 2 after import price
SELECT ticker, count(1), TO_CHAR(MIN(data_date),'yyyy/mm/dd hh24:mi') MIN_DT, TO_CHAR(MAX(data_date),'yyyy/mm/dd hh24:mi') MAX_DT, TO_CHAR(ROUND(AVG(adj_close * volume) / 1000000)) ||'M' "Avg_vol"
from price_data
WHERE bar_size = '1h'
group by ticker
ORDER BY AVG(adj_close * volume) DESC;

SELECT 'python C:\Users\user\OneDrive\Documents\script\python\yfinance6_parquet.py ' || ticker
from price_data
WHERE bar_size = 'EOD'
GROUP BY ticker
ORDER BY 1;

SELECT ticker, count(1), MIN(data_date), MAX(data_date), ROUND(max(data_date) - min(data_date)) days, ROUND(AVG(adj_close * volume) / 1000000) "Avg_vol($M)"
from price_data
WHERE bar_size = '1h'
AND data_date > TRUNC(SYSDATE - 5,'DD')
group by ticker;

--DELETE from price_data
--WHERE bar_size = '1h'
--and data_date > TRUNC(SYSDATE - 2,'DD');

DELETE 
from price_data
WHERE TICKER = 'FBHS';

DELETE 
from TICKER_LIST
WHERE TICKER = 'FBHS';

COMMIT;

SELECT DISTINCT '   l_retval := pa_zfcc_07.import_yf_price(''' || ticker ||'.csv'', ''YYYY-MM-DD HH24:MI:SS'', ''1h'', ''ORA_DIR'');' || CHR(10)
|| '   l_retval := pa_zfcc_07.import_yf_price(''' || ticker ||'.csv'', ''YYYY-MM-DD'', ''EOD'', ''ORA_DIR_DD'');' cmd
FROM price_data
ORDER BY 1;

SELECT p.ticker, count(1)
from price_data p
WHERE exists (select 1 from ticker_list t where t.ticker = p.ticker)
group by p.ticker
ORDER BY 1
;

SELECT a.ticker ticker_a, b.ticker ticker_b
, ROUND(pa_zfcc_09.get_corr(a.ticker, b.ticker), 3) get_corr
, ROUND(pa_zfcc_09.get_corr(a.ticker, b.ticker, pa_zfcc_09.get_fm_dt_by_mth(a.ticker, b.ticker, 12) ), 3) Corr_12_mths
, ROUND(pa_zfcc_09.get_corr(a.ticker, b.ticker, pa_zfcc_09.get_fm_dt_by_mth(a.ticker, b.ticker, 6) ), 3) Corr_6_mths
, ROUND(pa_zfcc_09.get_corr(a.ticker, b.ticker, pa_zfcc_09.get_fm_dt_by_mth(a.ticker, b.ticker, 3) ), 3) Corr_3_mths
, ROUND(pa_zfcc_09.get_corr(a.ticker, b.ticker, pa_zfcc_09.get_fm_dt_by_mth(a.ticker, b.ticker, 2) ), 3) Corr_2_mths
, ROUND(pa_zfcc_09.get_corr(a.ticker, b.ticker, pa_zfcc_09.get_fm_dt_by_mth(a.ticker, b.ticker, 1) ), 3) Corr_1_mths
FROM (SELECT ticker FROM price_data GROUP BY ticker) a
, (SELECT ticker FROM price_data GROUP BY ticker) b
WHERE a.ticker < b.ticker
--AND ROWNUM < 6
;

SELECT a.ticker ticker_a, b.ticker ticker_b
, ROUND(pa_zfcc_09.get_corr(a.ticker, b.ticker), 3) get_corr
, ROUND(pa_zfcc_09.get_corr(a.ticker, b.ticker, pa_zfcc_09.get_fm_dt_by_mth(a.ticker, b.ticker, 12) ), 3) Corr_12_mths
, ROUND(pa_zfcc_09.get_corr(a.ticker, b.ticker, pa_zfcc_09.get_fm_dt_by_mth(a.ticker, b.ticker, 6) ), 3) Corr_6_mths
, ROUND(pa_zfcc_09.get_corr(a.ticker, b.ticker, pa_zfcc_09.get_fm_dt_by_mth(a.ticker, b.ticker, 3) ), 3) Corr_3_mths
, ROUND(pa_zfcc_09.get_corr(a.ticker, b.ticker, pa_zfcc_09.get_fm_dt_by_mth(a.ticker, b.ticker, 2) ), 3) Corr_2_mths
, ROUND(pa_zfcc_09.get_corr(a.ticker, b.ticker, pa_zfcc_09.get_fm_dt_by_mth(a.ticker, b.ticker, 1) ), 3) Corr_1_mths
FROM (SELECT ticker FROM price_data WHERE bar_size = '1h' GROUP BY ticker) a
, (SELECT ticker FROM price_data WHERE bar_size = '1h' GROUP BY ticker) b
WHERE a.ticker < b.ticker
--AND ROWNUM < 6
;

SELECT a.ticker ticker_a, b.ticker ticker_b
FROM (SELECT ticker FROM price_data GROUP BY ticker) a
, (SELECT ticker FROM price_data GROUP BY ticker) b
WHERE a.ticker < b.ticker;

SELECT a.ticker ticker_a, b.ticker ticker_b, pa_zfcc_09.get_corr(a.ticker, b.ticker) get_corr
FROM (SELECT ticker FROM price_data GROUP BY ticker) a
, (SELECT ticker FROM price_data GROUP BY ticker) b
WHERE a.ticker < b.ticker;

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY/MM/DD';

SELECT a.ticker ticker_a
, b.ticker ticker_b
, a.fm_dt
, a.to_dt
, b.fm_dt
, b.to_dt
, pa_zfcc_09.get_corr(a.ticker, b.ticker) get_corr
FROM    (SELECT ticker, MIN(data_date) fm_dt, MAX(data_date) to_dt
        FROM price_data 
        GROUP BY ticker) a
,       (SELECT ticker, MIN(data_date) fm_dt, MAX(data_date) to_dt 
        FROM price_data 
        GROUP BY ticker) b
WHERE a.ticker < b.ticker
AND ROWNUM < 6;
--GROUP BY a.ticker, b.ticker;
--ORDER BY get_corr DESC;

SELECT MIN(a.data_date) min_dt
, MAX(a.data_date) max_dt
, MAX(a.data_date) - 7 start_dt_1_week
, MAX(a.data_date) - 14 start_dt_2_week
, ADD_MONTHS(MAX(a.data_date), -3) start_dt_3_mths
FROM price_data a, price_data b
WHERE a.data_date = b.data_date
AND a.ticker = :ticker_a
AND b.ticker = :ticker_b
;

-- correlation 1
    SELECT corr(a.adj_close, b.adj_close)
    FROM (  SELECT p.data_date, p.adj_close, p.ticker
            FROM price_data p
            WHERE p.ticker = :ticker_a) a
        , ( SELECT p.data_date, p.adj_close, p.ticker
            FROM price_data p
            WHERE p.ticker = :ticker_b) b
    WHERE a.data_date = b.data_date
    GROUP BY a.ticker, b.ticker;

SELECT a.data_date
, a.adj_close
, b.adj_close
FROM price_data a, price_data b
WHERE a.data_date = b.data_date
AND a.ticker = :ticker_a
AND b.ticker = :ticker_b
;

-- correlation 2
SELECT a.ticker ticker_a, b.ticker ticker_b, corr( a.adj_close, b.adj_close ) get_corr
FROM price_data a, price_data b
WHERE a.data_date = b.data_date
AND a.ticker = :ticker_a
AND b.ticker = :ticker_b
GROUP BY a.ticker, b.ticker
;

-- Series of price
        SELECT a.ticker ticker_a
                , b.ticker ticker_b
                , c.ticker ticker_c
                , 0 + RANK() OVER (ORDER BY a.data_date) seq_no
                , a.data_date data_time
                , a.adj_close price_a
                , b.adj_close price_b
                , c.adj_close price_c
        FROM price_data a, price_data b, price_data c
        WHERE a.data_date = b.data_date 
        AND a.data_date = c.data_date 
        AND a.bar_size = 'EOD'
        AND b.bar_size = 'EOD'
        AND c.bar_size = 'EOD'
        AND a.ticker = 'CCL'
        AND b.ticker = 'NCLH'
        AND c.ticker = 'RCL';

-- Price of a pair
         SELECT a.ticker ticker_a
                , b.ticker ticker_b
                , RANK() OVER (ORDER BY a.data_date) seq_no
                , a.data_date data_time
                , a.adj_close price_a
                , b.adj_close price_b
                , LN(a.adj_close / b.adj_close) l_idx
         FROM price_data a, price_data b
         WHERE a.data_date = b.data_date
         AND a.ticker = :pi_ticker_a
         AND b.ticker = :pi_ticker_b
         AND a.bar_size = 'EOD'
         AND b.bar_size = 'EOD'
         ORDER BY a.data_date;
