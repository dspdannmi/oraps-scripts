
--DESCRIBE: show contents of dba_autotask_window_clients

set verify off

clear columns
clear breaks
clear computes

col window_name format a20
col window_next_time format a34
col window_active format a8 heading "Active"
col autotask_status format a8 heading "Autotask|Status"
col optimizer_stats format a16 heading "Optimizer|Stats"
col segment_advisor format a10 heading "Segment|Advisor"
col sql_tune_advisor format a14 heading "SQL Tune|Advisor"
col health_monitor format a10 heading "Health|Monitor"



select * 
from dba_autotask_window_clients;

