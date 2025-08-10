
--DESCRIBE: list datafile info and sum size of tablespaces

set verify off

clear breaks
clear columns
clear computes

break on tablespace_name skip 1
compute sum of "Size (Mb)" on tablespace_name

col name format a60
col file_id format 999999
col "Size (Mb)" format 999999999.99
col "Create Size (Mb)" format 999999999.99
col tablespace_name format a18

select d.tablespace_name, 
       d.file_id,
       f.name, 
       d.bytes/(1024*1024) "Size (Mb)", 
       d.status, 
       f.status
from v$datafile f, dba_data_files d, v$backup b
where f.file# = d.file_id
  and f.file# = b.file#
  and d.tablespace_name like upper('%&&1%')
order by d.tablespace_name
/

undefine  1

