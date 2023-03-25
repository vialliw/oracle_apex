ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
set serveroutput on size 1000000;
DECLARE
   l_cnt   PLS_INTEGER := 0;
   l_preset_lot_amt pt_strtg_ma.preset_lot_amt%TYPE := 2000;
   l_ptm_rc pt_strtg_ma%ROWTYPE;
   TYPE ptm_varray IS VARRAY(250) OF pt_strtg_ma%ROWTYPE;
   PT_strategy_ma ptm_varray := ptm_varray();
   l_error_count   PLS_INTEGER;
   ma_idx pls_integer;
   pl_ratio_idx pls_integer;
   stop_loss_idx pls_integer;
   ex_dml_errors EXCEPTION;
      PRAGMA EXCEPTION_INIT(ex_dml_errors, -24381);
BEGIN
    FOR ma_idx IN 12..60 LOOP -- MA
        IF MOD(ma_idx,2) = 0 THEN
            FOR pl_ratio_idx IN 2..3 LOOP -- P/L ratio
                FOR stop_loss_idx IN 2..10 LOOP
                    IF MOD(stop_loss_idx,2) = 0 THEN -- Stop loss percent
                        l_ptm_rc.ticker_a := 'A';
                        l_ptm_rc.ticker_b := 'BMY';
                        l_ptm_rc.ma := ma_idx;
                        l_ptm_rc.preset_stop_loss := -(l_preset_lot_amt * stop_loss_idx / 100);
                        l_ptm_rc.preset_take_profit := ABS(l_ptm_rc.preset_stop_loss) * pl_ratio_idx;
                        l_ptm_rc.preset_lot_amt := l_preset_lot_amt;
                        l_cnt := l_cnt + 1;
                        PT_strategy_ma.extend;
                        PT_strategy_ma(l_cnt) := l_ptm_rc;
                        /* DBMS_OUTPUT.PUT_LINE('l_cnt = ' || l_cnt || ' MA = ' || ma_idx ||' P/L ratio = ' || pl_ratio_idx ||' Stop loss pct = ' || stop_loss_idx 
                        ||' preset_stop_loss = ' || -(l_preset_lot_amt * stop_loss_idx / 100)
                        ||' preset_take_profit = ' || (l_preset_lot_amt * stop_loss_idx / 100) * pl_ratio_idx
                        ); */
                    END IF;
                END LOOP stop_loss_pct;
            END LOOP profit_loss_ratio;
        END IF;
    END LOOP ma;
    FORALL ma_idx IN 1..PT_strategy_ma.COUNT SAVE EXCEPTIONS
        INSERT INTO pt_strtg_ma(ticker_a, ticker_b, ma, preset_stop_loss, preset_take_profit, preset_lot_amt)
            VALUES (PT_strategy_ma(ma_idx).ticker_a, PT_strategy_ma(ma_idx).ticker_b, PT_strategy_ma(ma_idx).ma, PT_strategy_ma(ma_idx).preset_stop_loss, PT_strategy_ma(ma_idx).preset_take_profit, PT_strategy_ma(ma_idx).preset_lot_amt);
   DBMS_OUTPUT.PUT_LINE(SQLERRM);
EXCEPTION
WHEN ex_dml_errors THEN
      l_error_count := SQL%BULK_EXCEPTIONS.count;
      DBMS_OUTPUT.put_line('Number of failures: ' || l_error_count);
      FOR i IN 1 .. l_error_count LOOP
        DBMS_OUTPUT.put_line('Error: ' || i ||
          ' Array Index: ' || SQL%BULK_EXCEPTIONS(i).error_index ||
          ' Message: ' || SQLERRM(-SQL%BULK_EXCEPTIONS(i).ERROR_CODE));
      END LOOP;
WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/

TRUNCATE TABLE pt_strtg_ma;

SELECT COUNT(1) FROM pt_strtg_ma;

SELECT * FROM pt_strtg_ma;

DELETE FROM pt_strtg_ma WHERE pt_strtg_ma.preset_stop_loss = -160;

commit;
