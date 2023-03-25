CREATE OR REPLACE PACKAGE BODY pa_zfcc_08 IS
   FUNC_ERROR EXCEPTION;
   FUNCTION pt_orchestra1( pi_id_no IN NUMBER
                        , pi_ma IN NUMBER := 30
                        , pi_buy_threshold IN NUMBER := -2
                        , pi_sell_threshold IN NUMBER := 2
                        , pi_lot_amt IN NUMBER := 2000
                        , pi_max_nof_lot IN NUMBER := 1
                        , pi_stop_loss IN NUMBER := -100
                        , pi_take_profit IN NUMBER := 200
                        ) RETURN NUMBER IS
   BEGIN
      RETURN NULL;
   END pt_orchestra1;
   --
   FUNCTION run_pt_sets( pi_id_no IN NUMBER -- Identify the pair
                        , pi_ma_fm IN NUMBER := 12
                        , pi_ma_to IN NUMBER := 63
                        , pi_buy_threshold IN NUMBER := -2
                        , pi_sell_threshold IN NUMBER := 2
                        , pi_lot_amt IN NUMBER := 2000
                        , pi_stop_loss IN NUMBER := -100
                        , pi_take_profit IN NUMBER := 200
                        , pi_max_nof_lot IN NUMBER := 1
                        ) RETURN NUMBER IS
      l_rc PLS_INTEGER;
      ma PLS_INTEGER;
   BEGIN
      DELETE FROM pt_reslt WHERE id_no = pi_id_no;
      FOR ma IN pi_ma_fm..pi_ma_to LOOP
         l_rc := pa_zfcc_07.pt_orchestra3( pi_id_no => pi_id_no
                           , pi_ma => ma
                           , pi_buy_threshold => pi_buy_threshold
                           , pi_sell_threshold => pi_sell_threshold
                           , pi_lot_amt => pi_lot_amt
                           , pi_max_nof_lot => pi_max_nof_lot
                           , pi_stop_loss => pi_max_nof_lot
                           , pi_take_profit => pi_take_profit
      			);
         IF l_rc != 0 THEN
            RAISE FUNC_ERROR;
         END IF;
      END LOOP;
      RETURN NULL;
   EXCEPTION
   WHEN FUNC_ERROR THEN
      DBMS_OUTPUT.PUT_LINE('FUNC_ERROR l_rc = ' || l_rc
                           || ' pi_id_no = ' || pi_id_no
                           || ' ma = ' || ma
                           || ' pi_buy_threshold = ' || pi_buy_threshold
                           || ' pi_sell_threshold = ' || pi_sell_threshold
                           || ' pi_lot_amt = ' || pi_lot_amt
                           || ' pi_max_nof_lot = ' || pi_max_nof_lot
                           || ' pi_take_profit = ' || pi_take_profit
                           );
      RETURN -2;
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('OTHERS l_rc = ' || l_rc
                           || ' pi_id_no = ' || pi_id_no
                           || ' ma = ' || ma
                           || ' pi_buy_threshold = ' || pi_buy_threshold
                           || ' pi_sell_threshold = ' || pi_sell_threshold
                           || ' pi_lot_amt = ' || pi_lot_amt
                           || ' pi_max_nof_lot = ' || pi_max_nof_lot
                           || ' pi_take_profit = ' || pi_take_profit
                           || ' ' || SQLERRM
                           );
      RETURN -1;
   END run_pt_sets;
END;
/
