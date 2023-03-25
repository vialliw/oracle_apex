create or replace PACKAGE pa_pt IS
   FUNCTION merge_price(pi_ticker_a IN VARCHAR2, pi_ticker_b IN VARCHAR2) RETURN NUMBER;
   FUNCTION back_test( pi_id_no IN NUMBER
                        , pi_ma IN NUMBER := 30
                        , pi_buy_threshold IN NUMBER := -2
                        , pi_sell_threshold IN NUMBER := 2
                        , pi_lot_amt IN NUMBER := 2000
                        , pi_max_nof_lot IN NUMBER := 1
                        , pi_stop_loss IN NUMBER := -100
                        , pi_take_profit IN NUMBER := 200
                        ) RETURN NUMBER;
   PROCEDURE run_back_test_set(pi_ticker_a IN VARCHAR2
                     , pi_ticker_b IN VARCHAR2
                     , pi_lot_amt IN NUMBER
                     , pi_max_nof_lot IN NUMBER
                     , pi_stop_loss_pct_fm IN NUMBER
                     , pi_stop_loss_pct_to IN NUMBER
                     , pi_ma_fm IN NUMBER
                     , pi_ma_to IN NUMBER
                     , pi_profit_loss_ratio_fm IN NUMBER
                     , pi_profit_loss_ratio_to IN NUMBER
                     );
   PROCEDURE run_back_test_set(pi_ticker_a IN VARCHAR2, pi_ticker_b IN VARCHAR2);
END;
/
