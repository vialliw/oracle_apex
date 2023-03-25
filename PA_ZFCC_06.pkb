CREATE OR REPLACE PACKAGE BODY pa_zfcc_06 IS
l_card_id VARCHAR2(16);
l_chas_no VARCHAR2(25);
l_limit   NUMBER;
l_type    VARCHAR2(1);
l_exp_dt  VARCHAR2(4);
CURSOR	c_upld (pi_log_cde VARCHAR2, pi_val_dt DATE) IS
SELECT	ca.loan_typ||LTRIM(TO_CHAR(ca.loan_no, '000000'))||c.card_id d_card_id,
	c.chas_no d_chas_no,
	ch.LIMIT d_limit,
	TO_CHAR(l.last_due_dt, 'MMYY') d_exp_dt
FROM	loan l,
	card_act_log ca,
	cr_ln_hdr ch,
	card c
WHERE	l.lnpa_istu_insttu_cde = ca.insttu_cde
AND	l.lnpa_loan_typ = ca.loan_typ
AND	l.loan_no = ca.loan_no
AND	ca.card_id = c.card_id
AND	l.cr_line = ch.cr_line
AND	l.cr_line_id_type = ch.ctif_id_type
AND	l.cr_line_id_no = ch.ctif_id_no
AND	l.cr_line_iss_ctry = ch.ctif_iss_ctry
AND	ca.log_cde = pi_log_cde
AND	ca.card_log_date = pi_val_dt
AND	l.lnpa_loan_typ = '839';
   --
   FUNCTION mtm( pi_open IN NUMBER, pi_close IN NUMBER, pi_open_vol IN NUMBER ) RETURN NUMBER IS
   BEGIN
      RETURN (pi_close - pi_open) * pi_open_vol;
   END mtm;
   --
   FUNCTION show_pct( pi_portion IN NUMBER, pi_total IN NUMBER) RETURN NUMBER IS
   BEGIN
      RETURN pi_portion / pi_total * 100;
   EXCEPTION
   WHEN OTHERS THEN
      RETURN NULL;
   END show_pct;
   --
   FUNCTION show_profit( pi_final IN NUMBER, pi_cost IN NUMBER) RETURN NUMBER IS
   BEGIN
      RETURN ((pi_final / pi_cost) - 1) * 100;
   EXCEPTION
   WHEN OTHERS THEN
      RETURN NULL;
   END show_profit;
   --
FUNCTION gen_zfcc_upload (pi_val_dt DATE := NULL) RETURN NUMBER IS
l_val_dt	DATE;
l_dummy		NUMBER;
BEGIN
	l_val_dt := NVL(pi_val_dt, pa_global.cur_prcs_date);
	DELETE FROM zfcc_upload;
	COMMIT;
	l_dummy := pa_zfcc_06.gen_zfcc_nb(l_val_dt);
	IF l_dummy <> 0 THEN
		RETURN -1;
	END IF;
	l_dummy := pa_zfcc_06.gen_zfcc_cncl(l_val_dt);
	IF l_dummy <> 0 THEN
		RETURN -2;
	END IF;
	l_dummy := pa_zfcc_06.gen_zfcc_renew(l_val_dt);
	IF l_dummy <> 0 THEN
		RETURN -3;
	END IF;
	l_dummy := pa_zfcc_06.spool_text_file;
	IF l_dummy <> 0 THEN
		RETURN -4;
	END IF;
	RETURN 0;
END gen_zfcc_upload;
FUNCTION gen_zfcc_nb (pi_val_dt DATE := NULL) RETURN NUMBER IS
l_log_cde	VARCHAR2(5) := 'CI';
l_dummy		NUMBER;
l_create_dt	DATE := pi_val_dt;
l_create_usr	VARCHAR2(30) := USER;
BEGIN
	FOR r_upld IN c_upld (l_log_cde, pi_val_dt) LOOP
		l_card_id := r_upld.d_card_id;
		l_chas_no := r_upld.d_chas_no;
		l_limit := r_upld.d_limit;
		l_exp_dt := r_upld.d_exp_dt;
		l_type := 'N';
		INSERT INTO zfcc_upload (card_no, chas_no, LIMIT, TYPE, expiry_dt, create_dt, create_usr)
		VALUES (l_card_id, l_chas_no, l_limit, l_type, l_exp_dt, l_create_dt, l_create_usr);
		COMMIT;
	END LOOP;
	RETURN 0;
EXCEPTION
	WHEN OTHERS THEN
		l_dummy := pa_errlog.WRITE('GENZFCCNEW', 'N',1,l_card_id || SQLERRM);
		RETURN -1;
END gen_zfcc_nb;
FUNCTION gen_zfcc_cncl (pi_val_dt DATE := NULL) RETURN NUMBER IS
l_log_cde	VARCHAR2(5) := 'CC';
l_dummy		NUMBER;
l_create_dt	DATE := pi_val_dt;
l_create_usr	VARCHAR2(30) := USER;
BEGIN
	FOR r_upld IN c_upld (l_log_cde, pi_val_dt) LOOP
		l_card_id := r_upld.d_card_id;
		l_chas_no := r_upld.d_chas_no;
		l_limit := r_upld.d_limit;
		l_exp_dt := r_upld.d_exp_dt;
		l_type := 'C';
		INSERT INTO zfcc_upload (card_no, chas_no, LIMIT, TYPE, expiry_dt, create_dt, create_usr)
		VALUES (l_card_id, l_chas_no, l_limit, l_type, l_exp_dt, l_create_dt, l_create_usr);
		COMMIT;
	END LOOP;
	RETURN 0;
EXCEPTION
	WHEN OTHERS THEN
		l_dummy := pa_errlog.WRITE('GENZFCCCNC', 'N',1, l_card_id || SQLERRM);
		RETURN -1;
END gen_zfcc_cncl;
FUNCTION gen_zfcc_renew (pi_val_dt DATE := NULL) RETURN NUMBER IS
l_log_cde VARCHAR2(5) := 'CIR';
l_dummy	  NUMBER;
l_create_dt	DATE := pi_val_dt;
l_create_usr	VARCHAR2(30) := USER;
BEGIN
	FOR r_upld IN c_upld (l_log_cde, pi_val_dt) LOOP
		l_card_id := r_upld.d_card_id;
		l_chas_no := r_upld.d_chas_no;
		l_limit := r_upld.d_limit;
		l_exp_dt := r_upld.d_exp_dt;
		l_type := 'R';
		INSERT INTO zfcc_upload (card_no, chas_no, LIMIT, TYPE, expiry_dt, create_dt, create_usr)
		VALUES (l_card_id, l_chas_no, l_limit, l_type, l_exp_dt, l_create_dt, l_create_usr);
		COMMIT;
	END LOOP;
	RETURN 0;
EXCEPTION
	WHEN OTHERS THEN
		l_dummy := pa_errlog.WRITE('GENZFCCRNE', 'N',1, l_card_id || SQLERRM);
		RETURN -1;
END gen_zfcc_renew;
FUNCTION spool_text_file RETURN NUMBER IS
-- variable in zfcc_upload
l_card_no	VARCHAR2(16);
l_chas_no	VARCHAR2(25);
l_limit		NUMBER(15,2);
l_type		VARCHAR2(1);
l_expiry_dt	VARCHAR2(4);
l_create_dt	DATE;
l_create_usr	VARCHAR2(15);
-- variable in text_spool
l_insttu_cde          VARCHAR2(3)   := pa_usr.insttu_cde;
l_cur_prcs_date       DATE          := pa_global.cur_prcs_date;
l_seq_no              NUMBER(5);
l_ord_no              NUMBER(5)     := 0;
l_func_id             VARCHAR2(8)   := 'PAZFCC06';
l_text                VARCHAR2(200) := NULL;
l_cur_dt              DATE          := pa_global.mach_datetime;
l_usr_id              VARCHAR2(40)  := pa_usr.usr_cde;
l_data_found          VARCHAR2(1)   := 'N';
l_err_txt             VARCHAR2(100) := NULL;
missing_parameter     EXCEPTION;
invalid_parameter     EXCEPTION;
function_error        EXCEPTION;
l_dummy		      NUMBER;
CURSOR	c_zf_upld IS
SELECT	card_no, chas_no, LIMIT, TYPE, expiry_dt, create_dt, create_usr
FROM	zfcc_upload;
BEGIN
   -- Generate Sequence No.
   IF NOT pa_seq.gen_spool_no ( l_seq_no, l_insttu_cde ) THEN
      IF pa_errlog.WRITE ( l_func_id, 'N', 1, 'Generate Sequence Error' ) <> 0 THEN
         RAISE function_error;
      ELSE
         RAISE missing_parameter;
      END IF;
   END IF;
   FOR r_zf_upld IN c_zf_upld LOOP
	l_data_found := 'Y';
	l_card_no := r_zf_upld.card_no;
	l_chas_no := r_zf_upld.chas_no;
	l_limit := r_zf_upld.LIMIT;
	l_type := r_zf_upld.TYPE;
	l_expiry_dt := r_zf_upld.expiry_dt;
	l_create_dt := r_zf_upld.create_dt;
	l_create_usr := r_zf_upld.create_usr;
	l_text := l_card_no||RPAD(SUBSTR(l_chas_no, 1, 17), 17, ' ')||LPAD(TO_CHAR(l_limit * 100), 15, '0')||
		  l_expiry_dt||l_type;
      -- Check order no if too long
	IF l_ord_no > 99999 THEN
        	IF pa_errlog.WRITE(l_func_id,'N',2,'Order No. too large') <> 0 THEN
			RAISE function_error;
		ELSE
			RAISE invalid_parameter;
		END IF;
	ELSE
		l_ord_no := l_ord_no + 1;
	END IF;
      -- Insert into TEXT_SPOOL table
	BEGIN
	INSERT INTO text_spool
		( seq_no, ord_no, func_id, text, crt_dt, crt_usr )
	VALUES
		( l_seq_no, l_ord_no, l_func_id, l_text, l_cur_dt, l_usr_id );
	EXCEPTION
		WHEN DUP_VAL_ON_INDEX THEN
			l_err_txt := l_seq_no||l_ord_no||'Duplicate value on index';
		IF pa_errlog.WRITE('GENZFCCSPOL', 'N',1, l_err_txt) <> 0 THEN
			RAISE function_error;
		END IF;
	END;
   COMMIT;
   END LOOP;
   IF l_data_found = 'Y' THEN
      l_text := LPAD(LPAD(TO_CHAR(l_ord_no),5,'0'),29,' ');
      IF l_ord_no > 99999 THEN
         IF pa_errlog.WRITE(l_func_id,'N',2,'Order No. too large') <> 0 THEN
            RAISE function_error;
         ELSE
            RAISE invalid_parameter;
         END IF;
      ELSE
         l_ord_no := l_ord_no + 1;
      END IF;
      BEGIN
         INSERT INTO text_spool ( seq_no, ord_no, func_id, text, crt_dt, crt_usr )
         VALUES ( l_seq_no, l_ord_no, l_func_id, l_text, l_cur_dt, l_usr_id );
      EXCEPTION
         WHEN DUP_VAL_ON_INDEX THEN
		l_err_txt := 'Total Number Column - Duplicate value on index';
		IF pa_errlog.WRITE('GENZFCCSPOL', 'N',1, l_err_txt) <> 0 THEN
			RAISE function_error;
		END IF;
      END;
      COMMIT;
   END IF;
   RETURN 0;
EXCEPTION
   WHEN missing_parameter THEN
      pa_errlog.ABORT('PA_ZFCC_06');
      RETURN 1;
   WHEN invalid_parameter THEN
      pa_errlog.ABORT('PA_ZFCC_06');
      RETURN 2;
   WHEN function_error THEN
      pa_errlog.ABORT('PA_ZFCC_06');
      RETURN 3;
   WHEN STORAGE_ERROR THEN
      IF pa_errlog.WRITE('PA_ZFCC_06','N',3,'Storage Error') <> 0 THEN
         RAISE function_error;
      END IF;
      pa_errlog.ABORT('PA_ZFCC_06');
      RETURN 3;
   WHEN OTHERS THEN
      pa_errlog.ABORT('PA_ZFCC_06');
      RETURN -1;
END spool_text_file;
--
FUNCTION mth_clos_price( pi_opt_cde IN VARCHAR2, pi_val_dt IN DATE ) RETURN NUMBER IS
   l_price   NUMBER(15,2);
BEGIN
   SELECT stock_clos_price
   INTO l_price
   FROM hist#_mkt_data
   WHERE opt_cde = pi_opt_cde
   AND cont_mth = TO_CHAR(pi_val_dt,'YYYYMM')
   AND rpt_dt = ( SELECT MAX(rpt_dt)
                  FROM    hist#_mkt_data
                  WHERE opt_cde = pi_opt_cde
                  AND cont_mth = TO_CHAR(pi_val_dt,'YYYYMM')
                  AND daily_high > 0
   )
   AND ROWNUM < 2;
   RETURN l_price;
EXCEPTION
WHEN OTHERS THEN
   RETURN NULL;
END;
--
FUNCTION stock_clos_price( pi_opt_cde IN VARCHAR2, pi_val_dt IN DATE ) RETURN NUMBER IS
   l_price   NUMBER(15,2);
BEGIN
   SELECT stock_clos_price
   INTO l_price
   FROM hist#_mkt_data
   WHERE opt_cde = pi_opt_cde
   AND rpt_dt = pi_val_dt
   AND ROWNUM < 2;
   RETURN l_price;
EXCEPTION
WHEN OTHERS THEN
   RETURN NULL;
END stock_clos_price;
--
FUNCTION setl_price( pi_opt_cde IN VARCHAR2, pi_val_dt IN DATE
               , pi_cont_mth IN VARCHAR2, pi_strike IN NUMBER, pi_call_put IN VARCHAR2 ) RETURN NUMBER IS
   l_price   NUMBER(15,2);
BEGIN
   SELECT setl_price 
   INTO l_price
   FROM hist#_mkt_data
   WHERE opt_cde = pi_opt_cde
   AND rpt_dt = pi_val_dt
   AND cont_mth = pi_cont_mth
   AND strike = pi_strike
   AND call_put = pi_call_put;
   RETURN l_price;
EXCEPTION
WHEN OTHERS THEN
   RETURN NULL;
END setl_price;
--
FUNCTION most_vol_strike(pi_opt_cde IN VARCHAR2, pi_val_dt IN DATE, pi_call_put IN VARCHAR2) RETURN NUMBER IS
   l_strike   hist#_mkt_data.strike%TYPE;
BEGIN
   SELECT p.strike
   INTO l_strike
   FROM (
   SELECT strike FROM hist#_mkt_data
         WHERE rpt_dt = pi_val_dt
         AND opt_cde = pi_opt_cde
         AND call_put = pi_call_put
         GROUP BY strike
         ORDER BY SUM(vol) DESC
          ) p
   WHERE ROWNUM < 2;
   RETURN l_strike;
EXCEPTION
WHEN OTHERS THEN
   RETURN NULL;
END most_vol_strike;
--
FUNCTION opt_day_rank(pi_rpt_dt IN DATE, pi_opt_cde IN VARCHAR2) RETURN NUMBER IS
   l_rank   hist#_opt_rank.rank%TYPE;
BEGIN
   SELECT rank 
   INTO l_rank
   FROM hist#_opt_rank
   WHERE rpt_dt = pi_rpt_dt
   AND opt_cde = pi_opt_cde;
   --
   RETURN l_rank;
EXCEPTION
WHEN OTHERS THEN
   RETURN NULL;
END opt_day_rank;
--
FUNCTION get_atm( pi_price IN NUMBER ) RETURN NUMBER IS
BEGIN
   IF pi_price > 300 THEN -- $10
      RETURN ROUND(pi_price / 10,0)*10;
   ELSIF pi_price BETWEEN 200 AND 300 THEN -- $5
      RETURN ROUND(pi_price * 2 / 10,0)*10 / 2;
   ELSIF pi_price BETWEEN 50 AND 200 THEN -- $2.5
      RETURN ROUND(pi_price * 4 / 10,0)*10 / 4;
   ELSIF pi_price BETWEEN 20 AND 50 THEN -- $1
      RETURN ROUND(pi_price,0);
   ELSIF pi_price BETWEEN 10 AND 20 THEN -- $0.5
      RETURN ROUND(pi_price * 20 / 10,0)*10 / 20;
   ELSIF pi_price BETWEEN 5 AND 10 THEN -- $0.25
      RETURN ROUND(pi_price * 40 / 10,0)*10 / 40;
   ELSIF pi_price BETWEEN 1 AND 5 THEN -- $0.1
      RETURN ROUND(pi_price * 100 / 10,0)*10 / 100;
   END IF;
   RETURN pi_price;
END get_atm;
--
FUNCTION get_open_strike(pi_opt_cde IN VARCHAR2, pi_val_dt IN DATE, pi_cont_mth IN VARCHAR2, pi_call_put IN VARCHAR2, pi_itm_pct IN NUMBER) RETURN NUMBER IS
-- pi_itm_pct ITM percent
-- e.g.) For call option, stock price $100
--          pi_itm_pct = 90 (ITM percent 90%);  i.e. required strike price = $100 x 90% = $90 (Strike)
--          pi_itm_pct = 110(ITM percent 110%); i.e. required strike price = $100 x 110% = $110 (Strike)
-- e.g.) For put option, stock price $100
--          pi_itm_pct = 90  (ITM percent 90%);  i.e. required strike price = $100 x (200% - 90%)  = $110 (Strike)
--          pi_itm_pct = 110 (ITM percent 90%);  i.e. required strike price = $100 x (200% - 110%) = $90 (Strike)
   l_strike   hist#_mkt_data.strike%TYPE;
BEGIN
   IF pi_call_put = 'C' THEN
      SELECT MIN(strike)
      INTO l_strike
      FROM hist#_mkt_data
      WHERE opt_cde = pi_opt_cde
      AND rpt_dt = pi_val_dt
      AND cont_mth = pi_cont_mth
      AND call_put = pi_call_put
      AND strike >= pa_zfcc_06.get_atm(stock_clos_price * (pi_itm_pct / 100));
   ELSIF pi_call_put = 'P' THEN
      SELECT MAX(strike)
      INTO l_strike
      FROM hist#_mkt_data
      WHERE opt_cde = pi_opt_cde
      AND rpt_dt = pi_val_dt
      AND cont_mth = pi_cont_mth
      AND call_put = pi_call_put
      AND strike <= pa_zfcc_06.get_atm(stock_clos_price * ((100 - pi_itm_pct + 100) / 100));
   END IF;
   RETURN l_strike;
EXCEPTION
WHEN OTHERS THEN
   RETURN NULL;
END get_open_strike;
   --
   PROCEDURE get_lcm_cont(pi_max_nof_cont IN NUMBER, pi_hand_a IN NUMBER, pi_hand_b IN NUMBER
                        , po_nof_a OUT NUMBER, po_nof_b OUT NUMBER) IS
      TYPE idx_rec IS RECORD (
       exec_a   NUMBER(15,2)
       , exec_b   NUMBER(15,2)
       );
      TYPE idx_array IS TABLE OF idx_rec INDEX BY BINARY_INTEGER;
      idx   idx_array;
      CURSOR least_diff_cr IS
         SELECT long_no, shrt_no FROM ls_matx ORDER BY ABS(diff_amt);
   BEGIN
      DELETE FROM ls_matx;
      FOR i IN 1..pi_max_nof_cont LOOP
         idx(i).exec_a := i * pi_hand_a;
         idx(i).exec_b := i * pi_hand_b;
      END LOOP;
      FOR i IN 1..pi_max_nof_cont LOOP
         FOR j IN 1..pi_max_nof_cont LOOP
            INSERT INTO ls_matx VALUES (i, j, idx(i).exec_a, idx(j).exec_b, (idx(i).exec_a - idx(j).exec_b));
         END LOOP;
      END LOOP;
      OPEN least_diff_cr;
      FETCH least_diff_cr INTO po_nof_a, po_nof_b;
      CLOSE least_diff_cr;
   END get_lcm_cont;
--
FUNCTION get_vol(pi_cde IN VARCHAR2) RETURN NUMBER IS
   l_vol   opt_cont_vol.vol%TYPE;
BEGIN
   SELECT vol
   INTO l_vol
   FROM opt_cont_vol
   WHERE opt_cde = pi_cde;
   RETURN l_vol;
EXCEPTION
WHEN OTHERS THEN
   RETURN NULL;
END get_vol;
--
FUNCTION run_rpt3(pi_long_cde IN VARCHAR2
                  , pi_long_vol IN NUMBER
                  , pi_shrt_cde IN VARCHAR2
                  , pi_shrt_vol IN NUMBER
                  , pi_cont_mth IN VARCHAR2
                  , pi_start_dt IN DATE
                  , pi_itm_pct IN NUMBER) RETURN NUMBER IS
   l_start_dt DATE := pi_start_dt;
   l_open_strike_long NUMBER(15,2);
   l_open_strike_shrt NUMBER(15,2);
   l_long_setl_price NUMBER(15,2);
   l_shrt_setl_price NUMBER(15,2);
   l_long1hand NUMBER(15,2);
   l_shrt1hand NUMBER(15,2);
   l_nof_long PLS_INTEGER;
   l_nof_shrt PLS_INTEGER;
   l_lc_cost   NUMBER(15,2);
   l_lp_cost   NUMBER(15,2);
   FUNCTION has_rpt_data(pi_rpt_dt IN DATE) RETURN BOOLEAN IS
      l_cnt   SMALLINT;
   BEGIN
      SELECT 1 INTO l_cnt FROM dual
         WHERE EXISTS (SELECT 1 FROM hist#_mkt_data h1long
                       WHERE h1long.opt_cde = pi_long_cde
                       AND h1long.call_put = 'C'
                       AND h1long.cont_mth = pi_cont_mth
                       AND h1long.rpt_dt = pi_rpt_dt);
      SELECT 1 INTO l_cnt FROM dual
         WHERE EXISTS (SELECT 1 FROM hist#_mkt_data h1short
                       WHERE h1short.opt_cde = pi_shrt_cde
                       AND h1short.call_put = 'P'
                       AND h1short.cont_mth = pi_cont_mth
                       AND h1short.rpt_dt = pi_rpt_dt);
      RETURN TRUE;
   EXCEPTION
   WHEN OTHERS THEN
      RETURN FALSE;
   END has_rpt_data;
BEGIN
   DELETE FROM ls_reslt_hdr WHERE long_cde = pi_long_cde AND shrt_cde = pi_shrt_cde;
   DELETE FROM ls_reslt_detl WHERE long_cde = pi_long_cde AND shrt_cde = pi_shrt_cde;
   WHILE l_start_dt < ADD_MONTHS(TO_DATE(pi_cont_mth,'YYYYMM'),1) LOOP
      IF has_rpt_data(l_start_dt) THEN
         l_open_strike_long := get_open_strike(pi_long_cde, l_start_dt, pi_cont_mth, 'C', pi_itm_pct);
         l_open_strike_shrt := get_open_strike(pi_shrt_cde, l_start_dt, pi_cont_mth, 'P', pi_itm_pct);
         l_long_setl_price := pa_zfcc_06.setl_price( pi_long_cde, l_start_dt, pi_cont_mth, l_open_strike_long, 'C' );
         l_shrt_setl_price := pa_zfcc_06.setl_price( pi_shrt_cde, l_start_dt, pi_cont_mth, l_open_strike_shrt, 'P' );
         l_long1hand := (l_open_strike_long + l_long_setl_price) * pi_long_vol;
         l_shrt1hand := (l_open_strike_shrt - l_shrt_setl_price) * pi_shrt_vol;
         get_lcm_cont(pi_max_nof_cont => 10, pi_hand_a => l_long1hand, pi_hand_b => l_shrt1hand
                        , po_nof_a => l_nof_long, po_nof_b => l_nof_shrt);
         l_lc_cost := l_nof_long * l_long_setl_price * pi_long_vol;
         l_lp_cost := l_nof_shrt * l_shrt_setl_price * pi_shrt_vol;
         DBMS_OUTPUT.PUT_LINE('Start date: ' || l_start_dt ||' Contract month: ' || pi_cont_mth);
         DBMS_OUTPUT.PUT_LINE('Long : ' || pi_long_cde ||' LC-' || TO_CHAR(l_open_strike_long,'FM999.00') ||'@$' ||TO_CHAR(l_long_setl_price) ||' One hand:$' ||l_long1hand ||'x'||l_nof_long||' =$'||l_nof_long * l_long1hand ||' LC: ' || l_lc_cost);
         DBMS_OUTPUT.PUT_LINE('Short: ' || pi_shrt_cde ||' LP-' || TO_CHAR(l_open_strike_shrt,'FM999.00') ||'@$' ||TO_CHAR(l_shrt_setl_price) ||' One hand:$' ||l_shrt1hand ||'x'||l_nof_shrt||' =$'||l_nof_shrt * l_shrt1hand ||' LP: ' || l_lp_cost);
         -- Open position
         INSERT INTO ls_reslt_hdr (
            long_cde,
            shrt_cde,
            cont_mth,
            open_dt,
            sprd_cost,
            lc_cost,
            lp_cost ) VALUES (
            pi_long_cde,
            pi_shrt_cde,
            pi_cont_mth,
            l_start_dt,
            0,
            l_lc_cost,
            l_lp_cost
            );
         -- Profit/loss
         INSERT INTO ls_reslt_detl (
               SELECT pi_long_cde,
                  pi_shrt_cde,
                  pi_cont_mth,
                  l_start_dt,
                  rpt_dt,
                  SUM(profit),
                  (((SUM(profit) - 0 + (l_lc_cost + l_lp_cost)) / (l_lc_cost + l_lp_cost)) -1)*100 profit_pct
               FROM (
                  SELECT h1long.rpt_dt
                     , h1long.opt_cde || TO_CHAR(h1long.strike) "long"
                     , h1long.setl_price
                     , h1long.strike + h1long.setl_price exec_price
                     , l_nof_long nos
                     , (h1long.strike + h1long.setl_price) * pi_long_vol * l_nof_long exec_cost
                     , (h1long.setl_price - l_long_setl_price) * pi_long_vol * l_nof_long profit
                  FROM hist#_mkt_data h1long
                  WHERE h1long.opt_cde = pi_long_cde
                  AND h1long.strike = l_open_strike_long
                  AND h1long.call_put = 'C'
                  AND h1long.cont_mth = pi_cont_mth
                  AND h1long.rpt_dt >= l_start_dt
                  UNION ALL
                  SELECT h1short.rpt_dt
                     , h1short.opt_cde || TO_CHAR(h1short.strike) "short"
                     , h1short.setl_price
                     , h1short.strike - h1short.setl_price exec_price
                     , l_nof_shrt
                     , (h1short.strike - h1short.setl_price) * 100 * l_nof_shrt exec_cost
                     , (h1short.setl_price - l_shrt_setl_price) * pi_shrt_vol * l_nof_shrt profit
                  FROM hist#_mkt_data h1short
                  WHERE h1short.opt_cde = pi_shrt_cde
                  AND h1short.strike = l_open_strike_shrt
                  AND h1short.call_put = 'P'
                  AND h1short.cont_mth = pi_cont_mth
                  AND h1short.rpt_dt >= l_start_dt
               )
               GROUP BY rpt_dt
            );
      END IF;
      l_start_dt := l_start_dt + 1;
   END LOOP;
   --COMMIT;
   RETURN 0;
END run_rpt3;
--
FUNCTION run_rpt4_detl(pi_long_cde IN VARCHAR2
                  , pi_shrt_cde IN VARCHAR2
                  , pi_cont_mth IN VARCHAR2
                  , pi_itm_pct IN NUMBER
                  , pi_open_dt IN DATE
                  , pi_rpt_dt_fm IN DATE) RETURN NUMBER IS
   c_long_cde_vol   CONSTANT opt_cont_vol.vol%TYPE := pa_zfcc_06.get_vol(pi_long_cde);
   c_shrt_cde_vol   CONSTANT opt_cont_vol.vol%TYPE := pa_zfcc_06.get_vol(pi_shrt_cde);
BEGIN
   FOR rc IN (SELECT h.strike_long, h.strike_shrt, h.hand_vol_long, h.hand_vol_shrt, h.nof_long, h.nof_shrt
              FROM ls_pair_hdr h
              WHERE long_cde = pi_long_cde
              AND shrt_cde = pi_shrt_cde
              AND cont_mth = pi_cont_mth
              AND itm_pct = pi_itm_pct
              AND open_dt = pi_open_dt ) LOOP
         DBMS_OUTPUT.PUT_LINE('run_rpt4_detl ' || pi_open_dt);
         INSERT INTO ls_pair_detl (
            SELECT pi_long_cde, pi_shrt_cde, pi_cont_mth, pi_itm_pct, pi_open_dt
               , rpt_dt, SUM(lc_val), SUM(lp_val)
            FROM ( SELECT lg.rpt_dt
                     , (lg.setl_price * c_long_cde_vol * rc.nof_long) lc_val
                     , 0 lp_val
                  FROM hist#_mkt_data lg
                  WHERE lg.opt_cde = pi_long_cde
                  AND lg.cont_mth = pi_cont_mth
                  AND lg.strike = rc.strike_long
                  AND lg.call_put = 'C'
                  --AND lg.rpt_dt > pi_open_dt
                  AND lg.rpt_dt = pi_rpt_dt_fm
                  UNION ALL
                  SELECT sh.rpt_dt
                     , 0 lc_val
                     , (sh.setl_price * c_shrt_cde_vol * rc.nof_shrt) lp_val
                  FROM hist#_mkt_data sh
                  WHERE sh.opt_cde = pi_shrt_cde
                  AND sh.cont_mth = pi_cont_mth
                  AND sh.strike = rc.strike_shrt
                  AND sh.call_put = 'P'
                  --AND sh.rpt_dt > pi_open_dt
                  AND sh.rpt_dt = pi_rpt_dt_fm
               )
               GROUP BY rpt_dt
            );
   END LOOP;
   RETURN 0;
EXCEPTION
WHEN DUP_VAL_ON_INDEX THEN
   RETURN -4;
END run_rpt4_detl;
--
FUNCTION run_rpt4_detl(pi_start_dt IN DATE := NULL) RETURN NUMBER IS
   c_start_dt   CONSTANT DATE := NVL(pi_start_dt, TRUNC(SYSDATE,'DD')-1);
   l_rc   SMALLINT;
   FUNC_ERROR EXCEPTION;
BEGIN
   DBMS_OUTPUT.PUT_LINE('run_rpt4_detl: ' || c_start_dt);
   DELETE FROM ls_pair_detl
      WHERE rpt_dt >= c_start_dt;
   FOR rc IN (SELECT long_cde, shrt_cde, cont_mth, itm_pct, open_dt
                  , pa_zfcc_06.get_vol(long_cde) long_vol
                  , pa_zfcc_06.get_vol(shrt_cde) shrt_vol
              FROM ls_pair_hdr
              WHERE LAST_DAY(TO_DATE(cont_mth, 'YYYYMM')) > c_start_dt
              GROUP BY long_cde, shrt_cde, cont_mth, itm_pct, open_dt) LOOP
      l_rc := run_rpt4_detl(pi_long_cde => rc.long_cde
                  , pi_shrt_cde => rc.shrt_cde
                  , pi_cont_mth => rc.cont_mth
                  , pi_itm_pct => rc.itm_pct
                  , pi_open_dt => rc.open_dt
                  , pi_rpt_dt_fm => c_start_dt);
      IF l_rc != 0 THEN
         RAISE FUNC_ERROR;
      END IF;
   END LOOP;
   RETURN l_rc;
EXCEPTION
WHEN FUNC_ERROR THEN
   RETURN -3;
WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE('run_rpt4: ' || SQLERRM);
   RETURN -1;
END run_rpt4_detl;
--
FUNCTION run_rpt4_hdr(pi_start_dt IN DATE := NULL) RETURN NUMBER IS
   c_start_dt   CONSTANT DATE := NVL(pi_start_dt, TRUNC(SYSDATE,'DD')-1);
   l_rc   SMALLINT;
   FUNC_ERROR EXCEPTION;
BEGIN
   DBMS_OUTPUT.PUT_LINE('run_rpt4_hdr: ' || c_start_dt);
   DELETE FROM ls_pair_detl
      WHERE open_dt = c_start_dt;
   DELETE FROM ls_pair_hdr 
      WHERE open_dt = c_start_dt;
   FOR rc IN (SELECT long_cde, shrt_cde, cont_mth, itm_pct
                  , pa_zfcc_06.get_vol(long_cde) long_vol
                  , pa_zfcc_06.get_vol(shrt_cde) shrt_vol
              FROM ls_pair_hdr
              WHERE LAST_DAY(TO_DATE(cont_mth, 'YYYYMM')) > c_start_dt
              GROUP BY long_cde, shrt_cde, cont_mth, itm_pct) LOOP
      l_rc := pa_zfcc_06.run_rpt4(pi_long_cde => rc.long_cde
                  , pi_long_vol => rc.long_vol
                  , pi_shrt_cde => rc.shrt_cde
                  , pi_shrt_vol => rc.shrt_vol
                  , pi_cont_mth => rc.cont_mth
                  , pi_start_dt => c_start_dt
                  , pi_itm_pct => rc.itm_pct);
      IF l_rc != 0 THEN
         RAISE FUNC_ERROR;
      END IF;
   END LOOP;
   RETURN l_rc;
EXCEPTION
WHEN FUNC_ERROR THEN
   RETURN -3;
WHEN OTHERS THEN
   DBMS_OUTPUT.PUT_LINE('run_rpt4: ' || SQLERRM);
   RETURN -1;
END run_rpt4_hdr;
--
FUNCTION run_rpt4(pi_long_cde IN VARCHAR2
                  , pi_long_vol IN NUMBER
                  , pi_shrt_cde IN VARCHAR2
                  , pi_shrt_vol IN NUMBER
                  , pi_cont_mth IN VARCHAR2
                  , pi_start_dt IN DATE
                  , pi_itm_pct IN NUMBER
                  , pi_max_nof_cont IN NUMBER := 20
                  , pi_min_cost IN NUMBER := 7000) RETURN NUMBER IS
   c_max_nof_cont   CONSTANT SMALLINT := NVL(pi_max_nof_cont, 20);
   c_min_cost       CONSTANT SMALLINT := NVL(pi_min_cost, 7000);
   l_rc   SMALLINT;
   l_start_dt DATE := pi_start_dt;
   l_hd   ls_pair_hdr%ROWTYPE;
   i   PLS_INTEGER;
   l_nof_long   SMALLINT;
   l_nof_shrt   SMALLINT;
   FUNCTION has_rpt_data(pi_rpt_dt IN DATE) RETURN BOOLEAN IS
      l_cnt   SMALLINT;
   BEGIN
      SELECT cnt INTO l_cnt FROM (
         SELECT 1 cnt FROM dual
            WHERE EXISTS (SELECT 1 FROM hist#_mkt_data h1long
                          WHERE h1long.opt_cde = pi_long_cde
                          AND h1long.call_put = 'C'
                          AND h1long.cont_mth = pi_cont_mth
                          AND h1long.rpt_dt = pi_rpt_dt)
         INTERSECT
         SELECT 1 cnt FROM dual
            WHERE EXISTS (SELECT 1 FROM hist#_mkt_data h1short
                          WHERE h1short.opt_cde = pi_shrt_cde
                          AND h1short.call_put = 'P'
                          AND h1short.cont_mth = pi_cont_mth
                          AND h1short.rpt_dt = pi_rpt_dt)
      );
      RETURN TRUE;
   EXCEPTION
   WHEN OTHERS THEN
      RETURN FALSE;
   END has_rpt_data;
BEGIN
   DELETE FROM ls_pair_hdr
      WHERE long_cde = pi_long_cde
      AND shrt_cde = pi_shrt_cde
      AND cont_mth = pi_cont_mth
      AND itm_pct = pi_itm_pct;
   DELETE FROM ls_pair_detl
      WHERE long_cde = pi_long_cde
      AND shrt_cde = pi_shrt_cde
      AND cont_mth = pi_cont_mth
      AND itm_pct = pi_itm_pct;
   WHILE l_start_dt < ADD_MONTHS(TO_DATE(pi_cont_mth,'YYYYMM'),1) LOOP
      IF has_rpt_data(l_start_dt) THEN
         l_hd := NULL;
         l_hd.long_cde := pi_long_cde;
         l_hd.shrt_cde := pi_shrt_cde;
         l_hd.cont_mth := pi_cont_mth;
         l_hd.itm_pct := pi_itm_pct;
         l_hd.open_dt := l_start_dt;
         l_hd.strike_long := get_open_strike(pi_long_cde, l_start_dt, pi_cont_mth, 'C', pi_itm_pct);
         l_hd.strike_shrt := get_open_strike(pi_shrt_cde, l_start_dt, pi_cont_mth, 'P', pi_itm_pct);
         l_hd.lc_open_price := pa_zfcc_06.setl_price( pi_long_cde, l_start_dt, pi_cont_mth, l_hd.strike_long, 'C' );
         l_hd.lp_open_price := pa_zfcc_06.setl_price( pi_shrt_cde, l_start_dt, pi_cont_mth, l_hd.strike_shrt, 'P' );
         l_hd.hand_vol_long := l_hd.lc_open_price * pi_long_vol;
         l_hd.hand_vol_shrt := l_hd.lp_open_price * pi_shrt_vol;
         get_lcm_cont(pi_max_nof_cont => c_max_nof_cont, pi_hand_a => l_hd.hand_vol_long, pi_hand_b => l_hd.hand_vol_shrt
                    , po_nof_a => l_nof_long, po_nof_b => l_nof_shrt);
         i := 1;
         LOOP
            l_hd.nof_long := l_nof_long * i;
            l_hd.nof_shrt := l_nof_shrt * i;
            l_hd.lc_cost_amt := l_hd.nof_long * l_hd.lc_open_price * pi_long_vol;
            l_hd.lp_cost_amt := l_hd.nof_shrt * l_hd.lp_open_price * pi_shrt_vol;
            l_hd.eqv_long := pa_zfcc_06.stock_clos_price(pi_long_cde, l_start_dt) * pi_long_vol * l_hd.nof_long;
            l_hd.eqv_shrt := pa_zfcc_06.stock_clos_price(pi_shrt_cde, l_start_dt) * pi_shrt_vol * l_hd.nof_shrt;
            i := i + 1;
            EXIT WHEN ((l_hd.lc_cost_amt + l_hd.lp_cost_amt) > c_min_cost)
                  OR l_nof_long * i > c_max_nof_cont
                  OR l_nof_shrt * i  > c_max_nof_cont
                  ;
         END LOOP;
         l_hd.sprd_cost := 0;
         DBMS_OUTPUT.PUT_LINE(pi_long_cde||' vs '||pi_shrt_cde ||' Start: ' || l_start_dt ||' Cont: ' || pi_cont_mth ||' ITM%: '||TO_CHAR(pi_itm_pct));
         --DBMS_OUTPUT.PUT_LINE('Long : ' || pi_long_cde ||' LC-' || TO_CHAR(l_open_strike_long,'FM999.00') ||'@$' ||TO_CHAR(l_long_setl_price) ||' One hand:$' ||l_long1hand ||'x'||l_nof_long||' =$'||l_nof_long * l_long1hand ||' LC: ' || l_lc_cost);
         --DBMS_OUTPUT.PUT_LINE('Short: ' || pi_shrt_cde ||' LP-' || TO_CHAR(l_open_strike_shrt,'FM999.00') ||'@$' ||TO_CHAR(l_shrt_setl_price) ||' One hand:$' ||l_shrt1hand ||'x'||l_nof_shrt||' =$'||l_nof_shrt * l_shrt1hand ||' LP: ' || l_lp_cost);
         -- Open position
         INSERT INTO ls_pair_hdr
                     (long_cde
                    , shrt_cde
                    , cont_mth
                    , itm_pct
                    , open_dt
                    , strike_long
                    , strike_shrt
                    , nof_long
                    , nof_shrt
                    , hand_vol_long
                    , hand_vol_shrt
                    , eqv_long
                    , eqv_shrt
                    , lc_open_price
                    , lp_open_price
                    , lc_cost_amt
                    , lp_cost_amt
                    , sprd_cost)
              VALUES (pi_long_cde, pi_shrt_cde, pi_cont_mth, pi_itm_pct
                    , l_start_dt
                    , l_hd.strike_long
                    , l_hd.strike_shrt
                    , l_hd.nof_long
                    , l_hd.nof_shrt
                    , l_hd.hand_vol_long
                    , l_hd.hand_vol_shrt
                    , l_hd.eqv_long -- eqv_long
                    , l_hd.eqv_shrt -- eqv_shrt
                    , l_hd.lc_open_price
                    , l_hd.lp_open_price
                    , l_hd.lc_cost_amt
                    , l_hd.lp_cost_amt
                    , 0 --sprd_cost
                    );
         -- Profit/loss
         INSERT INTO ls_pair_detl (
            SELECT pi_long_cde, pi_shrt_cde, pi_cont_mth, pi_itm_pct, l_start_dt
               , rpt_dt, SUM(lc_val), SUM(lp_val)
            FROM ( SELECT c.rpt_dt
                     , (c.setl_price * pi_long_vol * l_hd.nof_long) lc_val
                     , 0 lp_val
                  FROM hist#_mkt_data c
                  WHERE c.opt_cde = pi_long_cde
                  AND c.strike = l_hd.strike_long
                  AND c.call_put = 'C'
                  AND c.cont_mth = pi_cont_mth
                  AND c.rpt_dt > l_start_dt
                  UNION ALL
                  SELECT p.rpt_dt
                     , 0 lc_val
                     , (p.setl_price * pi_shrt_vol * l_hd.nof_shrt) lp_val
                  FROM hist#_mkt_data p
                  WHERE p.opt_cde = pi_shrt_cde
                  AND p.strike = l_hd.strike_shrt
                  AND p.call_put = 'P'
                  AND p.cont_mth = pi_cont_mth
                  AND p.rpt_dt > l_start_dt
               )
               GROUP BY rpt_dt
            );
      END IF;
      l_start_dt := l_start_dt + 1;
   END LOOP;
   COMMIT;
   RETURN 0;
END run_rpt4;
--
FUNCTION run_rpt4_update(pi_long_cde IN VARCHAR2
                  , pi_long_vol IN NUMBER
                  , pi_shrt_cde IN VARCHAR2
                  , pi_shrt_vol IN NUMBER
                  , pi_cont_mth IN VARCHAR2
                  , pi_start_dt IN DATE
                  , pi_itm_pct IN NUMBER) RETURN NUMBER IS
-- not yet tested update detail
   l_rc   SMALLINT;
   l_start_dt DATE := pi_start_dt;
   l_hd   ls_pair_hdr%ROWTYPE;
   FUNCTION has_rpt_data(pi_rpt_dt IN DATE) RETURN BOOLEAN IS
      l_cnt   SMALLINT;
   BEGIN
      SELECT cnt INTO l_cnt FROM (
         SELECT 1 cnt FROM dual
            WHERE EXISTS (SELECT 1 FROM hist#_mkt_data h1long
                          WHERE h1long.opt_cde = pi_long_cde
                          AND h1long.call_put = 'C'
                          AND h1long.cont_mth = pi_cont_mth
                          AND h1long.rpt_dt = pi_rpt_dt)
         INTERSECT
         SELECT 1 cnt FROM dual
            WHERE EXISTS (SELECT 1 FROM hist#_mkt_data h1short
                          WHERE h1short.opt_cde = pi_shrt_cde
                          AND h1short.call_put = 'P'
                          AND h1short.cont_mth = pi_cont_mth
                          AND h1short.rpt_dt = pi_rpt_dt)
      );
      RETURN TRUE;
   EXCEPTION
   WHEN OTHERS THEN
      RETURN FALSE;
   END has_rpt_data;
BEGIN
   WHILE l_start_dt < ADD_MONTHS(TO_DATE(pi_cont_mth,'YYYYMM'),1) LOOP
      IF has_rpt_data(l_start_dt) THEN
         l_hd := NULL;
         l_hd.long_cde := pi_long_cde;
         l_hd.shrt_cde := pi_shrt_cde;
         l_hd.cont_mth := pi_cont_mth;
         l_hd.itm_pct := pi_itm_pct;
         l_hd.open_dt := l_start_dt;
         l_hd.strike_long := get_open_strike(pi_long_cde, l_start_dt, pi_cont_mth, 'C', pi_itm_pct);
         l_hd.strike_shrt := get_open_strike(pi_shrt_cde, l_start_dt, pi_cont_mth, 'P', pi_itm_pct);
         l_hd.lc_open_price := pa_zfcc_06.setl_price( pi_long_cde, l_start_dt, pi_cont_mth, l_hd.strike_long, 'C' );
         l_hd.lp_open_price := pa_zfcc_06.setl_price( pi_shrt_cde, l_start_dt, pi_cont_mth, l_hd.strike_shrt, 'P' );
         l_hd.hand_vol_long := (l_hd.strike_long + l_hd.lc_open_price) * pi_long_vol;
         l_hd.hand_vol_shrt := (l_hd.strike_shrt - l_hd.lp_open_price) * pi_shrt_vol;
         get_lcm_cont(pi_max_nof_cont => 10, pi_hand_a => l_hd.hand_vol_long, pi_hand_b => l_hd.hand_vol_shrt
                    , po_nof_a => l_hd.nof_long, po_nof_b => l_hd.nof_shrt);
         l_hd.lc_cost_amt := l_hd.nof_long * l_hd.lc_open_price * pi_long_vol;
         l_hd.lp_cost_amt := l_hd.nof_shrt * l_hd.lp_open_price * pi_shrt_vol;
         l_hd.eqv_long := (l_hd.strike_long + l_hd.lc_open_price) * pi_long_vol * l_hd.nof_long;
         l_hd.eqv_shrt := (l_hd.strike_shrt - l_hd.lp_open_price) * pi_shrt_vol * l_hd.nof_shrt;
         l_hd.sprd_cost := 0;
         DBMS_OUTPUT.PUT_LINE(pi_long_cde||' vs '||pi_shrt_cde ||' Start: ' || l_start_dt ||' Cont: ' || pi_cont_mth ||' ITM%: '||TO_CHAR(pi_itm_pct));
         BEGIN
            -- Open position
            INSERT INTO ls_pair_hdr
                        (long_cde
                       , shrt_cde
                       , cont_mth
                       , itm_pct
                       , open_dt
                       , strike_long
                       , strike_shrt
                       , nof_long
                       , nof_shrt
                       , hand_vol_long
                       , hand_vol_shrt
                       , eqv_long
                       , eqv_shrt
                       , lc_open_price
                       , lp_open_price
                       , lc_cost_amt
                       , lp_cost_amt
                       , sprd_cost)
                 VALUES (pi_long_cde, pi_shrt_cde, pi_cont_mth, pi_itm_pct
                       , l_start_dt
                       , l_hd.strike_long
                       , l_hd.strike_shrt
                       , l_hd.nof_long
                       , l_hd.nof_shrt
                       , l_hd.hand_vol_long
                       , l_hd.hand_vol_shrt
                       , l_hd.eqv_long -- eqv_long
                       , l_hd.eqv_shrt -- eqv_shrt
                       , l_hd.lc_open_price
                       , l_hd.lp_open_price
                       , l_hd.lc_cost_amt
                       , l_hd.lp_cost_amt
                       , 0 --sprd_cost
                       );
         EXCEPTION
         WHEN DUP_VAL_ON_INDEX THEN
            DBMS_OUTPUT.PUT_LINE('DUP_VAL_ON_INDEX');
         END;
         -- Profit/loss
         l_rc := run_rpt4_detl(pi_long_cde => pi_long_cde
                  , pi_shrt_cde => pi_shrt_cde
                  , pi_cont_mth => pi_cont_mth
                  , pi_itm_pct => pi_itm_pct
                  , pi_open_dt => l_start_dt
                  , pi_rpt_dt_fm => l_start_dt
                  );
      END IF;
      l_start_dt := l_start_dt + 1;
   END LOOP;
   --COMMIT;
   RETURN 0;
END run_rpt4_update;
--
FUNCTION run_dbl_shrt(pi_call_cde IN VARCHAR2
                  , pi_put_cde IN VARCHAR2
                  , pi_cont_mth IN VARCHAR2
                  , pi_start_dt IN DATE
                  , pi_itm_pct IN NUMBER
                  , pi_max_nof_cont IN NUMBER := 10
                  , pi_max_prem_amt IN NUMBER := 5000) RETURN NUMBER IS
-- Double short: short call and short put
   c_call_vol   CONSTANT opt_cont_vol.vol%TYPE := pa_zfcc_06.get_vol(pi_call_cde);
   c_put_vol   CONSTANT opt_cont_vol.vol%TYPE := pa_zfcc_06.get_vol(pi_put_cde);
   c_max_prem_amt   CONSTANT SMALLINT := NVL(pi_max_prem_amt, 5000);
   c_eqv_total   CONSTANT SMALLINT := 200000;
   l_open_dt DATE := pi_start_dt;
   l_hd   ss_pair_hdr%ROWTYPE;
   i   PLS_INTEGER;
   l_nof_call   SMALLINT;
   l_nof_put    SMALLINT;
   --
   FUNCTION has_rpt_data(pi_rpt_dt IN DATE) RETURN BOOLEAN IS
      l_cnt   SMALLINT;
   BEGIN
      SELECT cnt INTO l_cnt FROM (
         SELECT 1 cnt FROM dual
            WHERE EXISTS (SELECT 1 FROM hist#_mkt_data h1long
                          WHERE h1long.opt_cde = pi_call_cde
                          AND h1long.call_put = 'C'
                          AND h1long.cont_mth = pi_cont_mth
                          AND h1long.rpt_dt = pi_rpt_dt)
         INTERSECT
         SELECT 1 cnt FROM dual
            WHERE EXISTS (SELECT 1 FROM hist#_mkt_data h1short
                          WHERE h1short.opt_cde = pi_put_cde
                          AND h1short.call_put = 'P'
                          AND h1short.cont_mth = pi_cont_mth
                          AND h1short.rpt_dt = pi_rpt_dt)
      );
      RETURN TRUE;
   EXCEPTION
   WHEN OTHERS THEN
      RETURN FALSE;
   END has_rpt_data;
BEGIN
   DELETE FROM ss_pair_hdr
      WHERE call_cde = pi_call_cde
      AND put_cde = pi_put_cde
      AND cont_mth = pi_cont_mth
      AND itm_pct = pi_itm_pct;
   DELETE FROM ss_pair_detl
      WHERE call_cde = pi_call_cde
      AND put_cde = pi_put_cde
      AND cont_mth = pi_cont_mth
      AND itm_pct = pi_itm_pct;
   WHILE l_open_dt < ADD_MONTHS(TO_DATE(pi_cont_mth,'YYYYMM'),1) LOOP
      IF has_rpt_data(l_open_dt) THEN
         l_hd := NULL;
         l_hd.call_cde := pi_call_cde; --call_cde
         l_hd.put_cde := pi_put_cde; --put_cde
         l_hd.cont_mth := pi_cont_mth; --cont_mth
         l_hd.itm_pct := pi_itm_pct; --itm_pct
         l_hd.open_dt := l_open_dt; --open_dt
         l_hd.call_strike := get_open_strike(pi_call_cde, l_open_dt, pi_cont_mth, 'C', pi_itm_pct); --call_strike
         l_hd.put_strike := get_open_strike(pi_put_cde, l_open_dt, pi_cont_mth, 'P', pi_itm_pct); --put_strike
         l_hd.call_open_price := pa_zfcc_06.setl_price( pi_call_cde, l_open_dt, pi_cont_mth, l_hd.call_strike, 'C' ); --call_open_price
         l_hd.put_open_price := pa_zfcc_06.setl_price( pi_put_cde, l_open_dt, pi_cont_mth, l_hd.put_strike, 'P' ); --put_open_price
         l_hd.hand_vol_call := l_hd.call_strike * c_call_vol; --hand_vol_call
         l_hd.hand_vol_put := l_hd.put_strike * c_put_vol; --hand_vol_put
         get_lcm_cont(pi_max_nof_cont => pi_max_nof_cont, pi_hand_a => l_hd.hand_vol_call, pi_hand_b => l_hd.hand_vol_put
                    , po_nof_a => l_nof_call, po_nof_b => l_nof_put);
         i := 1;
         LOOP
            l_hd.nof_call := l_nof_call * i;
            l_hd.nof_put := l_nof_put * i;
            l_hd.sc_prem_amt := l_hd.nof_call * l_hd.call_open_price * c_call_vol; --sc_prem_amt
            l_hd.sp_prem_amt := l_hd.nof_put * l_hd.put_open_price * c_put_vol; --sp_prem_amt
            l_hd.eqv_call := l_hd.call_strike * c_call_vol * l_hd.nof_call; --eqv_call
            l_hd.eqv_put := l_hd.put_strike * c_put_vol * l_hd.nof_put; --eqv_put
            i := i + 1;
            EXIT WHEN ((l_hd.sc_prem_amt + l_hd.sp_prem_amt) > c_max_prem_amt)
                  OR l_nof_call * i > pi_max_nof_cont
                  OR l_nof_put * i  > pi_max_nof_cont
                  OR (l_hd.eqv_call + l_hd.eqv_put) + (l_hd.call_strike * c_call_vol) + (l_hd.put_strike * c_put_vol) > c_eqv_total
                  ;
         END LOOP;
         DBMS_OUTPUT.PUT_LINE(pi_call_cde||' vs '||pi_put_cde ||' Start: ' || l_open_dt ||' Cont: ' || pi_cont_mth ||' ITM%: '||TO_CHAR(pi_itm_pct));
         -- Header
         INSERT INTO ss_pair_hdr
                  (call_cde
                 , put_cde
                 , cont_mth
                 , itm_pct
                 , open_dt
                 , call_strike
                 , put_strike
                 , nof_call
                 , nof_put
                 , hand_vol_call
                 , hand_vol_put
                 , eqv_call
                 , eqv_put
                 , call_open_price
                 , put_open_price
                 , sc_prem_amt
                 , sp_prem_amt)
           VALUES (l_hd.call_cde
                 , l_hd.put_cde
                 , l_hd.cont_mth
                 , l_hd.itm_pct
                 , l_hd.open_dt
                 , l_hd.call_strike
                 , l_hd.put_strike
                 , l_hd.nof_call
                 , l_hd.nof_put
                 , l_hd.hand_vol_call
                 , l_hd.hand_vol_put
                 , l_hd.eqv_call
                 , l_hd.eqv_put
                 , l_hd.call_open_price
                 , l_hd.put_open_price
                 , l_hd.sc_prem_amt
                 , l_hd.sp_prem_amt
                 );
         -- Profit/loss
         INSERT INTO ss_pair_detl (
            SELECT pi_call_cde, pi_put_cde, pi_cont_mth, pi_itm_pct, l_open_dt
               , rpt_dt, SUM(lc_val), SUM(lp_val)
            FROM ( SELECT c.rpt_dt
                     , (c.setl_price * c_call_vol * l_hd.nof_call) lc_val
                     , 0 lp_val
                  FROM hist#_mkt_data c
                  WHERE c.opt_cde = pi_call_cde
                  AND c.strike = l_hd.call_strike
                  AND c.call_put = 'C'
                  AND c.cont_mth = pi_cont_mth
                  AND c.rpt_dt > l_open_dt
                  UNION ALL
                  SELECT p.rpt_dt
                     , 0 lc_val
                     , (p.setl_price * c_put_vol * l_hd.nof_put) lp_val
                  FROM hist#_mkt_data p
                  WHERE p.opt_cde = pi_put_cde
                  AND p.strike = l_hd.put_strike
                  AND p.call_put = 'P'
                  AND p.cont_mth = pi_cont_mth
                  AND p.rpt_dt > l_open_dt
               )
               GROUP BY rpt_dt
            );
      END IF;
      l_open_dt := l_open_dt + 1;
   END LOOP;
   COMMIT;
   RETURN 0;
END run_dbl_shrt;
--
FUNCTION DECALSHORT( pi_opt_cde IN VARCHAR2, pi_val_dt IN DATE ) RETURN NUMBER IS
   l_short1   NUMBER(15,2);
   l_short2   NUMBER(15,2);
   CURSOR today_price_cr IS
      SELECT DISTINCT rpt_dt
         , opt_cde
         , stock_clos_price
         , pa_zfcc_06.get_atm(stock_clos_price) atm
      FROM hist#_mkt_data
      WHERE daily_high > 0
      AND daily_low > 0
      AND opt_cde = NVL(pi_opt_cde, opt_cde)
      AND rpt_dt = NVL(pi_val_dt, rpt_dt)
      ;
   l_rec   hist#_mkt_short_cp%ROWTYPE;
BEGIN
   DELETE FROM hist#_mkt_short_cp
      WHERE opt_cde = pi_opt_cde
      AND (pi_val_dt IS NULL OR rpt_dt = pi_val_dt);
   FOR rc IN today_price_cr LOOP
      l_rec := NULL;
      l_rec.rpt_dt := rc.rpt_dt;
      l_rec.opt_cde := rc.opt_cde;
      l_rec.stock_clos_price := rc.stock_clos_price;
      l_rec.short_strike := rc.atm;
      l_rec.cont_mth := TO_CHAR(rc.rpt_dt, 'YYYYMM');
      l_short1 := 0;
      l_short2 := 0;
      FOR rc1 IN (SELECT call_put, daily_high, daily_low, iv_pct
                  FROM hist#_mkt_data
                  WHERE opt_cde = rc.opt_cde
                  AND rpt_dt = rc.rpt_dt
                  AND cont_mth = l_rec.cont_mth
                  AND strike = rc.atm) LOOP
         IF rc1.call_put = 'C' THEN
            l_short1 := l_short1 + rc1.daily_high;
            l_short2 := l_short2 + rc1.daily_low;
         ELSE
            l_short1 := l_short1 + rc1.daily_low;
            l_short2 := l_short2 + rc1.daily_high;
         END IF;
         IF l_rec.iv_pct_min IS NULL THEN
            l_rec.iv_pct_min := rc1.iv_pct;
         END IF;
         IF l_rec.iv_pct_max IS NULL THEN
            l_rec.iv_pct_max := rc1.iv_pct;
         END IF;
         IF rc1.iv_pct < l_rec.iv_pct_min THEN
            l_rec.iv_pct_min := rc1.iv_pct;
         END IF;
         IF rc1.iv_pct > l_rec.iv_pct_max THEN
            l_rec.iv_pct_max := rc1.iv_pct;
         END IF;
         /*DBMS_OUTPUT.PUT_LINE('call_put = ' || rc1.call_put);
         DBMS_OUTPUT.PUT_LINE('daily_high = ' || rc1.daily_high);
         DBMS_OUTPUT.PUT_LINE('daily_low = ' || rc1.daily_low);
         DBMS_OUTPUT.PUT_LINE('iv_pct = ' || rc1.iv_pct);*/
      END LOOP;
      IF l_short1 > l_short2 THEN
         l_rec.short_min := l_short2;
         l_rec.short_max := l_short1;
      ELSE
         l_rec.short_min := l_short1;
         l_rec.short_max := l_short2;
      END IF;
      /*DBMS_OUTPUT.PUT_LINE('l_rec.iv_pct_min = ' || l_rec.iv_pct_min);
      DBMS_OUTPUT.PUT_LINE('l_rec.iv_pct_max = ' || l_rec.iv_pct_max);
      DBMS_OUTPUT.PUT_LINE('l_rec.short_min = ' || l_rec.short_min);
      DBMS_OUTPUT.PUT_LINE('l_rec.short_max = ' || l_rec.short_max);*/
      INSERT INTO hist#_mkt_short_cp (rpt_dt
         , opt_cde
         , cont_mth
         , short_strike
         , short_min
         , short_max
         , stock_clos_price
         , iv_pct_min, iv_pct_max) VALUES (l_rec.rpt_dt
         , l_rec.opt_cde
         , l_rec.cont_mth
         , l_rec.short_strike
         , l_rec.short_min
         , l_rec.short_max
         , l_rec.stock_clos_price
         , l_rec.iv_pct_min, l_rec.iv_pct_max);
   END LOOP;
   COMMIT;
   RETURN 0;
EXCEPTION 
WHEN OTHERS THEN 
   DBMS_OUTPUT.PUT_LINE('OTHERS: ' || SQLERRM);
   RETURN -1; 
END;
--
   FUNCTION DECALOPT1( pi_opt_cde IN VARCHAR2, pi_cont_mth IN VARCHAR2, pi_call_put IN VARCHAR2 ) RETURN NUMBER IS
      l_nof_day_left   PLS_INTEGER;
      l_nof_day_hah   PLS_INTEGER; -- No. of days highest price above highest initial price
      l_nof_day_mah   PLS_INTEGER; -- No. of days middle  price above highest initial price
      l_nof_day_lah   PLS_INTEGER; -- No. of days lowest  price above highest initial price
      --
      l_nof_day_ham   PLS_INTEGER; -- No. of days highest price above middle initial price
      l_nof_day_mam   PLS_INTEGER; -- No. of days middle  price above middle initial price
      l_nof_day_lam   PLS_INTEGER; -- No. of days lowest  price above middle initial price
      --
      l_nof_day_hal   PLS_INTEGER; -- No. of days highest price above lowest initial price
      l_nof_day_mal   PLS_INTEGER; -- No. of days middle  price above lowest initial price
      l_nof_day_lal   PLS_INTEGER; -- No. of days lowest  price above lowest initial price
      --
      l_hp_lowest_profit   NUMBER(15,2); -- Lowest profit percentage for highest initial price
      l_hp_highest_profit   NUMBER(15,2); -- Highest profit percentage for highest initial price
      --
      l_mp_lowest_profit   NUMBER(15,2); -- Lowest profit percentage for middle  initial price
      l_mp_highest_profit   NUMBER(15,2); -- Highest profit percentage for middle  initial price
      --
      l_lp_lowest_profit   NUMBER(15,2); -- Lowest profit percentage for lowest  initial price
      l_lp_Highest_profit   NUMBER(15,2); -- Highest profit percentage for lowest  initial price
   BEGIN
      FOR rc IN (SELECT DISTINCT rpt_dt
                    , opt_cde
                    , stock_clos_price
                    , pa_zfcc_06.get_atm(stock_clos_price) atm
                 FROM hist#_mkt_data
                 WHERE daily_high > 0
                 AND daily_low > 0
                 AND opt_cde = pi_opt_cde
                 AND cont_mth = pi_cont_mth
                 AND call_put = pi_call_put
                 ) LOOP
         DBMS_OUTPUT.PUT_LINE(rc.rpt_dt ||' closed at $'|| TO_CHAR(rc.stock_clos_price,'FM990.00')||', atm @$'|| rc.atm);
         FOR init_rc IN (SELECT call_put, daily_high, daily_low, iv_pct
                     FROM hist#_mkt_data
                     WHERE daily_high > 0
                     AND daily_low > 0
                     AND opt_cde = rc.opt_cde
                     AND rpt_dt = rc.rpt_dt
                     AND cont_mth = pi_cont_mth
                     AND call_put = pi_call_put
                     AND strike = rc.atm) LOOP
            DBMS_OUTPUT.PUT_LINE('> ' || init_rc.call_put ||'; H:'|| TO_CHAR(init_rc.daily_high,'FM990.00')||'; L:'|| TO_CHAR(init_rc.daily_low,'FM990.00') ||'; IV:'||TO_CHAR(init_rc.iv_pct));
            l_nof_day_left := 0;
            l_nof_day_hah := 0;
            l_nof_day_mah := 0;
            l_nof_day_lah := 0;
            l_hp_lowest_profit := 999;
            l_hp_highest_profit := 0;
            l_mp_lowest_profit := 999;
            l_mp_highest_profit := 0;
            l_lp_lowest_profit := 999;
            l_lp_highest_profit := 0;
            FOR aft_rc IN (SELECT rpt_dt aft_rpt_dt, daily_high, daily_low, iv_pct, stock_clos_price
                     FROM hist#_mkt_data
                     WHERE opt_cde = rc.opt_cde
                     AND rpt_dt > rc.rpt_dt
                     AND cont_mth = pi_cont_mth
                     AND call_put = pi_call_put
                     AND strike = rc.atm
                     ) LOOP
               --DBMS_OUTPUT.PUT_LINE('>> ' || aft_rc.aft_rpt_dt ||'; H:'|| TO_CHAR(aft_rc.daily_high,'FM990.00')||'; L:'|| TO_CHAR(aft_rc.daily_low,'FM990.00') ||'; IV:'||TO_CHAR(aft_rc.iv_pct));
               l_nof_day_left := l_nof_day_left + 1;
               IF aft_rc.daily_high > init_rc.daily_high THEN
                  l_nof_day_hah := l_nof_day_hah + 1;
                  l_hp_lowest_profit := LEAST(l_hp_lowest_profit, show_profit(aft_rc.daily_high, init_rc.daily_high));
                  l_hp_highest_profit := GREATEST(l_hp_highest_profit, show_profit(aft_rc.daily_high, init_rc.daily_high));
               ELSIF pi_call_put = 'C' AND aft_rc.daily_high = 0 AND aft_rc.daily_low = 0 AND aft_rc.stock_clos_price > rc.stock_clos_price + init_rc.daily_high THEN
                  l_nof_day_hah := l_nof_day_hah + 1;
               ELSIF pi_call_put = 'P' AND aft_rc.daily_high = 0 AND aft_rc.daily_low = 0 AND aft_rc.stock_clos_price < rc.stock_clos_price - init_rc.daily_high THEN
                  l_nof_day_hah := l_nof_day_hah + 1;
               END IF;
               IF ((aft_rc.daily_high + aft_rc.daily_low)/2) > init_rc.daily_high THEN
                  l_nof_day_mah := l_nof_day_mah + 1;
                  l_mp_lowest_profit := LEAST(l_mp_lowest_profit, show_profit(aft_rc.daily_high, init_rc.daily_high));
                  l_mp_highest_profit := GREATEST(l_mp_highest_profit, show_profit(aft_rc.daily_high, init_rc.daily_high));
               ELSIF pi_call_put = 'C' AND aft_rc.daily_high = 0 AND aft_rc.daily_low = 0 AND aft_rc.stock_clos_price > rc.stock_clos_price + init_rc.daily_high THEN
                  l_nof_day_mah := l_nof_day_mah + 1;
               ELSIF pi_call_put = 'P' AND aft_rc.daily_high = 0 AND aft_rc.daily_low = 0 AND aft_rc.stock_clos_price < rc.stock_clos_price - init_rc.daily_high THEN
                  l_nof_day_mah := l_nof_day_mah + 1;
               END IF;
               IF aft_rc.daily_low > init_rc.daily_high THEN
                  l_nof_day_lah := l_nof_day_lah + 1;
                  l_lp_lowest_profit := LEAST(l_lp_lowest_profit, show_profit(aft_rc.daily_high, init_rc.daily_high));
                  l_lp_highest_profit := GREATEST(l_lp_highest_profit, show_profit(aft_rc.daily_high, init_rc.daily_high));
               ELSIF pi_call_put = 'C' AND aft_rc.daily_high = 0 AND aft_rc.daily_low = 0 AND aft_rc.stock_clos_price > rc.stock_clos_price + init_rc.daily_high THEN
                  l_nof_day_lah := l_nof_day_lah + 1;
               ELSIF pi_call_put = 'P' AND aft_rc.daily_high = 0 AND aft_rc.daily_low = 0 AND aft_rc.stock_clos_price < rc.stock_clos_price - init_rc.daily_high THEN
                  l_nof_day_lah := l_nof_day_lah + 1;
               END IF;
            END LOOP;
            IF l_hp_lowest_profit = 999 THEN
               l_hp_lowest_profit := NULL;
            END IF;
            IF l_mp_lowest_profit = 999 THEN
               l_mp_lowest_profit := NULL;
            END IF;
            IF l_lp_lowest_profit = 999 THEN
               l_lp_lowest_profit := NULL;
            END IF;
            IF l_hp_highest_profit = 0 THEN
               l_hp_highest_profit := NULL;
            END IF;
            IF l_mp_highest_profit = 0 THEN
               l_mp_highest_profit := NULL;
            END IF;
            IF l_lp_highest_profit = 0 THEN
               l_lp_highest_profit := NULL;
            END IF;
            DBMS_OUTPUT.PUT     ('>>> Days highest above hightest initial price:' || TO_CHAR(l_nof_day_hah) ||'/'|| TO_CHAR(l_nof_day_left) ||'('|| ROUND(show_pct(l_nof_day_hah, l_nof_day_left),0) ||'%))');
            DBMS_OUTPUT.PUT_LINE(', Profit range:' || TO_CHAR(l_hp_lowest_profit,'FM990.00')||'% - '||TO_CHAR(l_hp_highest_profit,'FM990.00') ||'%');
            DBMS_OUTPUT.PUT     ('>>> Days middle  above hightest initial price:' || TO_CHAR(l_nof_day_mah) ||'/'|| TO_CHAR(l_nof_day_left) ||'('|| ROUND(show_pct(l_nof_day_mah, l_nof_day_left),0) ||'%)');
            DBMS_OUTPUT.PUT_LINE(', Profit range:' || TO_CHAR(l_mp_lowest_profit,'FM990.00')||'% - '||TO_CHAR(l_mp_highest_profit,'FM990.00') ||'%');
            DBMS_OUTPUT.PUT     ('>>> Days lowest  above hightest initial price:' || TO_CHAR(l_nof_day_lah) ||'/'|| TO_CHAR(l_nof_day_left) ||'('|| ROUND(show_pct(l_nof_day_lah, l_nof_day_left),0) ||'%)');
            DBMS_OUTPUT.PUT_LINE(', Profit range:' || TO_CHAR(l_lp_lowest_profit,'FM990.00')||'% - '||TO_CHAR(l_lp_highest_profit,'FM990.00') ||'%');
         END LOOP;
      END LOOP;
      RETURN 0;
   EXCEPTION 
   WHEN OTHERS THEN 
      DBMS_OUTPUT.PUT_LINE('OTHERS: ' || SQLERRM);
      RETURN -1; 
   END DECALOPT1;
   --
   FUNCTION rsi(pi_cde IN VARCHAR2, pi_dt IN DATE, pi_param IN NUMBER) RETURN NUMBER IS
      l_chg   hist#_mkt_data_stock.clos_price%TYPE;
      l_gain  hist#_mkt_data_stock.clos_price%TYPE;
      l_loss  hist#_mkt_data_stock.clos_price%TYPE;
      CURSOR chg_cr IS
         SELECT clos_price
         FROM hist#_mkt_data_stock
         WHERE stock_cde = pi_cde
         AND rpt_dt <= pi_dt
         ORDER BY rpt_dt DESC;
      --
      FUNCTION get_chg RETURN NUMBER IS
         l_clos_price1   hist#_mkt_data_stock.clos_price%TYPE;
         l_clos_price2   hist#_mkt_data_stock.clos_price%TYPE;
         NO_PRICE_RECORD EXCEPTION;
      BEGIN
         OPEN chg_cr;
         FETCH chg_cr INTO l_clos_price1;
         IF chg_cr%NOTFOUND THEN
            RAISE NO_PRICE_RECORD;
         END IF;
         FETCH chg_cr INTO l_clos_price2;
         IF chg_cr%NOTFOUND THEN
            RAISE NO_PRICE_RECORD;
         END IF;
         CLOSE chg_cr;
         DBMS_OUTPUT.PUT_LINE('get_chg = ' || TO_CHAR((l_clos_price1 - l_clos_price2),'FM990.00'));
         RETURN l_clos_price1 - l_clos_price2;
      EXCEPTION
      WHEN OTHERS THEN
         IF chg_cr%ISOPEN THEN
            CLOSE chg_cr;
         END IF;
         RETURN NULL;
      END get_chg;
   BEGIN
      l_chg := get_chg;
      IF l_chg > 0 THEN
         l_gain := l_chg;
         l_loss := 0;
      ELSIF l_chg < 0 THEN
         l_gain := 0;
         l_loss := l_chg;
      ELSIF l_chg = 0 THEN
         l_gain := 0;
         l_loss := 0;
      END IF;
      RETURN NULL;
   END rsi;
   --
   PROCEDURE rpt_vol_chg( -- Option volumn change over time of specific option code
      pi_opt_cde IN VARCHAR2
      , pi_min_vol_pct IN NUMBER := 10 -- Default 10%
      , pio_ref_cr IN OUT rpt_vol_chg_cv) IS
   BEGIN
      OPEN pio_ref_cr FOR
         SELECT
            rpt_dt
            , opt_cde
            , pa_zfcc_06.stock_clos_price( opt_cde, rpt_dt ) STOCK_CLOS_PRICE
            , SUM(ABS(vol)) VOL_ALL
            , SUM(ABS(DECODE(call_put,'C',vol,0))) VOL_CALL
            , SUM(ABS(DECODE(call_put,'P',vol,0))) VOL_PUT
            , ROUND(SUM(ABS(vol)) / SUM(open_interest) * 100, 2) VOL_PCT
            , SUM(open_interest) OI
         FROM hist#_mkt_data 
         WHERE opt_cde = pi_opt_cde
         GROUP BY rpt_dt, opt_cde
         HAVING SUM(open_interest) > 0
         AND SUM(ABS(vol)) / SUM(open_interest) * 100 >= pi_min_vol_pct
         ORDER BY rpt_dt DESC;
   END rpt_vol_chg;
   --
   PROCEDURE upd_vol_rank( pi_rpt_dt IN DATE := NULL ) IS
      l_rpt_dt DATE := pi_rpt_dt;
      l_rank   PLS_INTEGER := 0;
   BEGIN
      IF l_rpt_dt IS NULL THEN
         SELECT MAX(rpt_dt) INTO l_rpt_dt FROM hist#_mkt_data;
      END IF;
      --
      FOR rc IN (SELECT opt_cde
                    , SUM(open_interest) oi
                    , SUM(vol) vol
                    , ROUND(SUM(vol) / SUM(open_interest) * 100,2) vol_pct
                 FROM hist#_mkt_data 
                 WHERE rpt_dt = l_rpt_dt
                 GROUP BY opt_cde
                 HAVING SUM(open_interest) != 0
                 ORDER BY 4 DESC, 3 DESC, 2 DESC) LOOP
         l_rank := l_rank + 1;
         INSERT INTO hist#_opt_rank (rpt_dt, opt_cde, rank, open_interest, vol, vol_pct) VALUES (
            l_rpt_dt, rc.opt_cde, l_rank, rc.oi, rc.vol, rc.vol_pct);
      END LOOP;
      --COMMIT;
      DBMS_OUTPUT.PUT_LINE('DONE');
   EXCEPTION
   WHEN OTHERS THEN
      ROLLBACK;
      DBMS_OUTPUT.PUT_LINE(SQLERRM);
   END upd_vol_rank;
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
   FUNCTION get_pct_chg(pi_open IN NUMBER, pi_close IN NUMBER) RETURN NUMBER IS
   BEGIN
      RETURN ((pi_close / pi_open) - 1) * 100;
   END get_pct_chg;
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
         , ABS(ROUND(pa_zfcc_06.get_pct_chg( lot_amt_a, lot_amt_b ), 1)) diff_in_pct
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
         ORDER BY ABS(ROUND(pa_zfcc_06.get_pct_chg( lot_amt_a, lot_amt_b ), 1));
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
               pa_zfcc_06.get_best_pair_vols2(pi_price_a => rc.adj_close_a
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
               l_tmp_rec.mtm := pa_zfcc_06.mtm( l_tmp_rec.tx_price_a, rc.adj_close_a, l_tmp_rec.tx_vol_a ) + pa_zfcc_06.mtm( l_tmp_rec.tx_price_b, rc.adj_close_b, l_tmp_rec.tx_vol_b );
               l_tmp_rec.profit_loss := 0;
               l_tmp_rec.signal := 'BUY';
               l_tmp_rec.sts := 'BOUGHT';
            ELSIF rc.signal = 'SELL' THEN
               l_tmp_rec.tx_price_a := rc.adj_close_a;
               pa_zfcc_06.get_best_pair_vols2(pi_price_a => rc.adj_close_a
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
               l_tmp_rec.mtm := pa_zfcc_06.mtm( l_tmp_rec.tx_price_a, rc.adj_close_a, l_tmp_rec.tx_vol_a ) + pa_zfcc_06.mtm( l_tmp_rec.tx_price_b, rc.adj_close_b, l_tmp_rec.tx_vol_b );
               l_tmp_rec.profit_loss := 0;
               l_tmp_rec.signal := 'SELL';
               l_tmp_rec.sts := 'SOLD';
            ELSE -- No signal
               l_tmp_rec.profit_loss := 0;
            END IF;
         ELSIF l_tmp_rec.sts != 'CLOSED' THEN -- Has opened position
            IF rc.signal = 'BUY' AND l_tmp_rec.sts = 'SOLD' THEN -- buy to close
               -- Calculate mtm before calculating l_tmp_rec.tx_amt_a and l_tmp_rec.tx_amt_b
               l_tmp_rec.mtm := pa_zfcc_06.mtm( l_tmp_rec.tx_price_a, rc.adj_close_a, l_tmp_rec.tx_vol_a ) + pa_zfcc_06.mtm( l_tmp_rec.tx_price_b, rc.adj_close_b, l_tmp_rec.tx_vol_b );
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
               l_tmp_rec.mtm := pa_zfcc_06.mtm( l_tmp_rec.tx_price_a, rc.adj_close_a, l_tmp_rec.tx_vol_a ) + pa_zfcc_06.mtm( l_tmp_rec.tx_price_b, rc.adj_close_b, l_tmp_rec.tx_vol_b );
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
                                           , pa_zfcc_06.mtm( l_tmp_rec.tx_price_a, rc.adj_close_a, l_tmp_rec.tx_vol_a ) + pa_zfcc_06.mtm( l_tmp_rec.tx_price_b, rc.adj_close_b, l_tmp_rec.tx_vol_b ))
               , sts = l_tmp_rec.sts
               , profit_loss = l_tmp_rec.profit_loss
               WHERE CURRENT OF navigate_cr;
         END IF;
      END LOOP;
      RETURN 0;
   END pt_orchestra2;
END;
/
