DECLARE
BEGIN
   pa_pt_01.run_back_test_set(pi_ticker_a => 'NKE'
                     , pi_ticker_b => 'VOT'
                     , pi_lot_amt => 2000
                     , pi_max_nof_lot => 1
                     , pi_stop_loss_pct_fm => -60
                     , pi_stop_loss_pct_to => 180
                     , pi_ma_fm => 20
                     , pi_ma_to => 20
                     , pi_profit_loss_ratio_fm => 5
                     , pi_profit_loss_ratio_to => 5
                     );
   COMMIT;
END;
/
