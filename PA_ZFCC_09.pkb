create or replace package body pa_zfcc_09 as 
  /* TODO enter package declarations (types, exceptions, methods etc) here */ 
  FUNCTION get_corr( pi_tick_a IN VARCHAR2, pi_tick_b IN VARCHAR2 ) RETURN NUMBER IS
    l_num NUMBER;
  BEGIN
        SELECT --a.ticker,
        --b.ticker,
        corr(a.adj_close, b.adj_close)
        INTO l_num
        FROM (  SELECT p.data_date, p.adj_close, p.ticker
                FROM price_data p
                WHERE p.ticker = pi_tick_a) a
            , ( SELECT p.data_date, p.adj_close, p.ticker
                FROM price_data p
                WHERE p.ticker = pi_tick_b) b
        WHERE a.data_date = b.data_date
        GROUP BY a.ticker, b.ticker;
        RETURN l_num;
  EXCEPTION
  WHEN OTHERS THEN
     RETURN NULL;
  END get_corr;
  --
  FUNCTION get_corr( pi_tick_a IN VARCHAR2, pi_tick_b IN VARCHAR2, pi_nof_mth IN NUMBER ) RETURN NUMBER IS
    l_num NUMBER;
  BEGIN
        RETURN l_num;
  EXCEPTION
  WHEN OTHERS THEN
     RETURN NULL;
  END get_corr;
end pa_zfcc_09;
/
