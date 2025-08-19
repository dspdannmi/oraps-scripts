
--DESCRIBE: show detailed info about sqltext in shared pool

set verify off

clear breaks
clear computes

col sid format 9999
col username format a15
col command_type heading CMD_TYPE format 999
col text format a100
col stats heading "SORTS/EXECS/LOADS" format a18
col invalidations heading INVALS format 9999999
col disk_reads heading DSK_RDS format 99999999
col buffer_gets heading BUFF_GTS format 99999999
col rows_processed heading ROWS format 9999999999
col optimizer_mode heading OPT_MODE format a10
col parsing_user_id heading PARS_U_ID format 999999
col parsing_schema_id heading PARS_SCHEM_ID format 999999

break on "Sid" skip 1 on "Username" on "Command Type"

select s.sid,
       s.username,
       a.command_type,
       a.sorts || '/' || a.executions || '/' || a.loads stats,
       a.invalidations,
       a.parse_calls,
       a.disk_reads,
       a.buffer_gets,
       a.rows_processed,
       a.optimizer_mode,
       a.parsing_user_id,
       a.parsing_schema_id
from v$session s, v$sqlarea a
where s.sql_address = a.address
  and s.sql_hash_value = a.hash_value
  and s.sid like '%&&1%'
order by s.sid
/

undefine 1

