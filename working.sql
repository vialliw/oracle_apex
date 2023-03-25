-- @C:\Users\edvw\Documents\trade\pt_analy.sql
SET SERVEROUTPUT OFF;
SET SERVEROUTPUT ON SIZE 1000000;
SET LINESIZE 1000;
SET TRIMSPOOL OFF;
SET FEEDBACK ON;
SET TIME ON;
SPOOL C:\Intel\tmp\test.txt
DECLARE
      l_file   UTL_FILE.FILE_TYPE;
      c_path   CONSTANT VARCHAR2(100) := 'ORA_DIR';
      c_delimiter CONSTANT VARCHAR2(5) := ',';
      l_buf    VARCHAR2(32767);
      l_ticker VARCHAR2(30);
      l_rec    rawdata%ROWTYPE;
      l_cnt    PLS_INTEGER := 0;
      PROCEDURE mp_close IS
      BEGIN
         IF UTL_FILE.is_open(l_file) THEN
            UTL_FILE.FCLOSE(l_file);
         END IF;
      END;
BEGIN
      l_file := UTL_FILE.FOPEN(c_path, 'yfprice1d20221006.csv', 'R', 32767); 
      DBMS_OUTPUT.PUT_LINE('OPENED FILE');
      UTL_FILE.GET_LINE(l_file, l_buf);
      DBMS_OUTPUT.PUT_LINE('LENGTH(l_buf)=' || TO_CHAR(LENGTH(l_buf)));
      mp_close;
      /***
      IF pi_dt_format LIKE '%24%' THEN
         l_dt_length := LENGTH(pi_dt_format) - 2;
      ELSE
         l_dt_length := LENGTH(pi_dt_format);
      END IF;
      -- Line 1 header
      UTL_FILE.GET_LINE(l_file, l_buf);
      -- Ticker
      l_rec.ticker := UPPER(SUBSTR( pi_filename, 1, (INSTR(pi_filename, '.')-1) ));
      l_rec.bar_size := pi_bar_size;
      -- Data
      BEGIN
         LOOP
            UTL_FILE.GET_LINE(l_file, l_buf);
            l_buf := l_buf || c_delimiter;
            l_data_cnt := l_data_cnt + 1;
            l_rec.data_date := TO_DATE(SUBSTR(l_buf, 1, l_dt_length), pi_dt_format);
            l_rec.open :=      TO_NUMBER(SUBSTR(l_buf, INSTR(l_buf, c_delimiter, 1, 1 ) + 1, (INSTR(l_buf, c_delimiter, 1, 2 ) - INSTR(l_buf, c_delimiter, 1, 1 )) - 1));
            l_rec.high :=      TO_NUMBER(SUBSTR(l_buf, INSTR(l_buf, c_delimiter, 1, 2 ) + 1, (INSTR(l_buf, c_delimiter, 1, 3 ) - INSTR(l_buf, c_delimiter, 1, 2 )) - 1));
            l_rec.low :=       TO_NUMBER(SUBSTR(l_buf, INSTR(l_buf, c_delimiter, 1, 3 ) + 1, (INSTR(l_buf, c_delimiter, 1, 4 ) - INSTR(l_buf, c_delimiter, 1, 3 )) - 1));
            l_rec.close :=     TO_NUMBER(SUBSTR(l_buf, INSTR(l_buf, c_delimiter, 1, 4 ) + 1, (INSTR(l_buf, c_delimiter, 1, 5 ) - INSTR(l_buf, c_delimiter, 1, 4 )) - 1));
            l_rec.adj_close := TO_NUMBER(SUBSTR(l_buf, INSTR(l_buf, c_delimiter, 1, 5 ) + 1, (INSTR(l_buf, c_delimiter, 1, 6 ) - INSTR(l_buf, c_delimiter, 1, 5 )) - 1));
            l_rec.volume :=    TO_NUMBER(SUBSTR(l_buf, INSTR(l_buf, c_delimiter, 1, 6 ) + 1, (INSTR(l_buf, c_delimiter, 1, 7 ) - INSTR(l_buf, c_delimiter, 1, 6 )) - 1));
            DBMS_OUTPUT.PUT_LINE('date string: '|| l_rec.data_date);
            DBMS_OUTPUT.PUT_LINE('open: '|| l_rec.open);
            DBMS_OUTPUT.PUT_LINE('high: '|| l_rec.high);
            DBMS_OUTPUT.PUT_LINE('low: '|| l_rec.low);
            DBMS_OUTPUT.PUT_LINE('close: '|| l_rec.close);
            DBMS_OUTPUT.PUT_LINE('adj_close: '|| l_rec.adj_close);
            DBMS_OUTPUT.PUT_LINE('volume: '|| l_rec.volume);
            --l_rec.price := TO_NUMBER(SUBSTR(l_buf, INSTR(l_buf,',',1,2)+1));
            BEGIN
               INSERT INTO price_data (data_date, OPEN, high, low, CLOSE, adj_close, volume, ticker, bar_size) VALUES 
                  (l_rec.data_date, l_rec.OPEN, l_rec.high, l_rec.low, l_rec.CLOSE, l_rec.adj_close, l_rec.volume, l_rec.ticker, l_rec.bar_size);
                l_insrt_cnt := l_insrt_cnt + 1;
            EXCEPTION
            WHEN DUP_VAL_ON_INDEX THEN
                l_dup_cnt := l_dup_cnt + 1;
            END;
         END LOOP;
      EXCEPTION
      WHEN NO_DATA_FOUND THEN
         mp_close;
      END;
      mp_close;
      COMMIT;
      DBMS_OUTPUT.PUT_LINE('ticker: '|| l_rec.ticker);
      DBMS_OUTPUT.PUT_LINE('Inserted records: '|| l_insrt_cnt);
      DBMS_OUTPUT.PUT_LINE('Duplicate records: '|| l_dup_cnt);
      DBMS_OUTPUT.PUT_LINE('Data lines: '|| l_data_cnt);
      UTL_FILE.FREMOVE(pi_dir, pi_filename);
      DBMS_OUTPUT.PUT_LINE('Deleted file: ' || pi_dir ||'\'|| pi_filename);
      RETURN 0;***/
      DBMS_OUTPUT.PUT_LINE('~~~~~~~~~~END~~~~~~~~~~~');
EXCEPTION
WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE(SQLERRM);
    mp_close;
END;
/
SPOOL OFF;




