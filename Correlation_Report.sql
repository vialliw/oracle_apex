SELECT a.ticker ticker_a, b.ticker ticker_b
, pa_zfcc_09.get_common_fm_dt(a.ticker, b.ticker) earliest
, ROUND(MONTHS_BETWEEN(pa_zfcc_09.get_common_to_dt(a.ticker, b.ticker), pa_zfcc_09.get_common_fm_dt(a.ticker, b.ticker))) PERIOD_MTHS
, ROUND(pa_zfcc_09.get_corr(a.ticker, b.ticker), 3) Corr_all
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
