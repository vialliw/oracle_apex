DECLARE
   l_vol_a SMALLINT;
   l_vol_b SMALLINT;
   /*
   PROCEDURE get_best_pair_vols(pi_price_a IN NUMBER
                     , pi_price_b IN NUMBER
                     , pi_lot_amt IN NUMBER -- lot size e.g.)2,000
                     , po_vol_a OUT NUMBER -- best vol size of ticker a
                     , po_vol_b OUT NUMBER -- best vol size of ticker b
                     ) IS
      i   PLS_INTEGER;
      j   PLS_INTEGER;
      ll_vol_a SMALLINT;
      ll_vol_b SMALLINT;
   BEGIN
      IF pi_price_a > 0 AND pi_price_b > 0 AND pi_lot_amt > 0 THEN
         FOR i IN (TRUNC(pi_lot_amt / pi_price_a) - 2)..(TRUNC(pi_lot_amt / pi_price_a) + 2) LOOP
            ll_vol_a := i;
            FOR j IN (TRUNC(pi_lot_amt / pi_price_b) - 2)..(TRUNC(pi_lot_amt / pi_price_b) + 2) LOOP
               ll_vol_b := j;
               DBMS_OUTPUT.PUT_LINE( ll_vol_a ||','|| ll_vol_b ||'>>$'|| ll_vol_a * pi_price_a ||'>>$'|| ll_vol_b * pi_price_b ||'; diff='|| ABS(ll_vol_a * pi_price_a - ll_vol_b * pi_price_b) );
               IF po_vol_a IS NULL THEN
                  po_vol_a := ll_vol_a;
                  po_vol_b := ll_vol_b;
               ELSIF ABS(ll_vol_a * pi_price_a - ll_vol_b * pi_price_b) < ABS(po_vol_a * pi_price_a - po_vol_b * pi_price_b) THEN 
                  po_vol_a := ll_vol_a;
                  po_vol_b := ll_vol_b;
               END IF;
            END LOOP;
         END LOOP;
         DBMS_OUTPUT.PUT_LINE( 'Ticker A = $' || pi_price_a ||' x '|| po_vol_a ||' = $' || pi_price_a * po_vol_a);
         DBMS_OUTPUT.PUT_LINE( 'Ticker B = $' || pi_price_b ||' x '|| po_vol_b ||' = $' || pi_price_b * po_vol_b);
         DBMS_OUTPUT.PUT_LINE( 'Diff $' || ABS(pi_price_a * po_vol_a - pi_price_b * po_vol_b));
      END IF;
   END get_best_pair_vols;
   */
   PROCEDURE get_best_pair_vols(pi_price_a IN NUMBER
                     , pi_price_b IN NUMBER
                     , pi_lot_amt IN NUMBER -- lot size e.g.)2,000
                     , po_vol_a OUT NUMBER -- best vol size of ticker a
                     , po_vol_b OUT NUMBER -- best vol size of ticker b
                     ) IS
      i   PLS_INTEGER;
      j   PLS_INTEGER;
      ll_vol_a SMALLINT;
      ll_vol_b SMALLINT;
   BEGIN
      IF pi_price_a > 0 AND pi_price_b > 0 AND pi_lot_amt > 0 THEN
         FOR i IN (TRUNC(pi_lot_amt / pi_price_a) - 2)..(TRUNC(pi_lot_amt / pi_price_a) + 2) LOOP
            ll_vol_a := i;
            FOR j IN (TRUNC(pi_lot_amt / pi_price_b) - 2)..(TRUNC(pi_lot_amt / pi_price_b) + 2) LOOP
               ll_vol_b := j;
               DBMS_OUTPUT.PUT_LINE( ll_vol_a ||','|| ll_vol_b ||'>>$'|| ll_vol_a * pi_price_a ||'>>$'|| ll_vol_b * pi_price_b ||'; diff='|| ABS(ll_vol_a * pi_price_a - ll_vol_b * pi_price_b) );
               IF po_vol_a IS NULL THEN
                  po_vol_a := ll_vol_a;
                  po_vol_b := ll_vol_b;
               ELSIF ABS(ll_vol_a * pi_price_a - ll_vol_b * pi_price_b) < ABS(po_vol_a * pi_price_a - po_vol_b * pi_price_b) THEN 
                  po_vol_a := ll_vol_a;
                  po_vol_b := ll_vol_b;
               END IF;
            END LOOP;
         END LOOP;
         DBMS_OUTPUT.PUT_LINE( 'Ticker A = $' || pi_price_a ||' x '|| po_vol_a ||' = $' || pi_price_a * po_vol_a);
         DBMS_OUTPUT.PUT_LINE( 'Ticker B = $' || pi_price_b ||' x '|| po_vol_b ||' = $' || pi_price_b * po_vol_b);
         DBMS_OUTPUT.PUT_LINE( 'Diff $' || ABS(pi_price_a * po_vol_a - pi_price_b * po_vol_b));
      END IF;
      FOR i IN 0..2 LOOP
         DBMS_OUTPUT.PUT_LINE( 'a: ' || TO_CHAR(TRUNC(pi_lot_amt / pi_price_a) - i) );
         FOR j IN 0..2 LOOP
            DBMS_OUTPUT.PUT_LINE( '>b: ' || TO_CHAR(TRUNC(pi_lot_amt / pi_price_b) - j) );
            DBMS_OUTPUT.PUT_LINE( '>b: ' || TO_CHAR(TRUNC(pi_lot_amt / pi_price_b) + j) );
         END LOOP;
         DBMS_OUTPUT.PUT_LINE( 'a: ' || TO_CHAR(TRUNC(pi_lot_amt / pi_price_a) + i) );
         FOR j IN 0..2 LOOP
            DBMS_OUTPUT.PUT_LINE( '>b: ' || TO_CHAR(TRUNC(pi_lot_amt / pi_price_b) - j) );
            DBMS_OUTPUT.PUT_LINE( '>b: ' || TO_CHAR(TRUNC(pi_lot_amt / pi_price_b) + j) );
         END LOOP;
      END LOOP;
   END get_best_pair_vols;
BEGIN
   get_best_pair_vols( 280.66367, 345.33066, 2000, l_vol_a, l_vol_b );
   DBMS_OUTPUT.PUT_LINE( 'min diff vol: ' || l_vol_a ||','|| l_vol_b );
END;
/
