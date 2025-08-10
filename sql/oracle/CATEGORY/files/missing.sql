
--DESCRIBE: show any datafiles that have a (lower) name like '%missing%' indicating a compromised recovery

set verify off

clear breaks
clear columns
clear computes

select tablespace_name, 
       file_name
from dba_data_files
where lower(file_name) like '%missing%'
order by 1,2
/

