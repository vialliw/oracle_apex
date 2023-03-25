CREATE OR REPLACE PACKAGE BODY pa_zfcc_07 IS
   --
   FUNCTION import_aqh( pi_filename IN VARCHAR2 ) RETURN NUMBER IS
      -- This function is to read csv file format and insert records to table RAWDATA with ticker and sequence number
      l_file   UTL_FILE.FILE_TYPE;
      c_path   CONSTANT VARCHAR2(100) := pa_sys_para.get_sys_para('SMSPATH_OKF22027');
      l_buf    VARCHAR2(32767);
      l_ticker VARCHAR2(30);
      l_rec    rawdata%ROWTYPE;
      l_cnt    PLS_INTEGER := 0;
      l_buckets pa_misc_02.str_array;
      PROCEDURE mp_close IS
      BEGIN
         IF UTL_FILE.is_open(l_file) THEN
            UTL_FILE.FCLOSE(l_file);
         END IF;
      END;
   BEGIN
      l_file := UTL_FILE.FOPEN(c_path, pi_filename, 'R');
      -- Line 1 ticker
      UTL_FILE.GET_LINE(l_file, l_buf);
      l_ticker := RTRIM( SUBSTR(l_buf, INSTR(l_buf, '$NAME', 1) + LENGTH('$NAME') + 1) ); -- RTRIM(SUBSTR(l_buf, 7));
      --DELETE FROM rawdata WHERE col_h = l_ticker;
      DELETE FROM price_data WHERE ticker = l_ticker;
      --~DBMS_OUTPUT.PUT_LINE(l_buf);
      --~DBMS_OUTPUT.PUT_LINE(l_ticker);
      -- Line 2 Field headers
      UTL_FILE.GET_LINE(l_file, l_buf);
      -- Line 3+ data
      BEGIN
         LOOP
            UTL_FILE.GET_LINE(l_file, l_buf);
            l_cnt := l_cnt + 1;
            l_buckets := pa_misc_02.split_str(l_buf, ',');
            l_rec.col_a := l_buckets(1);
            l_rec.col_b := l_buckets(2);
            l_rec.col_c := l_buckets(3);
            l_rec.col_d := l_buckets(4);
            l_rec.col_e := l_buckets(5);
            l_rec.col_f := l_buckets(6);
            l_rec.col_g := l_buckets(7);
            l_rec.col_h := l_ticker;
            l_rec.col_i := l_cnt;
            --INSERT INTO rawdata (col_a,col_b,col_c,col_d,col_e,col_f,col_g,col_h,col_i) VALUES
            --  (l_rec.col_a,l_rec.col_b,l_rec.col_c,l_rec.col_d,l_rec.col_e,l_rec.col_f,l_rec.col_g,l_rec.col_h,l_rec.col_i);
            INSERT INTO price_data (data_date, OPEN, high, low, CLOSE, adj_close, volume, ticker) VALUES 
              (TO_DATE(l_rec.col_a,'DD-MM-YYYY'),TO_NUMBER(l_rec.col_b),TO_NUMBER(l_rec.col_c),TO_NUMBER(l_rec.col_d),TO_NUMBER(l_rec.col_e),TO_NUMBER(l_rec.col_f),TO_NUMBER(l_rec.col_g),l_rec.col_h);
         END LOOP;
      EXCEPTION
      WHEN NO_DATA_FOUND THEN
         mp_close;
      END;
      --~DBMS_OUTPUT.PUT_LINE('No. of data lines: ' || TO_CHAR(l_cnt));
      mp_close;
      COMMIT;
      RETURN 0;
   EXCEPTION
   WHEN OTHERS THEN
      mp_close;
      DBMS_OUTPUT.PUT_LINE('OTHERS :' || SQLERRM);
      RETURN -1;
   END import_aqh;
   --
   FUNCTION get_correlation(pi_ticker_a IN VARCHAR2, pi_ticker_b IN VARCHAR2) RETURN NUMBER IS
      l_corr NUMBER;
   BEGIN
      -- one pair and correlation, date range
      /*SELECT CORR(a.adj_close, b.adj_close) correlation
      INTO l_corr
      FROM price_data a, price_data b
      WHERE a.data_date = b.data_date
      AND a.ticker = pi_ticker_a
      AND b.ticker = pi_ticker_b
      GROUP BY a.ticker, b.ticker;*/
      RETURN l_corr;
   EXCEPTION
   WHEN OTHERS THEN
      RETURN NULL;
   END get_correlation;
   --
   FUNCTION get_correlation(pi_ticker_a IN VARCHAR2, pi_ticker_b IN VARCHAR2, pi_nof_ticks IN NUMBER) RETURN NUMBER IS
   BEGIN
      RETURN NULL;
   END get_correlation;
   --
   FUNCTION put_pairs_data(pi_ticker_a IN VARCHAR2, pi_ticker_b IN VARCHAR2, pi_date_fmt_mask IN VARCHAR2 := 'DD-MM-YYYY') RETURN NUMBER IS
      -- Convert rawdata to pt_analysis2
      -- When successful, return new id_no.
      -- When error, return -1.
      l_common_fm_dt DATE;
      l_common_to_dt DATE;
      l_id_no   pt_analysis2.id_no%TYPE;
      CURSOR pt_b_cr IS
         SELECT p.data_time, p.ticker_b, p.open_b, p.high_b, p.low_b, p.close_b, p.adj_close_b, p.vol_b
         FROM pt_analysis2 p
         WHERE id_no = l_id_no
         ORDER BY seq_no
         FOR UPDATE OF ticker_b, open_b, high_b, low_b, close_b, adj_close_b, vol_b;
      CURSOR rawdata_b_cr( pi_data_time_str IN VARCHAR2 ) IS
         SELECT *
         FROM rawdata
         WHERE col_a = pi_data_time_str
         AND col_h = pi_ticker_b;
      l_rawdata_b_rc rawdata_b_cr%ROWTYPE;
   BEGIN
      -- Get common data range
      SELECT MAX(start_dt) fm_dt, MIN(end_dt) to_dt
      INTO l_common_fm_dt, l_common_to_dt
      FROM (
      SELECT col_h
      , MIN(TO_DATE(col_a,'DD-MM-YYYY')) start_dt
      , MAX(TO_DATE(col_a,'DD-MM-YYYY')) end_dt
      , MONTHS_BETWEEN(MAX(TO_DATE(col_a,'DD-MM-YYYY')), MIN(TO_DATE(col_a,'DD-MM-YYYY'))) MTHS
      FROM rawdata
      WHERE col_h IN (pi_ticker_a, pi_ticker_b)
      GROUP BY col_h
      );
      -- Get new id_no
      SELECT NVL(MAX(id_no), 0) + 1 INTO l_id_no FROM pt_analysis2;
      -- Insert Ticker A data
      INSERT INTO pt_analysis2 (id_no, seq_no, data_time, ticker_a, open_a, high_a, low_a, close_a, adj_close_a, vol_a)
      (SELECT l_id_no id_no, 
        TO_NUMBER(col_i) seq_no,
        TO_DATE(col_a, pi_date_fmt_mask) data_time,
        pi_ticker_a ticker_a,
        TO_NUMBER(col_b) open_a,
        TO_NUMBER(col_c) high_a,
        TO_NUMBER(col_d) low_a,
        TO_NUMBER(col_e) close_a,
        TO_NUMBER(col_f) adj_close_a,
        TO_NUMBER(col_g) vol_a
      FROM rawdata
      WHERE col_h = pi_ticker_a
      );
      -- Insert Ticker B data
      FOR rc IN pt_b_cr LOOP
         OPEN rawdata_b_cr( TO_CHAR(rc.data_time, pi_date_fmt_mask) );
         FETCH rawdata_b_cr INTO l_rawdata_b_rc;
         UPDATE pt_analysis2 p
         SET ticker_b = pi_ticker_b
         , open_b = TO_NUMBER(l_rawdata_b_rc.col_b)
         , high_b = TO_NUMBER(l_rawdata_b_rc.col_c)
         , low_b = TO_NUMBER(l_rawdata_b_rc.col_d)
         , close_b = TO_NUMBER(l_rawdata_b_rc.col_e)
         , adj_close_b = TO_NUMBER(l_rawdata_b_rc.col_f)
         , vol_b = TO_NUMBER(l_rawdata_b_rc.col_g)
         WHERE CURRENT OF pt_b_cr;
         CLOSE rawdata_b_cr;
      END LOOP;
      RETURN l_id_no;
   EXCEPTION
   WHEN OTHERS THEN
      RETURN -1;
   END put_pairs_data;
   --
   FUNCTION put_pairs_data2(pi_ticker_a IN VARCHAR2, pi_ticker_b IN VARCHAR2) RETURN NUMBER IS
      -- Merge price_data of ticker A and B to pt_analysis2
      -- When successful, return new id_no.
      -- When error, return -1.
      l_id_no   pt_analysis2.id_no%TYPE;
   BEGIN
      -- Get new id_no
      SELECT NVL(MAX(id_no), 0) + 1 INTO l_id_no FROM pt_analysis2;
      -- Insert in one go
      INSERT INTO pt_analysis2
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
      RETURN l_id_no;
   EXCEPTION
   WHEN OTHERS THEN
      RETURN -1;
   END put_pairs_data2;
   --
   PROCEDURE rawdata_set_seq_num( pi_ticker IN VARCHAR2 ) IS
      l_seq_no PLS_INTEGER;
      CURSOR rawdata_without_seq_cr IS
         SELECT col_a -- date/time field
         FROM rawdata
         WHERE col_h = pi_ticker
         ORDER BY col_a -- date/time field
         FOR UPDATE OF col_i; -- reserve for sequence no.
   BEGIN
      FOR rc IN rawdata_without_seq_cr LOOP
         l_seq_no := rawdata_without_seq_cr%ROWCOUNT;
         UPDATE rawdata
            SET col_i = l_seq_no
            WHERE CURRENT OF rawdata_without_seq_cr;
      END LOOP;
      COMMIT;
   END rawdata_set_seq_num;
   --
   FUNCTION pt_orchestra( pi_id_no IN NUMBER
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
      FROM pt_analysis
      WHERE id_no = pi_id_no
      AND seq_no > pi_ma
      ORDER BY seq_no
      FOR UPDATE OF l_idx_avg, l_idx_stdev
      , buy_price, buy_vol, buy_amt, sell_price, sell_vol, sell_amt, mtm, sts, profit_loss, profit_loss_acc;
   l_tmp_rec   navigate_cr%ROWTYPE;
   BEGIN
      -- Clean
      UPDATE pt_analysis
      SET l_idx = NULL
      , l_idx_avg = NULL
      , l_idx_stdev = NULL
      , z_score = NULL
      , signal = NULL
      , buy_price = NULL
      , buy_vol = NULL
      , buy_amt = NULL
      , sell_price = NULL
      , sell_vol = NULL
      , sell_amt = NULL
      , mtm = NULL
      , sts = NULL
      , profit_loss = NULL
      , profit_loss_acc = NULL
      WHERE id_no = pi_id_no;
      -- l(0)
      UPDATE pt_analysis
      SET l_idx = LN((adj_close_b / adj_close_a))
      WHERE id_no = pi_id_no;
      -- Calculate MA, aka l(0) Average, and STDEV
      FOR rc IN navigate_cr LOOP
         l_working1 := NULL;
         l_working2 := NULL;
         SELECT AVG(l_idx), STDDEV(l_idx)
         INTO l_working1, l_working2
         FROM pt_analysis
         WHERE id_no = pi_id_no
         AND seq_no BETWEEN (rc.seq_no - pi_ma) AND (rc.seq_no - 1);
         --
         IF l_working1 IS NOT NULL THEN
            UPDATE pt_analysis
               SET l_idx_avg = l_working1
               , l_idx_stdev = l_working2
               WHERE CURRENT OF navigate_cr;
         END IF;
      END LOOP;
      -- Calculate Z-SCORE
      UPDATE pt_analysis
          SET z_score = (l_idx - l_idx_avg) / l_idx_stdev
          WHERE id_no = pi_id_no
          AND seq_no > pi_ma;
      -- Determine signal
      UPDATE pt_analysis
         SET signal = DECODE(SIGN(z_score - pi_buy_threshold), -1, 'BUY', DECODE(SIGN(z_score - pi_sell_threshold), 1, 'SELL'))
         WHERE id_no = pi_id_no
         AND z_score IS NOT NULL;
      -- Buy/Sell
      FOR rc IN navigate_cr LOOP
         IF rc.sts IS NULL THEN
            -- Open position
            IF rc.signal = 'SELL' THEN
               l_tmp_rec.buy_price := rc.adj_close_b;
               l_tmp_rec.buy_vol := TRUNC(pi_lot_amt / rc.adj_close_b);
               l_tmp_rec.buy_amt := TRUNC(pi_lot_amt / rc.adj_close_b) * rc.adj_close_b;
               l_tmp_rec.sell_price := rc.adj_close_a;
               l_tmp_rec.sell_vol := TRUNC(pi_lot_amt / rc.adj_close_a);
               l_tmp_rec.sell_amt := TRUNC(pi_lot_amt / rc.adj_close_a) * rc.adj_close_a;
               l_tmp_rec.mtm := NULL;
               l_tmp_rec.profit_loss := NULL;
               l_tmp_rec.profit_loss_acc := NULL;
               l_tmp_rec.signal := 'SELL';
               l_tmp_rec.sts := 'SOLD';
            ELSIF rc.signal = 'BUY' THEN
               l_tmp_rec.buy_price := rc.adj_close_a;
               l_tmp_rec.buy_vol := TRUNC(pi_lot_amt / rc.adj_close_a);
               l_tmp_rec.buy_amt := TRUNC(pi_lot_amt / rc.adj_close_a) * rc.adj_close_a;
               l_tmp_rec.sell_price := rc.adj_close_b;
               l_tmp_rec.sell_vol := TRUNC(pi_lot_amt / rc.adj_close_b);
               l_tmp_rec.sell_amt := TRUNC(pi_lot_amt / rc.adj_close_b) * rc.adj_close_b;
               l_tmp_rec.mtm := NULL;
               l_tmp_rec.profit_loss := NULL;
               l_tmp_rec.profit_loss_acc := NULL;
               l_tmp_rec.signal := 'BUY';
               l_tmp_rec.sts := 'BOUGHT';
            END IF;
            IF rc.signal IN ('BUY','SELL') THEN
               UPDATE pt_analysis
                  SET buy_price = l_tmp_rec.buy_price
                  , buy_vol = l_tmp_rec.buy_vol
                  , buy_amt = l_tmp_rec.buy_amt
                  , sell_price = l_tmp_rec.sell_price 
                  , sell_vol = l_tmp_rec.sell_vol
                  , sell_amt = l_tmp_rec.sell_amt
                  , mtm = l_tmp_rec.mtm
                  , sts = l_tmp_rec.sts
                  , profit_loss = l_tmp_rec.profit_loss
                  , profit_loss_acc = l_tmp_rec.profit_loss_acc
                  WHERE CURRENT OF navigate_cr;
            END IF; 
         END IF; 
         -- Keep status
         IF l_tmp_rec.sts IS NOT NULL AND rc.signal IS NULL THEN
            UPDATE pt_analysis
               SET buy_price = l_tmp_rec.buy_price
               , buy_vol = l_tmp_rec.buy_vol
               , buy_amt = l_tmp_rec.buy_amt
               , sell_price = l_tmp_rec.sell_price 
               , sell_vol = l_tmp_rec.sell_vol
               , sell_amt = l_tmp_rec.sell_amt
               , mtm = l_tmp_rec.mtm
               , sts = l_tmp_rec.sts
               , profit_loss = l_tmp_rec.profit_loss
               , profit_loss_acc = l_tmp_rec.profit_loss_acc
               WHERE CURRENT OF navigate_cr;
         END IF;
      END LOOP;
      RETURN 0;
   END pt_orchestra;
   --
   FUNCTION mtm( pi_open IN NUMBER, pi_close IN NUMBER, pi_open_vol IN NUMBER ) RETURN NUMBER IS
   BEGIN
      RETURN (pi_close - pi_open) * pi_open_vol;
   END mtm;
   --
   FUNCTION get_pct_chg(pi_open IN NUMBER, pi_close IN NUMBER) RETURN NUMBER IS
   BEGIN
      RETURN ((pi_close / pi_open) - 1) * 100;
   END get_pct_chg;
   --
   FUNCTION get_cagr(pi_initial_amt IN NUMBER, pi_final_profit_loss_amt IN NUMBER, pi_start_dt IN DATE, pi_end_dt IN DATE) RETURN NUMBER IS
   BEGIN
      RETURN (POWER((pi_initial_amt + pi_final_profit_loss_amt)/pi_initial_amt, (1/((pi_end_dt - pi_start_dt)/365))) - 1) * 100;
   EXCEPTION
   WHEN OTHERS THEN
      RETURN NULL;
   END;
   --
   PROCEDURE get_best_pair_vols(pi_price_a IN NUMBER
                     , pi_price_b IN NUMBER
                     , pi_lot_amt IN NUMBER -- lot size e.g.)2,000
                     , po_vol_a OUT NUMBER -- best vol size of ticker a
                     , po_vol_b OUT NUMBER -- best vol size of ticker b
                     ) IS
      i   PLS_INTEGER;
      j   PLS_INTEGER;
      ll_vol_a SMALLINT;
      ll_vol_b SMALLINT;
   BEGIN
      IF pi_price_a > 0 AND pi_price_b > 0 AND pi_lot_amt > 0 THEN
         FOR i IN (TRUNC(pi_lot_amt / pi_price_a) - 2)..(TRUNC(pi_lot_amt / pi_price_a) + 2) LOOP
            ll_vol_a := i;
            FOR j IN (TRUNC(pi_lot_amt / pi_price_b) - 2)..(TRUNC(pi_lot_amt / pi_price_b) + 2) LOOP
               ll_vol_b := j;
               --DBMS_OUTPUT.PUT_LINE( ll_vol_a ||','|| ll_vol_b ||'>>$'|| ll_vol_a * pi_price_a ||'>>$'|| ll_vol_b * pi_price_b ||'; diff='|| ABS(ll_vol_a * pi_price_a - ll_vol_b * pi_price_b) );
               IF po_vol_a IS NULL THEN
                  po_vol_a := ll_vol_a;
                  po_vol_b := ll_vol_b;
               ELSIF ABS(ll_vol_a * pi_price_a - ll_vol_b * pi_price_b) < ABS(po_vol_a * pi_price_a - po_vol_b * pi_price_b) THEN 
                  po_vol_a := ll_vol_a;
                  po_vol_b := ll_vol_b;
               END IF;
            END LOOP;
         END LOOP;
         --DBMS_OUTPUT.PUT_LINE( 'Ticker A = $' || pi_price_a ||' x '|| po_vol_a ||' = $' || pi_price_a * po_vol_a);
         --DBMS_OUTPUT.PUT_LINE( 'Ticker B = $' || pi_price_b ||' x '|| po_vol_b ||' = $' || pi_price_b * po_vol_b);
         --DBMS_OUTPUT.PUT_LINE( 'Diff $' || ABS(pi_price_a * po_vol_a - pi_price_b * po_vol_b));
      END IF;
   END get_best_pair_vols;
   --
   PROCEDURE get_best_pair_vols2(pi_price_a IN NUMBER
                     , pi_price_b IN NUMBER
                     , pi_lot_amt IN NUMBER -- lot size e.g.)2,000
                     , po_vol_a OUT NUMBER -- best vol size of ticker a
                     , po_vol_b OUT NUMBER -- best vol size of ticker b
                     ) IS
      CURSOR lot_size_cr(pi_vol_a IN NUMBER, pi_vol_b IN NUMBER) IS
         SELECT volxa, volxb, lot_amt_a, lot_amt_b
         , ABS(ROUND(pa_zfcc_07.get_pct_chg( lot_amt_a, lot_amt_b ), 1)) diff_in_pct
         FROM (
            SELECT DECODE(ROWNUM, 1, pi_vol_a + 0,
                                2, pi_vol_a - 1,
                                3, pi_vol_a + 1,
                                4, pi_vol_a -2,
                                5, pi_vol_a + 2) volxa
               , DECODE(ROWNUM, 1, pi_vol_a + 0,
                                2, pi_vol_a - 1,
                                3, pi_vol_a + 1,
                                4, pi_vol_a -2,
                                5, pi_vol_a + 2) * pi_price_a lot_amt_a
            FROM pt_analysis2
            WHERE ROWNUM <= 5 ) a
            , (SELECT DECODE(ROWNUM, 1, pi_vol_b + 0,
                                2, pi_vol_b - 1,
                                3, pi_vol_b + 1,
                                4, pi_vol_b -2,
                                5, pi_vol_b + 2) volxb
               , DECODE(ROWNUM, 1, pi_vol_b + 0,
                                2, pi_vol_b - 1,
                                3, pi_vol_b + 1,
                                4, pi_vol_b -2,
                                5, pi_vol_b + 2) * pi_price_b lot_amt_b
            FROM pt_analysis2
            WHERE ROWNUM <= 5) b
         ORDER BY ABS(ROUND(pa_zfcc_07.get_pct_chg( lot_amt_a, lot_amt_b ), 1));
      l_rec lot_size_cr%ROWTYPE;
   BEGIN
      OPEN lot_size_cr(TRUNC(pi_lot_amt / pi_price_a), TRUNC(pi_lot_amt / pi_price_b));
      FETCH lot_size_cr INTO l_rec;
      CLOSE lot_size_cr;
      po_vol_a := l_rec.volxa;
      po_vol_b := l_rec.volxb;
   END get_best_pair_vols2;
   --
   FUNCTION pt_orchestra2( pi_id_no IN NUMBER
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
      FROM pt_analysis2
      WHERE id_no = pi_id_no
      AND seq_no > pi_ma
      ORDER BY seq_no -- must
      FOR UPDATE OF l_idx_avg, l_idx_stdev, tx_price_a, tx_vol_a, tx_amt_a, tx_price_b, tx_vol_b, tx_amt_a, mtm, sts, profit_loss, profit_loss_acc;
   l_tmp_rec   navigate_cr%ROWTYPE;
   BEGIN
      -- Clean
      UPDATE pt_analysis2
      SET l_idx = NULL
      , l_idx_avg = NULL
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
      -- l(0)
      UPDATE pt_analysis2
      --SET l_idx = LN((adj_close_b / adj_close_a))
      SET l_idx = LN((adj_close_a / adj_close_b))
      WHERE id_no = pi_id_no;
      -- Calculate MA, aka l(0) Average, and STDEV
      FOR rc IN navigate_cr LOOP
         l_working1 := NULL;
         l_working2 := NULL;
         SELECT AVG(l_idx), STDDEV(l_idx)
         INTO l_working1, l_working2
         FROM pt_analysis2
         WHERE id_no = pi_id_no
         AND seq_no BETWEEN (rc.seq_no - pi_ma) AND (rc.seq_no - 1);
         --
         IF l_working1 IS NOT NULL THEN
            UPDATE pt_analysis2
               SET l_idx_avg = l_working1
               , l_idx_stdev = l_working2
               WHERE CURRENT OF navigate_cr;
         END IF;
      END LOOP;
      -- Calculate Z-SCORE
      UPDATE pt_analysis2
          SET z_score = (l_idx - l_idx_avg) / l_idx_stdev
          WHERE id_no = pi_id_no
          AND seq_no > pi_ma;
      -- Determine signal
      UPDATE pt_analysis2
         SET signal = DECODE(SIGN(z_score - pi_buy_threshold), -1, 'BUY', DECODE(SIGN(z_score - pi_sell_threshold), 1, 'SELL'))
         WHERE id_no = pi_id_no
         AND z_score IS NOT NULL;
      -- Buy/Sell
      FOR rc IN navigate_cr LOOP
         DBMS_OUTPUT.PUT_LINE(rc.seq_no ||'; prev sts='|| l_tmp_rec.sts ||'; current signal='|| rc.signal);
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
            ELSE -- No signal
               l_tmp_rec.profit_loss := 0;
            END IF;
         END IF;
         IF l_tmp_rec.sts IN ('BOUGHT','SOLD','CLOSED') OR rc.signal IN ('BUY','SELL') THEN
            UPDATE pt_analysis2
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
      RETURN 0;
   END pt_orchestra2;
   --
   FUNCTION pt_orchestra3( pi_id_no IN NUMBER
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
      FROM pt_analysis2
      WHERE id_no = pi_id_no
      AND seq_no > pi_ma
      ORDER BY seq_no -- must
      FOR UPDATE OF l_idx_avg, l_idx_stdev, tx_price_a, tx_vol_a, tx_amt_a, tx_price_b, tx_vol_b, tx_amt_a, mtm, sts, profit_loss, profit_loss_acc;
   l_tmp_rec   navigate_cr%ROWTYPE;
   BEGIN
      -- Clean
      UPDATE pt_analysis2
      SET l_idx = NULL
      , l_idx_avg = NULL
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
      -- l(0)
      UPDATE pt_analysis2
      --SET l_idx = LN((adj_close_b / adj_close_a))
      SET l_idx = LN((adj_close_a / adj_close_b))
      WHERE id_no = pi_id_no;
      -- Calculate MA, aka l(0) Average, and STDEV
      FOR rc IN navigate_cr LOOP
         l_working1 := NULL;
         l_working2 := NULL;
         SELECT AVG(l_idx), STDDEV(l_idx)
         INTO l_working1, l_working2
         FROM pt_analysis2
         WHERE id_no = pi_id_no
         AND seq_no BETWEEN (rc.seq_no - pi_ma) AND (rc.seq_no - 1);
         --
         IF l_working1 IS NOT NULL THEN
            UPDATE pt_analysis2
               SET l_idx_avg = l_working1
               , l_idx_stdev = l_working2
               WHERE CURRENT OF navigate_cr;
         END IF;
      END LOOP;
      -- Calculate Z-SCORE
      UPDATE pt_analysis2
          SET z_score = (l_idx - l_idx_avg) / l_idx_stdev
          WHERE id_no = pi_id_no
          AND seq_no > pi_ma;
      -- Determine signal
      UPDATE pt_analysis2
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
            UPDATE pt_analysis2
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
         UPDATE pt_analysis2
            SET profit_loss_acc = l_tmp_rec.profit_loss_acc
            WHERE CURRENT OF navigate_cr;
      END LOOP;
      RETURN 0;
   END pt_orchestra3;
   --
   FUNCTION pt_orchestra4( pi_id_no IN NUMBER
                        , pi_ma IN NUMBER := 30
                        , pi_buy_threshold IN NUMBER := -2
                        , pi_sell_threshold IN NUMBER := 2
                        , pi_lot_amt IN NUMBER := 2000
                        , pi_max_nof_lot IN NUMBER := 1
                        , pi_stop_loss IN NUMBER := -100
                        , pi_take_profit IN NUMBER := 200
                        ) RETURN NUMBER IS
   -- Clone from pt_orchestra3 and change to use temporary table pt_analysis3
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
      SET l_idx = NULL
      , l_idx_avg = NULL
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
      -- l(0)
      UPDATE pt_analysis3
      --SET l_idx = LN((adj_close_b / adj_close_a))
      SET l_idx = LN((adj_close_a / adj_close_b))
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
   END pt_orchestra4;
   --
   PROCEDURE pt_analy(pi_ticker_a IN VARCHAR2
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
      c_ticker_b CONSTANT pt_analysis3.ticker_a%TYPE := GREATEST(pi_ticker_a, pi_ticker_b);
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
      DBMS_OUTPUT.PUT_LINE('Ticker a = ' || c_ticker_a || '; Ticker b = ' || c_ticker_b);
      -- PUT_PAIRS_DATA2
      l_id_no := pa_zfcc_07.put_pairs_data2(c_ticker_a, c_ticker_b);
      DBMS_OUTPUT.PUT_LINE('id_no = ' || l_id_no );
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
               DBMS_OUTPUT.PUT_LINE('l_stop_loss = ' || l_stop_loss );
               DBMS_OUTPUT.PUT_LINE('l_take_profit = ' || l_take_profit );
               l_rc := pa_zfcc_07.pt_orchestra3( pi_id_no => l_id_no
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
                     , ma_idx --COUNT( DECODE(Z_SCORE, NULL, 1, NULL) ) ma
                     , l_stop_loss preset_stop_loss 
                     , l_take_profit preset_take_profit
                     , pi_lot_amt preset_log_amt 
                     , SUM(profit_loss) profit_loss_acc
                     , MIN(profit_loss) max_loss
                     , MAX(profit_loss) max_profit
                     , MIN(profit_loss_acc) max_drawdown
                     , COUNT( DECODE(SIGN(profit_loss), 1, 1, NULL) ) profit_cnt
                     , COUNT( DECODE(SIGN(profit_loss), -1, 1, NULL) ) loss_cnt
                     FROM pt_analysis2
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
      DBMS_OUTPUT.PUT_LINE('OTHERS: ' || SQLERRM); 
      ROLLBACK;
   END pt_analy;
   --
   PROCEDURE pt_analy(pi_ticker_a IN VARCHAR2, pi_ticker_b IN VARCHAR2) IS
   BEGIN
      -- Pass default parameters
      pt_analy(pi_ticker_a => pi_ticker_a
            , pi_ticker_b => pi_ticker_b
            , pi_lot_amt => 2000
            , pi_max_nof_lot => 1
            , pi_stop_loss_pct_fm => 5
            , pi_stop_loss_pct_to => 5
            , pi_ma_fm => 39
            , pi_ma_to => 39
            , pi_profit_loss_ratio_fm => 2
            , pi_profit_loss_ratio_to => 2
            );
   END pt_analy;
END;
/
