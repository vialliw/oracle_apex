/*
SELECT p.pt_id id_no
                , p.ma
                , RANK() OVER (PARTITION BY p.pt_id ORDER BY a.data_date) seq_no
                , a.data_date data_time, a.ticker ticker_a, b.ticker ticker_b
                , a.adj_close adj_close_a, a.volume vol_a
                , b.adj_close adj_close_b, b.volume vol_b
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
         AND p.pt_id BETWEEN 600 AND 601
         AND a.bar_size = 'EOD'
         AND b.bar_size = 'EOD'
         AND a.data_date BETWEEN TO_DATE('20100105','YYYYMMDD') AND TO_DATE('20100331','YYYYMMDD')
         ORDER BY id_no, a.data_date
         ;
*/
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
set serveroutput on size 1000000;
DECLARE
    c_id_no CONSTANT NUMBER(20) := 62;
    pi_ma   NUMBER := 10;
    pi_ticker_a   VARCHAR2(10) := 'WEC';
    pi_ticker_b   VARCHAR2(10) := 'XEL';
    CURSOR pta_cr IS
        SELECT *
        FROM pt_analysis3
        WHERE id_no = c_id_no
        ORDER BY seq_no
        FOR UPDATE OF l_idx_avg, l_idx_stdev;
   TYPE pta_seqs_t IS TABLE OF pt_analysis3.seq_no%TYPE INDEX BY PLS_INTEGER;
   l_pta_seqs   pta_seqs_t;
   l_pta_ma   pta_seqs_t;
   TYPE avg_t IS TABLE OF pt_analysis3.l_idx_avg%TYPE;
   l_avgs avg_t;
   TYPE stdev_t IS TABLE OF pt_analysis3.l_idx_stdev%TYPE;
   l_stdevs stdev_t;
   TYPE pt4_rc IS RECORD (
     pt_id pt_analysis4.pt_id%TYPE
     , seq_no pt_analysis4.seq_no%TYPE
     , data_time DATE
     , price_a pt_analysis4.price_a%TYPE
     , vol_a pt_analysis4.vol_a%TYPE
     , price_b pt_analysis4.price_B%TYPE
     , vol_b pt_analysis4.vol_b%TYPE
     , l_idx pt_analysis4.l_idx%TYPE
     , sts pt_analysis4.sts%TYPE
     , profit_loss pt_analysis4.profit_loss%TYPE
     , profit_loss_acc pt_analysis4.profit_loss_acc%TYPE
     , l_idx_avg pt_analysis4.l_idx_avg%TYPE
     , l_idx_stdev pt_analysis4.l_idx_stdev%TYPE
     , z_score pt_analysis4.z_score%TYPE
     , signal pt_analysis4.signal%TYPE
   );
   TYPE pt4_t IS TABLE OF pt4_rc;
   l_pt4_t pt4_t;
BEGIN
    DELETE FROM pt_analysis4;
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
    BULK COLLECT INTO l_pt4_t
    FROM price_data a, price_data b, pt_strtg_ma p
    WHERE a.data_date = b.data_date 
    AND p.ticker_a = a.ticker
    AND p.ticker_b = b.ticker
    AND a.ticker = pi_ticker_a 
    AND b.ticker = pi_ticker_b
    AND p.pt_id BETWEEN 600 AND 601
    AND a.bar_size = 'EOD'
    AND b.bar_size = 'EOD'
    AND a.data_date BETWEEN TO_DATE('20100105','YYYYMMDD') AND TO_DATE('20100331','YYYYMMDD')
    ORDER BY p.pt_id, a.data_date
    ;
    DBMS_OUTPUT.PUT_LINE(l_pt4_t.COUNT);
    FORALL idx IN 1 .. l_pt4_t.COUNT
        INSERT INTO pt_analysis4 (pt_id, seq_no
     , data_time
     , price_a
     , vol_a
     , price_b
     , vol_b
     , l_idx
     , sts
     , profit_loss
     , profit_loss_acc
     , l_idx_avg
     , l_idx_stdev
     , z_score
     , signal
        )
        VALUES (l_pt4_t(idx).pt_id, l_pt4_t(idx).seq_no
     , l_pt4_t(idx).data_time
     , l_pt4_t(idx).price_a
     , l_pt4_t(idx).vol_a
     , l_pt4_t(idx).price_b
     , l_pt4_t(idx).vol_b
     , l_pt4_t(idx).l_idx
     , l_pt4_t(idx).sts
     , l_pt4_t(idx).profit_loss
     , l_pt4_t(idx).profit_loss_acc
     , l_pt4_t(idx).l_idx_avg
     , l_pt4_t(idx).l_idx_stdev
     , l_pt4_t(idx).z_score
     , l_pt4_t(idx).signal
        );
    DBMS_OUTPUT.PUT_LINE('bulk insert done');
    /*
    -- l_pta_seqs
    SELECT seq_no BULK COLLECT INTO l_pta_seqs FROM pt_analysis3 WHERE id_no = c_id_no;
    -- l_pta_ma
    FOR idx IN 1 .. l_pta_seqs.COUNT LOOP
        IF l_pta_seqs (idx) > pi_ma THEN
            l_pta_ma (l_pta_ma.COUNT + 1) := l_pta_seqs(idx);
        END IF;
    END LOOP;
    -- Calculate average and stdev into collection
    SELECT seq_no,
         AVG(l_idx) OVER (ORDER BY data_time ROWS BETWEEN pi_ma PRECEDING AND 1 PRECEDING) AS l_idx_avg,
         STDDEV(l_idx) OVER (ORDER BY data_time ROWS BETWEEN pi_ma PRECEDING AND 1 PRECEDING) AS l_idx_stddev
         BULK COLLECT INTO l_pta_seqs, l_avgs, l_stdevs
    FROM pt_analysis3
    WHERE id_no = c_id_no
    ORDER BY seq_no;
    --
     FORALL idx IN 1 .. l_pta_seqs.COUNT
       UPDATE pt_analysis3 p
          SET p.l_idx_avg = l_avgs (idx),
              p.l_idx_stdev = l_stdevs (idx)
          WHERE p.seq_no = l_pta_seqs (idx);
          */
END;
/



