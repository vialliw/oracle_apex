DECLARE
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
      WHERE col_h = 'QQQ'
      ORDER BY col_a
      ;
BEGIN
   FOR rc IN ticker_b_set_cr LOOP
      UPDATE pt_analysis
         SET ticker_b = rc.ticker_b, 
             open_b = rc.open_b,
             high_b = rc.high_b,
             low_b = rc.low_b, 
             close_b = rc.close_b,
             adj_close_b = rc.adj_close_b,
             vol_b = rc.vol_b
         WHERE id_no = 1
         AND data_time = rc.data_time;
   END LOOP;
   COMMIT;
END;
/
