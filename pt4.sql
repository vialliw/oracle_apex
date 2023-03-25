        SELECT p.pt_id pt_id
                    , RANK() OVER (PARTITION BY p.pt_id ORDER BY a.data_date) seq_no
                    , a.data_date data_time
                    , a.adj_close price_a, a.volume vol_a
                    , b.adj_close price_b, b.volume vol_b
                    , LN(a.adj_close / b.adj_close) l_idx
                    , 'CLOSED' sts
                    , 0 profit_loss
                    , 0 profit_loss_acc
                    , CASE 
                        WHEN RANK() OVER (PARTITION BY p.pt_id ORDER BY a.data_date) <= p.ma
                            THEN NULL
                        WHEN RANK() OVER (PARTITION BY p.pt_id ORDER BY a.data_date) > p.ma
                            THEN  AVG(LN(a.adj_close / b.adj_close)) OVER (ORDER BY a.data_date ROWS BETWEEN p.ma PRECEDING AND 1 PRECEDING)
                      END l_idx_avg
                    , CASE 
                        WHEN RANK() OVER (PARTITION BY p.pt_id ORDER BY a.data_date) <= p.ma
                            THEN NULL
                        WHEN RANK() OVER (PARTITION BY p.pt_id ORDER BY a.data_date) > p.ma
                            THEN  STDDEV(LN(a.adj_close / b.adj_close)) OVER (ORDER BY a.data_date ROWS BETWEEN p.ma PRECEDING AND 1 PRECEDING)
                      END l_idx_stdev
                    , CASE 
                        WHEN RANK() OVER (PARTITION BY p.pt_id ORDER BY a.data_date) <= p.ma
                            THEN NULL
                        WHEN RANK() OVER (PARTITION BY p.pt_id ORDER BY a.data_date) > p.ma
                            THEN pa_zfcc_07.get_zscore(LN(a.adj_close / b.adj_close), AVG(LN(a.adj_close / b.adj_close)) OVER (ORDER BY a.data_date ROWS BETWEEN p.ma PRECEDING AND 1 PRECEDING), STDDEV(LN(a.adj_close / b.adj_close)) OVER (ORDER BY a.data_date ROWS BETWEEN p.ma PRECEDING AND 1 PRECEDING))
                      END z_score
                    , CASE 
                        WHEN RANK() OVER (PARTITION BY p.pt_id ORDER BY a.data_date) <= p.ma
                            THEN NULL
                        WHEN RANK() OVER (PARTITION BY p.pt_id ORDER BY a.data_date) > p.ma
                            AND pa_zfcc_07.get_zscore(LN(a.adj_close / b.adj_close), AVG(LN(a.adj_close / b.adj_close)) OVER (ORDER BY a.data_date ROWS BETWEEN p.ma PRECEDING AND 1 PRECEDING), STDDEV(LN(a.adj_close / b.adj_close)) OVER (ORDER BY a.data_date ROWS BETWEEN p.ma PRECEDING AND 1 PRECEDING)) > 2
                            THEN 'SELL'
                        WHEN RANK() OVER (PARTITION BY p.pt_id ORDER BY a.data_date) > p.ma
                            AND pa_zfcc_07.get_zscore(LN(a.adj_close / b.adj_close), AVG(LN(a.adj_close / b.adj_close)) OVER (ORDER BY a.data_date ROWS BETWEEN p.ma PRECEDING AND 1 PRECEDING), STDDEV(LN(a.adj_close / b.adj_close)) OVER (ORDER BY a.data_date ROWS BETWEEN p.ma PRECEDING AND 1 PRECEDING)) < -2
                            THEN 'BUY'
                      END signal 
        FROM price_data a, price_data b, pt_strtg_ma p
        WHERE a.data_date = b.data_date 
        AND p.ticker_a = a.ticker
        AND p.ticker_b = b.ticker
        AND a.ticker = :pi_ticker_a 
        AND b.ticker = :pi_ticker_b
        AND a.bar_size = 'EOD'
        AND b.bar_size = 'EOD'
        --AND a.data_date BETWEEN TO_DATE('20210505','YYYYMMDD') AND TO_DATE('20210707','YYYYMMDD')
