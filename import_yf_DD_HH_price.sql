SET SERVEROUTPUT ON SIZE 1000000;
DECLARE
BEGIN
   DBMS_OUTPUT.PUT_LINE( TO_CHAR(pa_zfcc_07.import_yf_price('XLE.csv', 'YYYY-MM-DD HH24:MI:SS', '1h', 'ORA_DIR')));
   DBMS_OUTPUT.PUT_LINE( TO_CHAR(pa_zfcc_07.import_yf_price('XLE.csv', 'YYYY-MM-DD', 'EOD', 'ORA_DIR_DD')));
END;
/
