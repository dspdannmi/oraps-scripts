
--DESCRIBE: show all contents from dba_directories

set verify off

clear breaks
clear columns
clear computes

col owner format a35
col directory_name format a35
col directory_path format a60

select *
from dba_directories
order by owner, directory_name
/


undefine 1

