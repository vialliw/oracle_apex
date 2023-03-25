SELECT */*seq_no
, data_time
, ticker_a
, adj_close_a
, ticker_b
, adj_close_b
, z_score
, signal
, tx_price_a, tx_vol_a, tx_amt_a, tx_price_b, tx_vol_b, tx_amt_b, mtm, sts, profit_loss, profit_loss_acc
*/ 
FROM pt_analysis3
WHERE id_no = :pi_id_no 
--AND seq_no > 30
--AND z_score IS NOT NULL
--AND profit_loss != 0
ORDER BY seq_no;
