
--DESCRIBE: show files that are autoextensible X=does not really do what it says

set verify off

clear breaks
clear columns
clear computes

col tablespace_name format a35
col file_name format a80
col filesize format 999999999
col autoextensible format a8

select tablespace_name, file_name, bytes/(1024*1024) filesize, autoextensible
from dba_data_files
order by file_name;

undefine 1

