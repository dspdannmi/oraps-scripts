
--DESCRIBE: show previous sql a session(s) was running

set verify off

clear breaks
clear computes

col sid format 999999
col username format a18
col command_type format 9999
col sql_text format a80

break on sid on username on command_type

select s.sid,
       s.username,
       t.command_type,
       t.sql_text
from v$session s, 
     v$sqltext t
where s.prev_sql_addr = t.address
  and s.prev_hash_value = t.hash_value
  and s.sid like '%&&1%'
order by s.sid, t.piece
/

undefine 1

