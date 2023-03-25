-- This script should be run in SQL*PLUS
SET SERVEROUTPUT ON SIZE 1000000;
VARIABLE id_no NUMBER;
--

DECLARE
   l_rc SMALLINT;
BEGIN
   l_rc := pa_zfcc_07.put_pairs_data2('MA', 'V');
--   :id_no := l_rc;
   DBMS_OUTPUT.PUT_LINE(l_rc);
END;
/

--

SELECT *
FROM pt_analysis3
WHERE id_no = :id_no
AND ROWNUM < 6;