-- reset
UPDATE pt_analysis3
      SET l_idx = seq_no
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
      WHERE id_no = :pi_id_no;

COMMIT;

SELECT seq_no, l_idx, l_idx_avg, l_idx_stdev
FROM pt_analysis3
WHERE id_no = :pi_id_no
ORDER BY seq_no;

SELECT seq_no,
     AVG(l_idx) OVER (ORDER BY data_time ROWS BETWEEN :pi_ma PRECEDING AND 1 PRECEDING) AS l_idx_avg,
     STDDEV(l_idx) OVER (ORDER BY data_time ROWS BETWEEN :pi_ma PRECEDING AND 1 PRECEDING) AS l_idx_stddev
FROM pt_analysis3
WHERE id_no = :pi_id_no
ORDER BY seq_no
FOR UPDATE OF l_idx_avg, l_idx_stdev;



