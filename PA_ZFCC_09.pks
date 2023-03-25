create or replace package pa_zfcc_09 as 
  /* TODO enter package declarations (types, exceptions, methods etc) here */ 
  FUNCTION get_corr( pi_tick_a IN VARCHAR2, pi_tick_b IN VARCHAR2 ) RETURN NUMBER;
end pa_zfcc_09;
/
