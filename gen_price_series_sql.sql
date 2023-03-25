-- @C:\Users\edvw\Documents\trade\gen_price_series_sql.sql
DROP TABLE t#msg2;
CREATE GLOBAL TEMPORARY TABLE t#msg2( 
msg VARCHAR2(4000)
) ON COMMIT PRESERVE ROWS;
DECLARE
   l_rc VARCHAR2(32767);
   CURSOR ticker_cr IS
      SELECT ticker
      FROM price_data
      WHERE ticker IN ('SPY','V','WEAT','AAPL','MSFT')
      GROUP BY ticker
      ORDER BY DECODE(ticker, 'SPY', 0, 1), AVG(volume * adj_close) DESC;
BEGIN
   DELETE FROM t#msg2;
   -- Select columns clause
   l_rc := 'SELECT a1.data_date';
   FOR rc IN ticker_cr LOOP
      --l_rc := l_rc || ', a' || TO_CHAR(ticker_cr%ROWCOUNT) || '.adj_close price' || TO_CHAR(ticker_cr%ROWCOUNT);
      l_rc := l_rc || ', a' || TO_CHAR(ticker_cr%ROWCOUNT) || '.adj_close ' || rc.ticker;
   END LOOP;
   -- From clause
   l_rc := l_rc || CHR(10) || 'FROM';
   FOR rc IN ticker_cr LOOP
      IF ticker_cr%ROWCOUNT = 1 THEN
         l_rc := l_rc || ' price_data a' || TO_CHAR(ticker_cr%ROWCOUNT);
      ELSE
         l_rc := l_rc || ', price_data a' || TO_CHAR(ticker_cr%ROWCOUNT);
      END IF;
   END LOOP;
   -- Where clause - joins
   FOR rc IN ticker_cr LOOP
      IF ticker_cr%ROWCOUNT = 1 THEN
         l_rc := l_rc || CHR(10) || 'WHERE 1=1';
      ELSE
         l_rc := l_rc || CHR(10) || 'AND a1.data_date = a'|| TO_CHAR(ticker_cr%ROWCOUNT) ||'.data_date ';
      END IF;
   END LOOP;
   -- Where clause - Ticker name, bar_size
   FOR rc IN ticker_cr LOOP
      l_rc := l_rc || CHR(10) || 'AND a'|| TO_CHAR(ticker_cr%ROWCOUNT) ||'.ticker = ' ||'''' ||rc.ticker||'''';
      l_rc := l_rc || CHR(10) || 'AND a'|| TO_CHAR(ticker_cr%ROWCOUNT) ||'.bar_size = ' ||'''' ||'EOD'||'''';
   END LOOP;
   l_rc := l_rc || CHR(10) || 'ORDER BY a1.data_date;';
   INSERT INTO t#msg2 (msg) VALUES (l_rc);
   COMMIT;
   DBMS_OUTPUT.PUT_LINE('Saved in table t#msg2: ' || TO_CHAR(LENGTH(l_rc)));
END;
/
SET LINESIZE 2000;
SET TRIMSPOOL ON;
SET PAGESIZE 0;
COLUMN sql_txt FORMAT A4000;
SELECT msg sql_txt FROM t#msg2;
