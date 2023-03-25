SELECT psm.pt_id, pp.seq_no
, pp.price_a, pp.price_b
FROM pt_strtg_ma psm, pt_price pp
WHERE psm.ticker_a = pp.ticker_a
AND psm.ticker_b = pp.ticker_b
AND psm.ticker_a = 'WEC'
AND psm.ticker_b = 'XEL'
ORDER BY psm.pt_id, pp.seq_no;