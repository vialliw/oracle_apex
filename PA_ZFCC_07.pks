CREATE OR REPLACE PACKAGE pa_zfcc_07 IS
   FUNCTION import_aqh( pi_filename IN VARCHAR2 ) RETURN NUMBER;
   FUNCTION put_pairs_data2(pi_ticker_a IN VARCHAR2, pi_ticker_b IN VARCHAR2) RETURN NUMBER;
   PROCEDURE rawdata_set_seq_num( pi_ticker IN VARCHAR2 );
   FUNCTION mtm( pi_open IN NUMBER, pi_close IN NUMBER, pi_open_vol IN NUMBER ) RETURN NUMBER;
   PROCEDURE get_best_pair_vols(pi_price_a IN NUMBER
                     , pi_price_b IN NUMBER
                     , pi_lot_amt IN NUMBER -- lot size e.g.)2,000
                     , po_vol_a OUT NUMBER -- best vol size of ticker a
                     , po_vol_b OUT NUMBER -- best vol size of ticker b
                     );
   PROCEDURE get_best_pair_vols2(pi_price_a IN NUMBER
                     , pi_price_b IN NUMBER
                     , pi_lot_amt IN NUMBER -- lot size e.g.)2,000
                     , po_vol_a OUT NUMBER -- best vol size of ticker a
                     , po_vol_b OUT NUMBER -- best vol size of ticker b
                     );
   FUNCTION get_pct_chg(pi_open IN NUMBER, pi_close IN NUMBER) RETURN NUMBER;
   FUNCTION get_cagr(pi_initial_amt IN NUMBER, pi_final_profit_loss_amt IN NUMBER, pi_start_dt IN DATE, pi_end_dt IN DATE) RETURN NUMBER;
   FUNCTION pt_orchestra( pi_id_no IN NUMBER
                        , pi_ma IN NUMBER := 30
                        , pi_buy_threshold IN NUMBER := -2
                        , pi_sell_threshold IN NUMBER := 2
                        , pi_lot_amt IN NUMBER := 2000
                        , pi_max_nof_lot IN NUMBER := 1
                        , pi_stop_loss IN NUMBER := -100
                        , pi_take_profit IN NUMBER := 200
                        ) RETURN NUMBER;
   FUNCTION pt_orchestra2( pi_id_no IN NUMBER
                        , pi_ma IN NUMBER := 30
                        , pi_buy_threshold IN NUMBER := -2
                        , pi_sell_threshold IN NUMBER := 2
                        , pi_lot_amt IN NUMBER := 2000
                        , pi_max_nof_lot IN NUMBER := 1
                        , pi_stop_loss IN NUMBER := -100
                        , pi_take_profit IN NUMBER := 200
                        ) RETURN NUMBER;
   FUNCTION pt_orchestra3( pi_id_no IN NUMBER
                        , pi_ma IN NUMBER := 30
                        , pi_buy_threshold IN NUMBER := -2
                        , pi_sell_threshold IN NUMBER := 2
                        , pi_lot_amt IN NUMBER := 2000
                        , pi_max_nof_lot IN NUMBER := 1
                        , pi_stop_loss IN NUMBER := -100
                        , pi_take_profit IN NUMBER := 200
                        ) RETURN NUMBER;
   PROCEDURE pt_analy(pi_ticker_a IN VARCHAR2, pi_ticker_b IN VARCHAR2);
END;
/
