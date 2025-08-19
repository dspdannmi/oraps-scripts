
--DESCRIBE: list datafile filenames

set verify off

clear breaks

col file_name format a60

select file_name 
from dba_data_files
order by file_name
/

