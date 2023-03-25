INSERT INTO pt_analysis (id_no, seq_no, data_time, ticker_a, ticker_b, open_a, high_a, low_a, close_a, adj_close_a, vol_a)
(SELECT 1 id_no, 
  ROWNUM seq_no,
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
WHERE col_h = 'SPY'
--ORDER BY col_a
);

COMMIT;
