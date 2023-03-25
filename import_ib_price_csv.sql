set serveroutput on size 1000000;
declare
   t1 pls_integer;
   t2 pls_integer;
   t3 pls_integer;
begin
   t1 := DBMS_UTILITY.get_time;
   DBMS_OUTPUT.PUT_LINE( pa_zfcc_07.import_ib_price('AAPL_52W_1H.csv', 'YYYY-MM-DD HH24:MI:SS') );
   DBMS_OUTPUT.PUT_LINE( pa_zfcc_07.import_ib_price('DHI_52W_1H.csv', 'YYYY-MM-DD HH24:MI:SS') );
   DBMS_OUTPUT.PUT_LINE( pa_zfcc_07.import_ib_price('ITB_52W_1H.csv', 'YYYY-MM-DD HH24:MI:SS') );
   DBMS_OUTPUT.PUT_LINE( pa_zfcc_07.import_ib_price('MSFT_52W_1H.csv', 'YYYY-MM-DD HH24:MI:SS') );
   DBMS_OUTPUT.PUT_LINE( pa_zfcc_07.import_ib_price('RSG_52W_1H.csv', 'YYYY-MM-DD HH24:MI:SS') );
   DBMS_OUTPUT.PUT_LINE( pa_zfcc_07.import_ib_price('WM_52W_1H.csv', 'YYYY-MM-DD HH24:MI:SS') );
   t2 := DBMS_UTILITY.get_time;
   DBMS_OUTPUT.PUT_LINE('Execution Time (secs)' || TO_CHAR((t2 - t1)/100));
end;
/
