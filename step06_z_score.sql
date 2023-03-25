VARIABLE pi_id_no NUMBER;
VARIABLE pi_seq_no NUMBER;
BEGIN
   :pi_id_no := 1;
   :pi_seq_no := 30;
END;
/
-- Clean first
UPDATE pt_analysis SET z_score = NULL WHERE id_no = :pi_id_no;
--
UPDATE pt_analysis
    SET z_score = (l_idx - l_idx_avg) / l_idx_stdev
    WHERE id_no = :pi_id_no
    AND seq_no > :pi_seq_no;
--
COMMIT;
