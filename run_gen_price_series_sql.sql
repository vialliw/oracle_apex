set serveroutput on size 1000000;
begin
    /*
    dbms_output.put_line(gen_price_series_sql('QQQ'));
    dbms_output.put_line(gen_price_series_sql('XLI'));
    dbms_output.put_line(gen_price_series_sql('ETF'));
    */
    dbms_output.put_line(gen_price_series_sql('XLY'));
end;
/
