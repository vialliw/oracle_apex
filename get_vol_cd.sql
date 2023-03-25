SELECT ROWNUM, :pi_vol_a vol_a, 0 mrg
   , DECODE(ROWNUM, 1, :pi_vol_a + 0,
                    2, :pi_vol_a - 1,
                    3, :pi_vol_a + 1,
                    4, :pi_vol_a -2,
                    5, :pi_vol_a + 2) vol
FROM loan
WHERE ROWNUM <= 5

UNION ALL

SELECT ROWNUM, :pi_vol_b vol_b, 0 mrg
   , DECODE(ROWNUM, 1, :pi_vol_b + 0,
                    2, :pi_vol_b - 1,
                    3, :pi_vol_b + 1,
                    4, :pi_vol_b -2,
                    5, :pi_vol_b + 2) vol
FROM loan
WHERE ROWNUM <= 5


SELECT *
FROM (
SELECT ROWNUM, :pi_vol_a vol_a, 0 mrg
   , DECODE(ROWNUM, 1, :pi_vol_a + 0,
                    2, :pi_vol_a - 1,
                    3, :pi_vol_a + 1,
                    4, :pi_vol_a -2,
                    5, :pi_vol_a + 2) vol
FROM loan
WHERE ROWNUM <= 5 ) a
, (SELECT ROWNUM, :pi_vol_b vol_b, 0 mrg
   , DECODE(ROWNUM, 1, :pi_vol_b + 0,
                    2, :pi_vol_b - 1,
                    3, :pi_vol_b + 1,
                    4, :pi_vol_b -2,
                    5, :pi_vol_b + 2) vol
FROM loan
WHERE ROWNUM <= 5) b


SELECT volxa, volxb, lot_amt_a, lot_amt_b
--, ABS(lot_amt_a - lot_amt_b) diff
--, ROUND(ABS(lot_amt_a - lot_amt_b) / 10000, 4) diff2
, ABS(ROUND(pa_zfcc_06.get_pct_chg( lot_amt_a, lot_amt_b ), 1)) diff_in_pct
FROM (
SELECT /*ROWNUM, :pi_vol_a vol_a, 0 mrg
   , */ DECODE(ROWNUM, 1, :pi_vol_a + 0,
                    2, :pi_vol_a - 1,
                    3, :pi_vol_a + 1,
                    4, :pi_vol_a -2,
                    5, :pi_vol_a + 2) volxa
   , DECODE(ROWNUM, 1, :pi_vol_a + 0,
                    2, :pi_vol_a - 1,
                    3, :pi_vol_a + 1,
                    4, :pi_vol_a -2,
                    5, :pi_vol_a + 2) * :pi_price_a lot_amt_a
FROM loan
WHERE ROWNUM <= 5 ) a
, (SELECT /*ROWNUM, :pi_vol_b vol_b, 0 mrg
   , */ DECODE(ROWNUM, 1, :pi_vol_b + 0,
                    2, :pi_vol_b - 1,
                    3, :pi_vol_b + 1,
                    4, :pi_vol_b -2,
                    5, :pi_vol_b + 2) volxb
   , DECODE(ROWNUM, 1, :pi_vol_b + 0,
                    2, :pi_vol_b - 1,
                    3, :pi_vol_b + 1,
                    4, :pi_vol_b -2,
                    5, :pi_vol_b + 2) * :pi_price_b lot_amt_b
FROM loan
WHERE ROWNUM <= 5) b
ORDER BY ABS(ROUND(pa_zfcc_06.get_pct_chg( lot_amt_a, lot_amt_b ), 1))

   SELECT volxa, volxb, lot_amt_a, lot_amt_b
   , ABS(ROUND(pa_zfcc_06.get_pct_chg( lot_amt_a, lot_amt_b ), 1)) diff_in_pct
   FROM (
      SELECT DECODE(ROWNUM, 1, :pi_vol_a + 0,
                          2, :pi_vol_a - 1,
                          3, :pi_vol_a + 1,
                          4, :pi_vol_a -2,
                          5, :pi_vol_a + 2) volxa
         , DECODE(ROWNUM, 1, :pi_vol_a + 0,
                          2, :pi_vol_a - 1,
                          3, :pi_vol_a + 1,
                          4, :pi_vol_a -2,
                          5, :pi_vol_a + 2) * :pi_price_a lot_amt_a
      FROM pt_analysis2
      WHERE ROWNUM <= 5 ) a
      , (SELECT DECODE(ROWNUM, 1, :pi_vol_b + 0,
                          2, :pi_vol_b - 1,
                          3, :pi_vol_b + 1,
                          4, :pi_vol_b -2,
                          5, :pi_vol_b + 2) volxb
         , DECODE(ROWNUM, 1, :pi_vol_b + 0,
                          2, :pi_vol_b - 1,
                          3, :pi_vol_b + 1,
                          4, :pi_vol_b -2,
                          5, :pi_vol_b + 2) * :pi_price_b lot_amt_b
      FROM pt_analysis2
      WHERE ROWNUM <= 5) b
   ORDER BY ABS(ROUND(pa_zfcc_06.get_pct_chg( lot_amt_a, lot_amt_b ), 1))
