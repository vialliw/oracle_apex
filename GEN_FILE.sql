SET SERVEROUTPUT ON SIZE 200000;

declare
    V1 VARCHAR2(32767); 
    F1 UTL_FILE.FILE_TYPE; 
    l_cnt PLS_INTEGER := 0;
    l_file_no pls_integer := 0;
    l_filenam varchar2(100);
    PROCEDURE mp_close_file IS
    BEGIN
        IF utl_file.is_open(F1) then
            utl_file.fclose(F1);
        end if;
    END;
begin
    dbms_output.put_line('begin');
    FOR rc IN ( SELECT ticker, COUNT(1)
                FROM ticker_list
                GROUP BY ticker
                having count(1) > 1
                ORDER BY 2 DESC,1) LOOP
        l_cnt := l_cnt + 1;
        -- Open file
        IF TO_CHAR(l_cnt) LIKE '%1' THEN
            l_file_no := l_file_no + 1;
            l_filenam := 'fil' || TO_CHAR(l_file_no,'FM00') ||'.tls';
            dbms_output.put_line('OPEN l_filenam = ' || l_filenam);
            F1 := UTL_FILE.FOPEN('ORA_DIR', l_filenam, 'W', 256); 
        END IF;
        dbms_output.put_line('ticker = ' || rc.ticker);
        UTL_FILE.PUT_LINE(F1, rc.ticker); 
        -- Close file
        IF TO_CHAR(l_cnt) LIKE '%0' THEN
            mp_close_file;
        END IF;
    END LOOP;
    mp_close_file;
    dbms_output.put_line('END');
end;
/
