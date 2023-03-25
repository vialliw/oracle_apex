COLUMN segment_name FORMAT A30;
select segment_name,sum(bytes)/1024/1024 MB from user_segments where segment_type='INDEX' and segment_name IN (SELECT index_name FROM user_indexes) group by segment_name;
select segment_name,sum(bytes)/1024/1024 MB from user_segments where segment_type='TABLE' and segment_name IN (SELECT table_name FROM user_tables) group by segment_name;

select nvl(b.tablespace_name
     , nvl(a.tablespace_name, 'UNKOWN')) name
     , kbytes_alloc / 1024 / 1024 gbytes_allocated
     , (kbytes_alloc-nvl(kbytes_free,0)) / 1024 / 1024 gbytes_used
     , nvl(kbytes_free,0) / 1024 / 1024 gbytes_free
     , to_char(((kbytes_alloc-nvl(kbytes_free,0))/kbytes_alloc)*100, 'FM990.0') || '%' pct_used
from (select sum(bytes)/1024 Kbytes_free
           , tablespace_name
      from sys.dba_free_space
      group by tablespace_name ) a
   , (select sum(bytes)/1024 Kbytes_alloc
           , sum(maxbytes)/1024 Kbytes_max
           , tablespace_name
      from sys.dba_data_files
      group by tablespace_name
      -----------
      union all
      -----------
      select sum(bytes)/1024 Kbytes_alloc
           , sum(maxbytes)/1024 Kbytes_max
           , tablespace_name
      from sys.dba_temp_files
      group by tablespace_name) b
where a.tablespace_name (+) = b.tablespace_name;

