VARIABLE pi_id_no NUMBER;
VARIABLE pi_seq_no NUMBER;
VARIABLE pi_buy_threshold NUMBER;
VARIABLE pi_sell_threshold NUMBER;
BEGIN
   :pi_id_no := 1;
   :pi_seq_no := 30;
   :pi_buy_threshold := -2;
   :pi_sell_threshold := 2;
END;
/
-- Clean first
UPDATE pt_analysis SET signal = NULL WHERE id_no = :pi_id_no;
--
UPDATE pt_analysis
    SET signal = DECODE(SIGN(z_score - :pi_buy_threshold), -1, 'BUY', DECODE(SIGN(z_score - :pi_sell_threshold), 1, 'SELL'))
    WHERE id_no = :pi_id_no
    AND z_score IS NOT NULL;
--
COMMIT;
