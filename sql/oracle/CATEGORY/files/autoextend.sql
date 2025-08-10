
--DESCRIBE: list datafiles that have autoextend enabled

set verify off

clear breaks
clear columns
clear computes

compute sum of "Size (Mb)" on tablespace_name

col name format a60
col "Size (Mb)" format 999999999.99
col "MaxBytes Size (Mb)" format 999999999.99
col tablespace_name format a18
col file_name format a50

select tablespace_name, file_name, bytes/(1024*1024) "Size (Mb)", maxbytes/(1024*1024) "MaxBytes (Mb)"
from dba_data_files
where autoextensible != 'NO'
order by tablespace_name, file_name
/

undefine  1

