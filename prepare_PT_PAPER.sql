SELECT a.pt_id, b.seq_no
, CASE WHEN b.seq_no <= a.ma THEN NULL
       WHEN b.seq_no > a.ma THEN  AVG(LN(b.price_a / b.price_b)) OVER (ORDER BY b.seq_no ROWS BETWEEN a.ma PRECEDING AND 1 PRECEDING)
       END l_idx_avg
, CASE WHEN b.seq_no <= a.ma THEN NULL
       WHEN b.seq_no > a.ma THEN  STDDEV(LN(b.price_a / b.price_b)) OVER (ORDER BY b.seq_no ROWS BETWEEN a.ma PRECEDING AND 1 PRECEDING)
       END l_idx_stdev
-- REF ONLY
, a.ticker_a, a.ticker_b
, a.ma, b.price_a, b.price_b, b.l_idx
FROM pt_strtg_ma a, pt_price b
WHERE a.ticker_a = b.ticker_a
AND a.ticker_b = b.ticker_b
AND a.ticker_a = :pi_ticker_a
AND a.ticker_b = :pi_ticker_b
AND a.pt_id = 570
ORDER BY a.pt_id, b.seq_no;

SELECT a.pt_id, b.seq_no
FROM pt_strtg_ma a, pt_price b
WHERE a.ticker_a = b.ticker_a
AND a.ticker_b = b.ticker_b
AND a.ticker_a = :pi_ticker_a
AND a.ticker_b = :pi_ticker_b;

SELECT a.ma, a.pt_id, b.seq_no
FROM pt_strtg_ma a, pt_price b
WHERE a.ticker_a = b.ticker_a
AND a.ticker_b = b.ticker_b
AND a.ticker_a = 'WEC'
AND a.ticker_b = 'XEL'
ORDER BY a.ma;

SELECT a.ma, a.pt_id, COUNT(1)
FROM pt_strtg_ma a, pt_price b
WHERE a.ticker_a = b.ticker_a
AND a.ticker_b = b.ticker_b
AND a.ticker_a = 'WEC'
AND a.ticker_b = 'XEL'
GROUP BY a.ma, a.pt_id
ORDER BY a.ma, a.pt_id;

SELECT ma, MIN(pt_id), MAX(pt_id)
FROM pt_strtg_ma 
GROUP BY ma
ORDER BY ma;

SELECT ma, pt_id
FROM pt_strtg_ma 
ORDER BY ma, pt_id;

SELECT *
FROM pt_strtg_ma 
ORDER BY pt_id;

SELECT COUNT(1)
FROM pt_paper;

SELECT *
FROM pt_paper
ORDER BY pt_id, seq_no;

SELECT b.pt_id, b.seq_no, a.l_idx, b.l_idx_avg, b.l_idx_stdev, b.z_score
FROM pt_paper b, pt_price a
WHERE a.seq_no = b.seq_no
AND b.pt_id < 567
ORDER BY b.pt_id, b.seq_no;

SELECT b.pt_id, b.seq_no, a.l_idx, b.l_idx_avg, b.l_idx_stdev, b.z_score
FROM pt_paper b, pt_price a
WHERE a.seq_no = b.seq_no
--AND b.pt_id < 567
ORDER BY  b.seq_no, b.pt_id;

SELECT a.ma, a.pt_id, MIN(b.l_idx_avg), MAX(b.l_idx_avg)
FROM pt_strtg_ma a, pt_paper b
WHERE a.pt_id = b.pt_id
AND a.ticker_a = 'WEC'
AND a.ticker_b = 'XEL'
GROUP BY a.ma, a.pt_id
ORDER BY a.ma, a.pt_id;

SELECT MAX(pt_id) FROM pt_paper;

select *
from pt_strtg_ma
WHERE pt_id = 3064;
