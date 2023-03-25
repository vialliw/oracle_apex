INSERT INTO price_data 
   (SELECT data_date, OPEN, high, low, CLOSE, adj_close, volume, ticker
   FROM tmp_price_data1
   UNION ALL
   SELECT data_date, OPEN, high, low, CLOSE, adj_close, volume, ticker
   FROM tmp_price_data2
   );
