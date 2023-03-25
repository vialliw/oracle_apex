create or replace PACKAGE BODY pa_pt_01 IS
   FUNCTION merge_price(pi_ticker_a IN VARCHAR2, pi_ticker_b IN VARCHAR2) RETURN NUMBER IS
      -- Merge price_data of ticker A and B to pt_analysis3
      -- When successful, return new id_no.
      -- When error, return -1.
      l_id_no   pt_analysis3.id_no%TYPE;
      l_cnt    PLS_INTEGER := 0;
      INSRT_NOTHING EXCEPTION;
      CURSOR price_cr IS
         SELECT l_id_no id_no
                , a.data_date data_time, a.ticker ticker_a, b.ticker ticker_b
                , a.OPEN open_a, a.high high_a, a.low low_a, a.CLOSE close_a, a.adj_close adj_close_a, a.volume vol_a
                , b.OPEN open_b, b.high high_b, b.low low_b, b.CLOSE close_b, b.adj_close adj_close_b, b.volume vol_b
                , LN(a.adj_close / b.adj_close) l_idx
         FROM price_data a, price_data b
         WHERE a.data_date = b.data_date 
         AND a.ticker = pi_ticker_a 
         AND b.ticker = pi_ticker_b
         AND a.bar_size = 'EOD'
         AND b.bar_size = 'EOD'
         ORDER BY a.data_date;
   BEGIN
      -- Get new id_no
      --SELECT NVL(MAX(id_no), 0) + 1 INTO l_id_no FROM pt_analysis3;
      SELECT pt_analysis_seq.NEXTVAL INTO l_id_no FROM dual;
      -- Ensure sequence number increment 1 throughout the set
      FOR rc IN price_cr LOOP
         l_cnt := price_cr%ROWCOUNT;
         INSERT INTO pt_analysis3
               (id_no, seq_no,
                data_time, ticker_a, ticker_b,
                open_a, high_a, low_a, close_a, adj_close_a, vol_a,
                open_b, high_b, low_b, close_b, adj_close_b, vol_b,
                l_idx
               ) VALUES (rc.id_no, l_cnt,
                rc.data_time, rc.ticker_a, rc.ticker_b,
                rc.open_a, rc.high_a, rc.low_a, rc.close_a, rc.adj_close_a, rc.vol_a,
                rc.open_b, rc.high_b, rc.low_b, rc.close_b, rc.adj_close_b, rc.vol_b,
                rc.l_idx);
      END LOOP;
      /*-- Insert in one go, but not sure the sequence number guarantees order by data_date!
      INSERT INTO pt_analysis3
            (id_no, seq_no,
             data_time, ticker_a, ticker_b,
             open_a, high_a, low_a, close_a, adj_close_a, vol_a,
             open_b, high_b, low_b, close_b, adj_close_b, vol_b,
             l_idx
            )
            (SELECT l_id_no id_no, TO_NUMBER(TO_CHAR(a.data_date,'YYYYMMDDHH24MISS')) seq_no
                    , a.data_date data_time, a.ticker ticker_a, b.ticker ticker_b
                    , a.OPEN open_a, a.high high_a, a.low low_a, a.CLOSE close_a, a.adj_close adj_close_a, a.volume vol_a
                    , b.OPEN open_b, b.high high_b, b.low low_b, b.CLOSE close_b, b.adj_close adj_close_b, b.volume vol_b
                    , LN(a.adj_close / b.adj_close)
             FROM price_data a, price_data b
             WHERE a.data_date = b.data_date 
             AND a.ticker = pi_ticker_a 
             AND b.ticker = pi_ticker_b
            );
      --DBMS_OUTPUT.PUT_LINE('SQL%ROWCOUNT = '||SQL%ROWCOUNT);*/
      IF l_cnt = 0 THEN
         RAISE INSRT_NOTHING;
      END IF;
      RETURN l_id_no;
   EXCEPTION
   WHEN OTHERS THEN
      RETURN -1;
   END merge_price;
   --
   FUNCTION back_test( pi_id_no IN NUMBER
                        , pi_ma IN NUMBER := 30
                        , pi_buy_threshold IN NUMBER := -2
                        , pi_sell_threshold IN NUMBER := 2
                        , pi_lot_amt IN NUMBER := 2000
                        , pi_max_nof_lot IN NUMBER := 1
                        , pi_stop_loss IN NUMBER := -100
                        , pi_take_profit IN NUMBER := 200
                        ) RETURN NUMBER IS
   l_working1   NUMBER;
   l_working2   NUMBER;
   CURSOR navigate_cr IS
      SELECT *
      FROM pt_analysis3
      WHERE id_no = pi_id_no
      AND seq_no > pi_ma
      ORDER BY seq_no -- must
      FOR UPDATE OF l_idx_avg, l_idx_stdev, tx_price_a, tx_vol_a, tx_amt_a, tx_price_b, tx_vol_b, tx_amt_a, mtm, sts, profit_loss, profit_loss_acc;
   l_tmp_rec   navigate_cr%ROWTYPE;
   BEGIN
      -- Clean
      UPDATE pt_analysis3
      SET l_idx_avg = NULL
      , l_idx_stdev = NULL
      , z_score = NULL
      , signal = NULL
      , tx_price_a = NULL
      , tx_vol_a = NULL
      , tx_amt_a = NULL
      , tx_price_b = NULL
      , tx_vol_b = NULL
      , tx_amt_b = NULL
      , mtm = NULL
      , sts = 'CLOSED'
      , profit_loss = 0
      , profit_loss_acc = 0
      WHERE id_no = pi_id_no;
      -- Calculate MA, aka l(0) Average, and STDEV
      FOR rc IN navigate_cr LOOP
         l_working1 := NULL;
         l_working2 := NULL;
         SELECT AVG(l_idx), STDDEV(l_idx)
         INTO l_working1, l_working2
         FROM pt_analysis3
         WHERE id_no = pi_id_no
         AND seq_no BETWEEN (rc.seq_no - pi_ma) AND (rc.seq_no - 1);
         --
         IF l_working1 IS NOT NULL THEN
            UPDATE pt_analysis3
               SET l_idx_avg = l_working1
               , l_idx_stdev = l_working2
               WHERE CURRENT OF navigate_cr;
         END IF;
      END LOOP;
      -- Calculate Z-SCORE
      UPDATE pt_analysis3
          SET z_score = (l_idx - l_idx_avg) / l_idx_stdev
          WHERE id_no = pi_id_no
          AND seq_no > pi_ma;
      -- Determine signal
      UPDATE pt_analysis3
         SET signal = DECODE(SIGN(z_score - pi_buy_threshold), -1, 'BUY', DECODE(SIGN(z_score - pi_sell_threshold), 1, 'SELL'))
         WHERE id_no = pi_id_no
         AND z_score IS NOT NULL;
      -- Buy/Sell
      FOR rc IN navigate_cr LOOP
         --~ DBMS_OUTPUT.PUT_LINE(rc.seq_no ||'; prev sts='|| l_tmp_rec.sts ||'; current signal='|| rc.signal);
         -- Open position
         IF NVL(l_tmp_rec.sts, 'CLOSED') = 'CLOSED' THEN -- No opened position
            IF rc.signal = 'BUY' THEN
               l_tmp_rec.tx_price_a := rc.adj_close_a;
               pa_zfcc_07.get_best_pair_vols2(pi_price_a => rc.adj_close_a
                     , pi_price_b => rc.adj_close_b
                     , pi_lot_amt => pi_lot_amt
                     , po_vol_a => l_tmp_rec.tx_vol_a
                     , po_vol_b => l_tmp_rec.tx_vol_b
                     );
               l_tmp_rec.tx_vol_a := l_tmp_rec.tx_vol_a;
               l_tmp_rec.tx_amt_a := l_tmp_rec.tx_price_a * l_tmp_rec.tx_vol_a;
               l_tmp_rec.tx_price_b := rc.adj_close_b;
               l_tmp_rec.tx_vol_b := - l_tmp_rec.tx_vol_b;
               l_tmp_rec.tx_amt_b := l_tmp_rec.tx_price_b * l_tmp_rec.tx_vol_b;
               l_tmp_rec.mtm := pa_zfcc_07.mtm( l_tmp_rec.tx_price_a, rc.adj_close_a, l_tmp_rec.tx_vol_a ) + pa_zfcc_07.mtm( l_tmp_rec.tx_price_b, rc.adj_close_b, l_tmp_rec.tx_vol_b );
               l_tmp_rec.profit_loss := 0;
               l_tmp_rec.signal := 'BUY';
               l_tmp_rec.sts := 'BOUGHT';
            ELSIF rc.signal = 'SELL' THEN
               l_tmp_rec.tx_price_a := rc.adj_close_a;
               pa_zfcc_07.get_best_pair_vols2(pi_price_a => rc.adj_close_a
                     , pi_price_b => rc.adj_close_b
                     , pi_lot_amt => pi_lot_amt
                     , po_vol_a => l_tmp_rec.tx_vol_a
                     , po_vol_b => l_tmp_rec.tx_vol_b
                     );
               l_tmp_rec.tx_vol_a := - l_tmp_rec.tx_vol_a;
               l_tmp_rec.tx_amt_a := l_tmp_rec.tx_price_a * l_tmp_rec.tx_vol_a;
               l_tmp_rec.tx_price_b := rc.adj_close_b;
               l_tmp_rec.tx_vol_b := l_tmp_rec.tx_vol_b;
               l_tmp_rec.tx_amt_b := l_tmp_rec.tx_price_b * l_tmp_rec.tx_vol_b;
               l_tmp_rec.mtm := pa_zfcc_07.mtm( l_tmp_rec.tx_price_a, rc.adj_close_a, l_tmp_rec.tx_vol_a ) + pa_zfcc_07.mtm( l_tmp_rec.tx_price_b, rc.adj_close_b, l_tmp_rec.tx_vol_b );
               l_tmp_rec.profit_loss := 0;
               l_tmp_rec.signal := 'SELL';
               l_tmp_rec.sts := 'SOLD';
            ELSE -- No signal
               l_tmp_rec.profit_loss := 0;
            END IF;
         ELSIF l_tmp_rec.sts != 'CLOSED' THEN -- Has opened position
            IF rc.signal = 'BUY' AND l_tmp_rec.sts = 'SOLD' THEN -- buy to close
               -- Calculate mtm before calculating l_tmp_rec.tx_amt_a and l_tmp_rec.tx_amt_b
               l_tmp_rec.mtm := pa_zfcc_07.mtm( l_tmp_rec.tx_price_a, rc.adj_close_a, l_tmp_rec.tx_vol_a ) + pa_zfcc_07.mtm( l_tmp_rec.tx_price_b, rc.adj_close_b, l_tmp_rec.tx_vol_b );
               l_tmp_rec.tx_price_a := rc.adj_close_a;
               l_tmp_rec.tx_vol_a := - l_tmp_rec.tx_vol_a;
               l_tmp_rec.tx_amt_a := l_tmp_rec.tx_price_a * l_tmp_rec.tx_vol_a;
               l_tmp_rec.tx_price_b := rc.adj_close_b;
               l_tmp_rec.tx_vol_b := - l_tmp_rec.tx_vol_b;
               l_tmp_rec.tx_amt_b := l_tmp_rec.tx_price_b * l_tmp_rec.tx_vol_b;
               l_tmp_rec.profit_loss := l_tmp_rec.mtm;
               l_tmp_rec.signal := 'BUY';
               l_tmp_rec.sts := 'CLOSED';
            ELSIF rc.signal = 'SELL' AND l_tmp_rec.sts = 'BOUGHT' THEN -- sell to close
               -- Calculate mtm before calculating l_tmp_rec.tx_amt_a and l_tmp_rec.tx_amt_b
               l_tmp_rec.mtm := pa_zfcc_07.mtm( l_tmp_rec.tx_price_a, rc.adj_close_a, l_tmp_rec.tx_vol_a ) + pa_zfcc_07.mtm( l_tmp_rec.tx_price_b, rc.adj_close_b, l_tmp_rec.tx_vol_b );
               l_tmp_rec.tx_price_a := rc.adj_close_a;
               l_tmp_rec.tx_vol_a := - l_tmp_rec.tx_vol_a;
               l_tmp_rec.tx_amt_a := l_tmp_rec.tx_price_a * l_tmp_rec.tx_vol_a;
               l_tmp_rec.tx_price_b := rc.adj_close_b;
               l_tmp_rec.tx_vol_b := - l_tmp_rec.tx_vol_b;
               l_tmp_rec.tx_amt_b := l_tmp_rec.tx_price_b * l_tmp_rec.tx_vol_b;
               l_tmp_rec.profit_loss := l_tmp_rec.mtm;
               l_tmp_rec.signal := 'SELL';
               l_tmp_rec.sts := 'CLOSED';
            ELSIF rc.signal IS NULL AND l_tmp_rec.sts = 'SOLD' THEN -- buy to close for stop loss/ take profit cases
               -- Calculate mtm before calculating l_tmp_rec.tx_amt_a and l_tmp_rec.tx_amt_b
               l_tmp_rec.mtm := pa_zfcc_07.mtm( l_tmp_rec.tx_price_a, rc.adj_close_a, l_tmp_rec.tx_vol_a ) + pa_zfcc_07.mtm( l_tmp_rec.tx_price_b, rc.adj_close_b, l_tmp_rec.tx_vol_b );
               IF l_tmp_rec.mtm > pi_take_profit OR l_tmp_rec.mtm < pi_stop_loss THEN
                  l_tmp_rec.tx_price_a := rc.adj_close_a;
                  l_tmp_rec.tx_vol_a := - l_tmp_rec.tx_vol_a;
                  l_tmp_rec.tx_amt_a := l_tmp_rec.tx_price_a * l_tmp_rec.tx_vol_a;
                  l_tmp_rec.tx_price_b := rc.adj_close_b;
                  l_tmp_rec.tx_vol_b := - l_tmp_rec.tx_vol_b;
                  l_tmp_rec.tx_amt_b := l_tmp_rec.tx_price_b * l_tmp_rec.tx_vol_b;
                  l_tmp_rec.profit_loss := l_tmp_rec.mtm;
                  l_tmp_rec.signal := 'BUY';
                  l_tmp_rec.sts := 'CLOSED';
               ELSE
                  l_tmp_rec.profit_loss := 0;
               END IF;
            ELSIF rc.signal IS NULL AND l_tmp_rec.sts = 'BOUGHT' THEN -- sell to close for stop loss/ take profit cases
               -- Calculate mtm before calculating l_tmp_rec.tx_amt_a and l_tmp_rec.tx_amt_b
               l_tmp_rec.mtm := pa_zfcc_07.mtm( l_tmp_rec.tx_price_a, rc.adj_close_a, l_tmp_rec.tx_vol_a ) + pa_zfcc_07.mtm( l_tmp_rec.tx_price_b, rc.adj_close_b, l_tmp_rec.tx_vol_b );
               IF l_tmp_rec.mtm > pi_take_profit OR l_tmp_rec.mtm < pi_stop_loss THEN
                  l_tmp_rec.tx_price_a := rc.adj_close_a;
                  l_tmp_rec.tx_vol_a := - l_tmp_rec.tx_vol_a;
                  l_tmp_rec.tx_amt_a := l_tmp_rec.tx_price_a * l_tmp_rec.tx_vol_a;
                  l_tmp_rec.tx_price_b := rc.adj_close_b;
                  l_tmp_rec.tx_vol_b := - l_tmp_rec.tx_vol_b;
                  l_tmp_rec.tx_amt_b := l_tmp_rec.tx_price_b * l_tmp_rec.tx_vol_b;
                  l_tmp_rec.profit_loss := l_tmp_rec.mtm;
                  l_tmp_rec.signal := 'SELL';
                  l_tmp_rec.sts := 'CLOSED';
               ELSE
                  l_tmp_rec.profit_loss := 0;
               END IF;
            ELSE -- No signal
               l_tmp_rec.profit_loss := 0;
            END IF;
         END IF;
         IF l_tmp_rec.sts IN ('BOUGHT','SOLD','CLOSED') OR rc.signal IN ('BUY','SELL') THEN
            UPDATE pt_analysis3
               SET tx_price_a = l_tmp_rec.tx_price_a
               , tx_vol_a = l_tmp_rec.tx_vol_a
               , tx_amt_a = l_tmp_rec.tx_amt_a
               , tx_price_b = l_tmp_rec.tx_price_b 
               , tx_vol_b = l_tmp_rec.tx_vol_b
               , tx_amt_b = l_tmp_rec.tx_amt_b
               , mtm = DECODE(l_tmp_rec.sts, 'CLOSED', l_tmp_rec.mtm
                                           , pa_zfcc_07.mtm( l_tmp_rec.tx_price_a, rc.adj_close_a, l_tmp_rec.tx_vol_a ) + pa_zfcc_07.mtm( l_tmp_rec.tx_price_b, rc.adj_close_b, l_tmp_rec.tx_vol_b ))
               , sts = l_tmp_rec.sts
               , profit_loss = l_tmp_rec.profit_loss
               WHERE CURRENT OF navigate_cr;
         END IF;
      END LOOP;
      -- Calculate accumulated profit/loss
      l_tmp_rec := NULL;
      FOR rc IN navigate_cr LOOP
         l_tmp_rec.profit_loss_acc := NVL(l_tmp_rec.profit_loss_acc, 0) + NVL(rc.profit_loss, 0);
         UPDATE pt_analysis3
            SET profit_loss_acc = l_tmp_rec.profit_loss_acc
            WHERE CURRENT OF navigate_cr;
      END LOOP;
      RETURN 0;
   END back_test;
   
   /*FUNCTION back_test( pi_id_no IN NUMBER
                        , pi_ma IN NUMBER := 30
                        , pi_buy_threshold IN NUMBER := -2
                        , pi_sell_threshold IN NUMBER := 2
                        , pi_lot_amt IN NUMBER := 2000
                        , pi_max_nof_lot IN NUMBER := 1
                        , pi_stop_loss IN NUMBER := -100
                        , pi_take_profit IN NUMBER := 200
                        ) RETURN NUMBER IS
      l_id_no   pt_analysis3.id_no%TYPE;
   BEGIN
      l_id_no := merge_price( LEAST(pi_ticker_a, pi_ticker_b), GREATEST(pi_ticker_a, pi_ticker_b) );
      RETURN l_id_no;
   END;*/
   --
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
                     ) IS
      c_ticker_a CONSTANT pt_analysis3.ticker_a%TYPE := LEAST(pi_ticker_a, pi_ticker_b);
      c_ticker_b CONSTANT pt_analysis3.ticker_b%TYPE := GREATEST(pi_ticker_a, pi_ticker_b);
      l_rc PLS_INTEGER;
      l_id_no  pt_analysis3.id_no%TYPE;
      ma_idx PLS_INTEGER;
      stop_loss_pct PLS_INTEGER;
      pl_ratio PLS_INTEGER;
      l_stop_loss NUMBER(15,2);
      l_take_profit NUMBER(15,2);
      PUT_DATA_ERR EXCEPTION;
      ANALY_PARAM_ERR EXCEPTION;
   BEGIN
      -- DBMS_OUTPUT.PUT_LINE('Ticker a = ' || c_ticker_a || '; Ticker b = ' || c_ticker_b);
      -- Prepare price data
      l_id_no := merge_price(c_ticker_a, c_ticker_b);
      -- DBMS_OUTPUT.PUT_LINE('id_no = ' || l_id_no );
      IF l_id_no <= 0 THEN
         RAISE PUT_DATA_ERR;
      END IF;
      -- Run analysis and save results
      --DELETE FROM pt_reslt WHERE id_no = l_id_no;
      FOR ma_idx IN pi_ma_fm..pi_ma_to LOOP
         FOR stop_loss_pct IN pi_stop_loss_pct_fm..pi_stop_loss_pct_to LOOP
            FOR pl_ratio IN pi_profit_loss_ratio_fm..pi_profit_loss_ratio_to LOOP
               l_stop_loss := - (pi_lot_amt * stop_loss_pct / 100);
               l_take_profit := ((pi_lot_amt * stop_loss_pct / 100) * pl_ratio);
               l_rc := back_test( pi_id_no => l_id_no
                           , pi_ma => ma_idx
                           , pi_buy_threshold => -2
                           , pi_sell_threshold => 2
                           , pi_lot_amt => pi_lot_amt
                           , pi_max_nof_lot => pi_max_nof_lot
                           , pi_stop_loss => l_stop_loss
                           , pi_take_profit => l_take_profit
      			);
               IF l_rc != 0 THEN
                  RAISE ANALY_PARAM_ERR;
               END IF;
               BEGIN
                  INSERT INTO pt_reslt
                     (SELECT l_id_no id_no
                     , MAX(ticker_a) ticker_a
                     , MAX(ticker_b) ticker_b
                     , MIN(data_time) period_from
                     , MAX(data_time) period_to
                     , ma_idx
                     , l_stop_loss preset_stop_loss 
                     , l_take_profit preset_take_profit
                     , pi_lot_amt preset_log_amt 
                     , SUM(profit_loss) profit_loss_acc
                     , MIN(profit_loss) max_loss
                     , MAX(profit_loss) max_profit
                     , MIN(profit_loss_acc) max_drawdown
                     , COUNT( DECODE(SIGN(profit_loss), 1, 1, NULL) ) profit_cnt
                     , COUNT( DECODE(SIGN(profit_loss), -1, 1, NULL) ) loss_cnt
                     FROM pt_analysis3
                     WHERE id_no = l_id_no);
               EXCEPTION
               WHEN DUP_VAL_ON_INDEX THEN
                  NULL;
               END;
            END LOOP;
         END LOOP;
      END LOOP;
      COMMIT;
   EXCEPTION
   WHEN PUT_DATA_ERR THEN
      DBMS_OUTPUT.PUT_LINE('PUT_DATA_ERR: ' || pi_ticker_a ||','|| pi_ticker_b); 
      ROLLBACK;
   WHEN ANALY_PARAM_ERR THEN
      DBMS_OUTPUT.PUT_LINE('ANALY_PARAM_ERR: ' || pi_ticker_a ||','|| pi_ticker_b
                           || 'ma='|| TO_CHAR(ma_idx)
                           || 'pi_lot_amt='|| TO_CHAR(pi_lot_amt)
                           || 'pi_max_nof_lot='|| TO_CHAR(pi_max_nof_lot)
                           || 'pi_stop_loss='|| TO_CHAR(l_stop_loss)
                           || 'pi_take_profit='|| TO_CHAR(l_take_profit)
      ); 
      ROLLBACK;
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('OTHERS: ' || pi_ticker_a ||','|| pi_ticker_b || SQLERRM); 
      ROLLBACK;
   END run_back_test_set;
   --
   PROCEDURE run_back_test_set(pi_ticker_a IN VARCHAR2, pi_ticker_b IN VARCHAR2) IS
   BEGIN
      -- Pass default parameters
      run_back_test_set(pi_ticker_a => pi_ticker_a
            , pi_ticker_b => pi_ticker_b
            , pi_lot_amt => 2000
            , pi_max_nof_lot => 1
            , pi_stop_loss_pct_fm => 1
            , pi_stop_loss_pct_to => 10
            , pi_ma_fm => 12
            , pi_ma_to => 60
            , pi_profit_loss_ratio_fm => 2
            , pi_profit_loss_ratio_to => 3
            );
   END run_back_test_set;
END pa_pt_01;
/
