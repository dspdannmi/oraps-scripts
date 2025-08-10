
--DESCRIBE: show contents of dba_data_files

set verify off

clear breaks
clear columns
clear computes

break on tablespace_name 

col name format a60
col "Size (Mb)" format 999999999.99
col "Create Size (Mb)" format 999999999.99
col tablespace_name format a18
col file# format 9999999

select *
from dba_data_files
where tablespace_name like upper('%&&1%')
   or file_name like ('%&&1%')
order by tablespace_name, file_name
/

undefine  1

