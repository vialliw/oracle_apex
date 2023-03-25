CREATE OR REPLACE PACKAGE pa_zfcc_06 IS
   FUNCTION gen_zfcc_upload (pi_val_dt DATE := NULL) RETURN NUMBER;
   FUNCTION gen_zfcc_nb (pi_val_dt DATE := NULL) RETURN NUMBER;
   FUNCTION gen_zfcc_cncl (pi_val_dt DATE := NULL) RETURN NUMBER;
   FUNCTION gen_zfcc_renew (pi_val_dt DATE := NULL) RETURN NUMBER;
   FUNCTION spool_text_file RETURN NUMBER;
   FUNCTION mth_clos_price( pi_opt_cde IN VARCHAR2, pi_val_dt IN DATE ) RETURN NUMBER;
   FUNCTION stock_clos_price( pi_opt_cde IN VARCHAR2, pi_val_dt IN DATE ) RETURN NUMBER;
   FUNCTION setl_price( pi_opt_cde IN VARCHAR2, pi_val_dt IN DATE
               , pi_cont_mth IN VARCHAR2, pi_strike IN NUMBER, pi_call_put IN VARCHAR2 ) RETURN NUMBER;
   FUNCTION most_vol_strike(pi_opt_cde IN VARCHAR2, pi_val_dt IN DATE, pi_call_put IN VARCHAR2) RETURN NUMBER;
   FUNCTION opt_day_rank(pi_rpt_dt IN DATE, pi_opt_cde IN VARCHAR2) RETURN NUMBER;
   FUNCTION get_atm( pi_price IN NUMBER ) RETURN NUMBER;
   FUNCTION get_open_strike(pi_opt_cde IN VARCHAR2, pi_val_dt IN DATE, pi_cont_mth IN VARCHAR2, pi_call_put IN VARCHAR2, pi_itm_pct IN NUMBER) RETURN NUMBER;
   FUNCTION get_vol(pi_cde IN VARCHAR2) RETURN NUMBER;
   FUNCTION DECALSHORT( pi_opt_cde IN VARCHAR2, pi_val_dt IN DATE ) RETURN NUMBER;
   FUNCTION DECALOPT1( pi_opt_cde IN VARCHAR2, pi_cont_mth IN VARCHAR2, pi_call_put IN VARCHAR2 ) RETURN NUMBER;
   FUNCTION run_rpt3(pi_long_cde IN VARCHAR2
                  , pi_long_vol IN NUMBER
                  , pi_shrt_cde IN VARCHAR2
                  , pi_shrt_vol IN NUMBER
                  , pi_cont_mth IN VARCHAR2
                  , pi_start_dt IN DATE
                  , pi_itm_pct IN NUMBER) RETURN NUMBER;
   FUNCTION run_rpt4(pi_long_cde IN VARCHAR2
                  , pi_long_vol IN NUMBER
                  , pi_shrt_cde IN VARCHAR2
                  , pi_shrt_vol IN NUMBER
                  , pi_cont_mth IN VARCHAR2
                  , pi_start_dt IN DATE
                  , pi_itm_pct IN NUMBER
                  , pi_max_nof_cont IN NUMBER := 20
                  , pi_min_cost IN NUMBER := 7000) RETURN NUMBER;
   FUNCTION run_rpt4_update(pi_long_cde IN VARCHAR2
                  , pi_long_vol IN NUMBER
                  , pi_shrt_cde IN VARCHAR2
                  , pi_shrt_vol IN NUMBER
                  , pi_cont_mth IN VARCHAR2
                  , pi_start_dt IN DATE
                  , pi_itm_pct IN NUMBER) RETURN NUMBER;
   FUNCTION run_rpt4_hdr(pi_start_dt IN DATE := NULL) RETURN NUMBER;
   FUNCTION run_rpt4_detl(pi_start_dt IN DATE := NULL) RETURN NUMBER;
   FUNCTION run_dbl_shrt(pi_call_cde IN VARCHAR2
                       , pi_put_cde IN VARCHAR2
                       , pi_cont_mth IN VARCHAR2
                       , pi_start_dt IN DATE
                       , pi_itm_pct IN NUMBER
                       , pi_max_nof_cont IN NUMBER := 10
                       , pi_max_prem_amt IN NUMBER := 5000) RETURN NUMBER;
   PROCEDURE upd_vol_rank( pi_rpt_dt IN DATE := NULL );
   TYPE rpt_vol_chg_typ IS RECORD ( rpt_dt            DATE
                                  , opt_cde           VARCHAR2(5)
                                  , stock_clos_price  hist#_mkt_data.stock_clos_price%TYPE
                                  , vol_all           hist#_mkt_data.vol%TYPE
                                  , vol_call          hist#_mkt_data.vol%TYPE
                                  , vol_put           hist#_mkt_data.vol%TYPE
                                  , vol_pct           NUMBER(8,5)
                                  , oi                hist#_mkt_data.open_interest%TYPE
                                  );
   TYPE rpt_vol_chg_cv IS REF CURSOR RETURN rpt_vol_chg_typ;
   PROCEDURE rpt_vol_chg( -- Option volumn change over time of specific option code
      pi_opt_cde IN VARCHAR2
      , pi_min_vol_pct IN NUMBER := 10 -- Default 10%
      , pio_ref_cr IN OUT rpt_vol_chg_cv);
   PROCEDURE get_lcm_cont(pi_max_nof_cont IN NUMBER, pi_hand_a IN NUMBER, pi_hand_b IN NUMBER
                        , po_nof_a OUT NUMBER, po_nof_b OUT NUMBER);
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
END;
/
