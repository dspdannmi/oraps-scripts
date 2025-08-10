
--DESCRIBE: show detailed info about currently running sql

clear breaks
clear columns
clear computes

col "Sid" format 9999
col "Username" format a15
col "Command Type" format 999
col "Text" format a75

break on "Sid" skip 1 on "Username" on "Command Type"

select s.sid "Sid",
       s.username "Username",
       t.command_type "Command Type",
       t.sql_text "Text",
       a.rows_processed, a.sorts, a.version_count, a.loaded_versions, a.open_versions, a.executions, a.users_executing, a.loads, a.first_load_time,
       a.invalidations, a.parse_calls, a.disk_reads, a.buffer_gets, a.kept_versions
from v$session s, v$sqltext t, v$sqlarea a
where s.sql_address = t.address
  and s.sql_hash_value = t.hash_value
  and a.address = t.address
  and a.hash_value = t.hash_value
order by s.sid, t.piece
/
