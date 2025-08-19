
--DESCRIBE: show contents of dba_autotask_task

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

select client_name, 
       task_name,
	task_target_type,
	task_target_name,
	operation_name,
	attributes,
	task_priority,
	priority_override,
	status,
	deferred_window_name,
	current_job_name,
	job_scheduler_status,
	estimated_duration,
	retry_count,
	last_good_date,
	last_try_date,
	last_try_result,
	mean_good_duration 
from dba_autotask_task;
