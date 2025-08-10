
--DESCRIBE: show contents of dba_autotask_schedule

set verify off

clear columns
clear breaks
clear computes

col window_name format a22
col start_time format a34
col duration format a24


select * 
from dba_autotask_schedule
order by start_Time;
