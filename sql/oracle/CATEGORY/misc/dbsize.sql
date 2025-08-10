
--DESCRIBE: show database size from dba_data_files and dba_temp_files

set verify off

clear breaks
clear columns
clear computes

col "SIZE(Mb)" format 999999999999
col "TEMP SIZE(Mb)" format 999999999999


select sum(bytes)/(1024*1024) "SIZE(Mb)"
from dba_data_files
/


select sum(bytes)/(1024*1024) "TEMP SIZE(Mb)"
from dba_temp_files
/

