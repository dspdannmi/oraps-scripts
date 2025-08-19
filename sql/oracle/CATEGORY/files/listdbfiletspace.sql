
--DESCRIBE: show tablespace/datafile mapping

set verify off

clear breaks

col "TABLESPACE_NAME:FILE_NAME" format a90

select tablespace_name || ':' || file_name "TABLESPACE_NAME:FILE_NAME"
from dba_data_files
order by tablespace_name
/

