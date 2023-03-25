SET SERVEROUTPUT ON SIZE 1000000;
VARIABLE pi_id_no NUMBER;
VARIABLE pi_seq_no NUMBER;
BEGIN
   :pi_id_no := 1;
   :pi_seq_no := 30;
END;
/
DECLARE
   c_id_no CONSTANT SMALLINT := :pi_id_no;
   c_nof_ticks CONSTANT SMALLINT := :pi_seq_no;
   l_avg NUMBER;
   CURSOR calc_avg_cr IS
      SELECT seq_no, l_idx, l_idx_avg
      FROM pt_analysis
      WHERE id_no = c_id_no
      AND seq_no > c_nof_ticks
      ORDER BY seq_no DESC
      FOR UPDATE OF l_idx_avg;
BEGIN
   -- Clean first
   UPDATE pt_analysis SET l_idx_avg = NULL WHERE id_no = c_id_no;
   --
   FOR rc IN calc_avg_cr LOOP
      l_avg := NULL;
      SELECT AVG(l_idx)
      INTO l_avg
      FROM pt_analysis
      WHERE id_no = c_id_no
      AND seq_no BETWEEN (rc.seq_no - c_nof_ticks) AND (rc.seq_no - 1);
      --
      IF l_avg IS NOT NULL THEN
         UPDATE pt_analysis
            SET l_idx_avg = l_avg
            WHERE CURRENT OF calc_avg_cr;
      END IF;
   END LOOP;
   COMMIT;
END;
/
