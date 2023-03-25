ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
--SET HEADING OFF;
--SET VERIFY ON;
SET TRIMSPOOL ON;
SET LINESIZE 9999;
SET TERM OFF;
--SET ECHO OFF;
--SET FEEDBACK ON;
SET PAGESIZE 0;
SET MARKUP HTML ON SPOOL ON;
SPOOL C:\intel\tmp\corr_report20220912.xls
SELECT 'Ticker A', 'Ticker B', 'Corr', 'Corr 12 mth', 'Corr 6 mth', 'Corr 3 mth', 'Corr 2 mth', 'Corr 1 mth'
FROM  DUAL;
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
AND ROWNUM < 60
;
SPOOL OFF;
