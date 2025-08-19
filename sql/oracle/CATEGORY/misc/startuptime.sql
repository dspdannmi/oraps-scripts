
--DESCRIBE: show database startup date and time

set verify off

clear breaks
clear computes

col host_name format a32

select d.name "DB_NAME", 
       i.instance_name, 
       i.host_name, 
       to_char(i.startup_time, 'YYYY-MM-DD HH24:MI:SS') "STARTUP_TIME",  
       i.status
from v$database d, v$instance i;

undefine 1


