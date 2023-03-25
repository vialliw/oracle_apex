-- PT_ANALYSIS2 Result of specified ID of final MA
SELECT MAX(ticker_a) ticker_a
, MAX(ticker_b) ticker_b
, TO_CHAR(MIN(data_time), 'YYYY/MM/DD HH24:MI:SS') period_from
, TO_CHAR(MAX(data_time), 'YYYY/MM/DD HH24:MI:SS') period_to
, COUNT( DECODE(Z_SCORE, NULL, 1, NULL) ) ma
, SUM(profit_loss) profit_loss_acc
, MIN(profit_loss) max_loss
, MAX(profit_loss) max_profit
, MIN(profit_loss_acc) max_drawdown
, COUNT( DECODE(SIGN(profit_loss), 1, 1, NULL) ) profit_cnt
, COUNT( DECODE(SIGN(profit_loss), -1, 1, NULL) ) loss_cnt
FROM pt_analysis3
WHERE id_no = :pi_id_no;

-- All results with CAGR
SELECT pt_reslt.id_no, pt_reslt.ticker_a, pt_reslt.ticker_b
       , pt_reslt.period_from, pt_reslt.period_to, pt_reslt.ma
       , pt_reslt.preset_stop_loss, pt_reslt.preset_take_profit
       , pt_reslt.preset_lot_amt, pt_reslt.profit_loss_acc
       , ROUND(pa_zfcc_07.get_cagr(preset_lot_amt, profit_loss_acc, period_from, period_to ),2) "CAGR(%)"
       , pt_reslt.max_loss
       , pt_reslt.max_profit, pt_reslt.max_drawdown
       , pt_reslt.profit_cnt
       , pt_reslt.loss_cnt
FROM pt_reslt
WHERE id_no = :pi_id_no
--ORDER BY id_no, ticker_a, ticker_b, ma;
ORDER BY pa_zfcc_07.get_cagr(preset_lot_amt, profit_loss_acc, period_from, period_to ) DESC;

-- Specific pair results of different MA with CAGR
SELECT pt_reslt.id_no, pt_reslt.ticker_a, pt_reslt.ticker_b
       , pt_reslt.period_from, pt_reslt.period_to, pt_reslt.ma
       , pt_reslt.preset_stop_loss
       , pt_reslt.preset_take_profit
       , - pt_reslt.preset_take_profit / pt_reslt.preset_stop_loss preset_pl_ratio
       , pt_reslt.preset_lot_amt, pt_reslt.profit_loss_acc
       , ROUND(pa_zfcc_07.get_cagr(preset_lot_amt, profit_loss_acc, period_from, period_to ),2) "CAGR(%)"
       , pt_reslt.max_loss
       , pt_reslt.max_profit, pt_reslt.max_drawdown
       , pt_reslt.profit_cnt
       , pt_reslt.loss_cnt
FROM pt_reslt
WHERE ticker_a = :pi_ticker_a
AND ticker_b = :pi_ticker_b
ORDER BY profit_loss_acc DESC
--ORDER BY pt_reslt.preset_take_profit
;

SELECT pt_reslt.ma
       , - pt_reslt.preset_stop_loss / preset_lot_amt * 100 risk_pct
       , ROUND(pa_zfcc_07.get_cagr(preset_lot_amt, profit_loss_acc, period_from, period_to ),2) "CAGR(%)"
FROM pt_reslt
WHERE ticker_a = :pi_ticker_a
AND ticker_b = :pi_ticker_b
ORDER BY profit_loss_acc DESC
;

SELECT pt_reslt.id_no, pt_reslt.ticker_a, pt_reslt.ticker_b
       , pt_reslt.period_from, pt_reslt.period_to, pt_reslt.ma
       , pt_reslt.preset_stop_loss
       , pt_reslt.preset_take_profit
       , - pt_reslt.preset_take_profit / pt_reslt.preset_stop_loss preset_pl_ratio
       , pt_reslt.preset_lot_amt, pt_reslt.profit_loss_acc
       , ROUND(pa_zfcc_07.get_cagr(preset_lot_amt, profit_loss_acc, period_from, period_to ),2) "CAGR(%)"
       , pt_reslt.max_loss
       , pt_reslt.max_profit, pt_reslt.max_drawdown
       , pt_reslt.profit_cnt
       , pt_reslt.loss_cnt
FROM pt_reslt
WHERE id_no = :pi_id_no
ORDER BY profit_loss_acc DESC;

SELECT id_no, ticker_a, ticker_b, count(1)
, MAX(ROUND(pa_zfcc_07.get_cagr(preset_lot_amt, profit_loss_acc, period_from, period_to ),2)) "MAX CAGR(%)"
, ROUND(AVG(pa_zfcc_07.get_cagr(preset_lot_amt, profit_loss_acc, period_from, period_to )),2) "AVG CAGR(%)"
, MIN(ROUND(pa_zfcc_07.get_cagr(preset_lot_amt, profit_loss_acc, period_from, period_to ),2)) "MIN CAGR(%)"
FROM pt_reslt
GROUP BY id_No, ticker_a, ticker_b
ORDER BY 6 DESC;

