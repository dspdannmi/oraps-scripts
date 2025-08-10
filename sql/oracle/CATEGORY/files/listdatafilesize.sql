
--DESCRIBE: list datafiles and size (in bytes)

set verify off

clear breaks
clear columns
clear computes

col "FILE_NAME:SIZE" format a100

select file_name || ':' ||  bytes "FILE_NAME:SIZE"
from dba_data_files
order by file_name
/

