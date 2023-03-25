-- @C:\Users\edvw\Documents\trade\prep_pt_analysis2.sql
@ON
SPOOL d:\prod_in\prep_pt_analysis2.txt
VARIABLE l_id_no NUMBER;
VARIABLE ticker_a VARCHAR2(10);
VARIABLE ticker_b VARCHAR2(10);
BEGIN
   SELECT NVL(MAX(id_no), 0) + 1 INTO :l_id_no FROM pt_analysis2;
   :ticker_a := 'IHI';
   :ticker_b := 'SPY';
END;
/
DELETE FROM pt_analysis2 WHERE id_no = :l_id_no;
-- ticker_a
INSERT INTO pt_analysis2 (id_no, seq_no, data_time, ticker_a, ticker_b, open_a, high_a, low_a, close_a, adj_close_a, vol_a)
(SELECT :l_id_no id_no, 
  TO_NUMBER(col_i) seq_no,
  TO_DATE(col_a, 'YYYY-MM-DD') data_time,
  col_h ticker_a,
  NULL ticker_b,
  TO_NUMBER(col_b) open_a,
  TO_NUMBER(col_c) high_a,
  TO_NUMBER(col_d) low_a,
  TO_NUMBER(col_e) close_a,
  TO_NUMBER(col_f) adj_close_a,
  TO_NUMBER(col_g) vol_a
FROM rawdata
WHERE col_h = :ticker_a
);
-- ticker_b
DECLARE
   l_ticker VARCHAR2(10) := :ticker_b;
   CURSOR ticker_b_set_cr IS
      SELECT TO_DATE(col_a, 'YYYY-MM-DD') data_time,
        col_h ticker_b,
        TO_NUMBER(col_b) open_b,
        TO_NUMBER(col_c) high_b,
        TO_NUMBER(col_d) low_b,
        TO_NUMBER(col_e) close_b,
        TO_NUMBER(col_f) adj_close_b,
        TO_NUMBER(col_g) vol_b
      FROM rawdata
      WHERE col_h = l_ticker
      ORDER BY col_a
      ;
BEGIN
   --DBMS_OUTPUT.PUT_LINE( 'l_ticker = ' || l_ticker );
   FOR rc IN ticker_b_set_cr LOOP
      UPDATE pt_analysis2
         SET ticker_b = rc.ticker_b, 
             open_b = rc.open_b,
             high_b = rc.high_b,
             low_b = rc.low_b, 
             close_b = rc.close_b,
             adj_close_b = rc.adj_close_b,
             vol_b = rc.vol_b
         WHERE id_no = :l_id_no
         AND data_time = rc.data_time;
      --DBMS_OUTPUT.PUT_LINE( 'SQL%ROWCOUNT = ' || SQL%ROWCOUNT );
   END LOOP;
END;
/
COMMIT;
SET ECHO ON;
SELECT COUNT(1) FROM rawdata WHERE col_h = :ticker_a;
SELECT COUNT(1) FROM rawdata WHERE col_h = :ticker_b;
SELECT COUNT(1) 
FROM pt_analysis2
WHERE id_no = :l_id_no;
SELECT COUNT(1) 
FROM pt_analysis2
WHERE id_no = :l_id_no
AND ticker_b IS NULL;
--
PRINT
--
SPOOL OFF;

SELECT col_h
, MIN(TO_DATE(col_a,'DD-MM-YYYY')) start_dt
, MAX(TO_DATE(col_a,'DD-MM-YYYY')) end_dt
, MONTHS_BETWEEN(MAX(TO_DATE(col_a,'DD-MM-YYYY')), MIN(TO_DATE(col_a,'DD-MM-YYYY'))) MTHS
FROM rawdata
WHERE col_h IN ('SPY','AVGO')
GROUP BY col_h

SELECT MAX(start_dt) fm_dt, MIN(end_dt) to_dt
FROM (
SELECT col_h
, MIN(TO_DATE(col_a,'DD-MM-YYYY')) start_dt
, MAX(TO_DATE(col_a,'DD-MM-YYYY')) end_dt
, MONTHS_BETWEEN(MAX(TO_DATE(col_a,'DD-MM-YYYY')), MIN(TO_DATE(col_a,'DD-MM-YYYY'))) MTHS
FROM rawdata
WHERE col_h IN ('SPY','AVGO')
GROUP BY col_h
);

DECLARE
   l_rc SMALLINT;
   FUNCTION put_pairs_data(pi_ticker_a IN VARCHAR2, pi_ticker_b IN VARCHAR2, pi_date_fmt_mask IN VARCHAR2 := 'DD-MM-YYYY') RETURN NUMBER IS
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
BEGIN
   l_rc := put_pairs_data( 'SPY', 'AVGO', 'DD-MM-YYYY' );
   DBMS_OUTPUT.PUT_LINE(l_rc);
END;
/
