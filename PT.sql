-- @c:\users\edvw\documents\trade\pt.sql
@DEVE
SET SERVEROUTPUT ON SIZE 1000000;
--SET SERVEROUTPUT OFF;
SET TRIMSPOOL ON;
SET ECHO ON;
SET FEEDBACK ON;
SET LINESIZE 2000;
SET TERM OFF;
SET TIME ON;
--@ON
SPOOL D:\prod_in\pt.LOG
DECLARE 
   l_rc PLS_INTEGER;
   ma_idx PLS_INTEGER;
   stop_loss_pct PLS_INTEGER;
   pl_ratio PLS_INTEGER;
   l_id_no  NUMBER(20) := 11;
   l_lot_amt NUMBER(15,2) := 2000;
   l_stop_loss_pct_fm CONSTANT SMALLINT := 5;
   l_stop_loss_pct_to CONSTANT SMALLINT := 5;
   l_ma_fm   CONSTANT SMALLINT := 39;
   l_ma_to   CONSTANT SMALLINT := 39;
   l_profit_loss_ratio_fm SMALLINT := 2;
   l_profit_loss_ratio_to SMALLINT := 2;
   l_stop_loss NUMBER(15,2);
   l_take_profit NUMBER(15,2);
BEGIN
   DELETE FROM pt_reslt WHERE id_no = l_id_no;
   FOR ma_idx IN l_ma_fm..l_ma_to LOOP
      FOR stop_loss_pct IN l_stop_loss_pct_fm..l_stop_loss_pct_to LOOP
	     FOR pl_ratio IN l_profit_loss_ratio_fm..l_profit_loss_ratio_to LOOP
         --DBMS_OUTPUT.PUT_LINE('ma = ' || ma_idx ||' stop_loss_pct = ' || stop_loss_pct ||' l_stop_loss = ' || l_stop_loss ||' l_take_profit = ' || l_take_profit );
         --DBMS_OUTPUT.PUT_LINE('ma = ' || ma_idx ||' stop_loss_pct = ' || stop_loss_pct);
         l_stop_loss := (l_lot_amt * stop_loss_pct / 100);
		 l_take_profit := ((l_lot_amt * stop_loss_pct / 100) * pl_ratio);
		 l_rc := pa_zfcc_07.pt_orchestra3( pi_id_no => l_id_no
                           , pi_ma => ma_idx
                           , pi_buy_threshold => -2
                           , pi_sell_threshold => 2
                           , pi_lot_amt => l_lot_amt
                           , pi_max_nof_lot => 1
                           , pi_stop_loss => - l_stop_loss
                           , pi_take_profit => l_take_profit
      			);
         --DBMS_OUTPUT.PUT_LINE('l_rc = ' || l_rc);
         --
         INSERT INTO pt_reslt
            (SELECT l_id_no id_no
            , MAX(ticker_a) ticker_a
            , MAX(ticker_b) ticker_b
            , MIN(data_time) period_from
            , MAX(data_time) period_to
            --, COUNT( DECODE(Z_SCORE, NULL, 1, NULL) ) ma
			, ma_idx ma
            , l_stop_loss preset_stop_loss 
            , l_take_profit preset_take_profit
            , l_lot_amt preset_log_amt 
            , SUM(profit_loss) profit_loss_acc
            , MIN(profit_loss) max_loss
            , MAX(profit_loss) max_profit
            , MIN(profit_loss_acc) max_drawdown
            , COUNT( DECODE(SIGN(profit_loss), 1, 1, NULL) ) profit_cnt
            , COUNT( DECODE(SIGN(profit_loss), -1, 1, NULL) ) loss_cnt
            FROM pt_analysis2
            WHERE id_no = l_id_no);
         COMMIT;
		 END LOOP;
      END LOOP;
   END LOOP;
EXCEPTION 
WHEN OTHERS THEN 
   DBMS_OUTPUT.PUT_LINE('OTHERS: ' || SQLERRM); 
   ROLLBACK;
END;
/
SPOOL OFF;
SET TERM ON;
