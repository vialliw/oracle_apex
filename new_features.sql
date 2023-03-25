SELECT list_name
, LENGTH(listagg(ticker, ',') WITHIN GROUP (ORDER BY ticker)) listagg_ticker_len
, listagg(DISTINCT ticker, ',') WITHIN GROUP (ORDER BY ticker DESC) listagg_ticker
, listagg(DISTINCT ticker, ',' ON OVERFLOW TRUNCATE 'some more tickers exist') WITHIN GROUP (ORDER BY ticker DESC) listagg_ticker
-- LISTAGG limitation: 4000 length
FROM ticker_list
GROUP BY list_name
ORDER BY list_name;

SELECT *
FROM v$version;

SET SERVEROUTPUT ON SIZE 1000000;

DECLARE
   TYPE numbers_t IS TABLE OF NUMBER;
   l_numbers numbers_t := numbers_t (1, 2, 3 * 3);
BEGIN
   DBMS_OUTPUT.put_line (l_numbers.COUNT);
END;