
-- db_info.sql
--

-- get Oracle Release, Version & Edition
set heading off newpage none feedback off
prompt Oracle Release, Version and Edition:
select * from v$version where banner like 'Oracle%'
/
prompt

-- get allocated space
prompt Allocated Space (MB):
select ltrim(sum(bytes/(1024*1024))) from dba_data_files "Reserved_Space(MB)"
/
prompt

-- get used space
prompt Used Space (MB):
select ltrim("Reserved_Space(MB)" - "Free_Space(MB)") "Used_Space(MB)"
from(
select
(select sum(bytes/(1024*1024)) from dba_data_files) "Reserved_Space(MB)",
(select sum(bytes/(1024*1024)) from dba_free_space) "Free_Space(MB)"
from dual)
/
prompt

-- get log mode
prompt Archive Logging:
select log_mode from v$database;
prompt

-- check if Data Guard is enabled
set serveroutput on
prompt Data Guard Enabled:
declare
  feature_boolean number;
  aux_count number;
  feature_info clob;
begin
  dbms_feature_data_guard(feature_boolean, aux_count, feature_info);
  dbms_output.put_line(feature_info);
end;
/
set serveroutput off
prompt

-- get current Data Guard Transport Lag
prompt Data Guard Transport Lag:
select name||'|'||value from v$dataguard_stats where NAME IN ('transport lag');
prompt

-- get current Data Guard Apply Lag
prompt Data Guard Apply Lag:
select name||'|'||value from v$dataguard_stats where NAME IN ('apply lag');
prompt

-- check if Flashback is enabled
prompt Flashback Enabled:
select flashback_on from v$database;
prompt

-- view backup history
prompt RMAN Backup History
col status format a9
col hours format 999.99
set heading on lines 800 pages 10000
select session_key, input_type, status,
to_char(start_time,'dd/mm/yyyy hh24:mi') start_backup,
to_char(end_time,'dd/mm/yyyy hh24:mi') end_backup,
elapsed_seconds/3600 hours,
output_device_type,
compression_ratio,
(output_bytes_per_sec/1024/1024) speed_mbps
from v$rman_backup_job_details
where start_time<(SYSDATE-7)
order by session_key
/
prompt

-- Check for changes to default RMAN parameters
prompt Non-default RMAN settings:
select * from v$rman_configuration;
prompt

-- Report unrecoverable error count in all datafiles
prompt Unrecoverable Datafile Errors:
select count(*) from v$datafile where unrecoverable_change# <> 0;
prompt

-- Report corrupt block count in all datafiles
prompt Corrupt Blocks Detected:
select count(*) from v$database_block_corruption;
prompt

-- Show current archive log destination
prompt Archive Log List
archive log list;
prompt

