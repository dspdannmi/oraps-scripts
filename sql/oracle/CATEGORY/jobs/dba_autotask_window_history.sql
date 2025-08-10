
--DESCRIBE: show contents of dba_autotask_window_history

set verify off

clear columns
clear breaks
clear computes

col window_name format a40
col window_start_time format a44
col window_end_time format a44

select * 
from dba_autotask_window_history
order by window_start_time;
