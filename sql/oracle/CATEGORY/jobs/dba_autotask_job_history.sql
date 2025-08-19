
--DESCRIBE: show contents of dba_autotask_job_history

set verify off

clear breaks
clear computes

col window_name format a20

col client_name format a36
col task_name format a20
col task_target_type format a20
col task_target_name format a26
col operation_name format a20
col attributes format a26

col deferred_window_name format a24
col current_job_name format a14

col last_good_date format a33
col last_try_date format a33
col task_priority format 999 heading "PRI"
col status format a12

col window_start_time format a34
col window_duration format a27
col job_name format a36
col job_start_time format a34
col job_status format a10
col job_duration format a18
col job_error format 99999999
col job_info format a80


select client_name,
	window_name,
	window_start_time
	job_name,
	job_status,
	job_start_time,
	job_duration,
	job_error 
from dba_autotask_job_history
order by job_start_time;

