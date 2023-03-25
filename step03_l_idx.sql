VARIABLE pi_id_no NUMBER;
VARIABLE pi_seq_no NUMBER;
BEGIN
   :pi_id_no := 1;
   :pi_seq_no := 30;
END;
/
/*
SELECT seq_no, adj_close_a, adj_close_b, l_idx
FROM pt_analysis
ORDER BY seq_no;
*/
UPDATE pt_analysis
SET l_idx = LN((adj_close_a / adj_close_b))
WHERE id_no = :pi_id_no;

COMMIT;
/*
SELECT seq_no, adj_close_a, adj_close_b, l_idx
FROM pt_analysis
ORDER BY seq_no;
*/
