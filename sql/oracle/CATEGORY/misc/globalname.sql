
--DESCRIBE: show global_name of database

set verify off

clear breaks
clear columns
clear computes

col global_name format a80

select * 
from global_name
/


