
--DESCRIBE: show all info about tempfiles from dba_temp_files

set verify off

clear breaks
clear computes

col file_name format a40
col "BYTES(Mb)" format 999999
col "MAX(Mb)"   format 999999
col "USER(Mb)"   format 999999

select *
from dba_temp_files
order by file_name
/

