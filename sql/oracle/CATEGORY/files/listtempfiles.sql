
--DESCRIBE: list file_name from dba_temp_files

set verify off

clear breaks
clear columns
clear computes

col file_name format a60

select file_name
from dba_temp_files
order by file_name
/
