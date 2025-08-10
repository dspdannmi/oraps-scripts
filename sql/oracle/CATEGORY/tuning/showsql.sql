
--DESCRIBE: show currently running sql

set verify off

clear breaks
clear columns
clear computes

col sid format 999999
col username format a18
col command_type format 999
col sql_text format a75

break on sid skip 1 on username on command_type

select s.sid sid,
       s.username,
       t.command_type,
       t.sql_text
from v$session s, v$sqltext t, v$sqlarea a
where s.sid like '%&&1%'
  and s.sql_address = t.address
  and s.sql_hash_value = t.hash_value
  and a.address = t.address
  and a.hash_value = t.hash_value
order by s.sid, t.piece
/

undefine 1


