/*
SELECT pt_id, ticker_a, ticker_b, MA, PRESET_STOP_LOSS, PRESET_TAKE_PROFIT
FROM pt_strtg_ma
ORDER BY pt_id DESC;

SELECT ticker_a, ticker_b, MIN(pt_id), MAX(pt_id), COUNT(1)
FROM pt_strtg_ma
GROUP BY ticker_a, ticker_b
ORDER BY MAX(pt_id) DESC;
*/
DELETE FROM pt_paper WHERE pt_id >= 22065;
DELETE FROM pt_price WHERE ticker_a = 'AEE' AND ticker_b = 'PEG';
DELETE FROM pt_price WHERE ticker_a = 'SPGI' AND ticker_b = 'VUG';
DELETE FROM pt_strtg_ma WHERE pt_id >= 22065;
COMMIT;
