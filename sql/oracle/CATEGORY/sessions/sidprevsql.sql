
--DESCRIBE: show previous sql for a given SID

col sid format 999999
col username format a15
col command_type format 999
col sql_text format a100

break on sid on username on command_type

select s.sid,
       s.username,
       t.command_type,
       t.sql_text "Text"
from v$session s, v$sqltext t
where s.prev_sql_addr = t.address
  and s.prev_hash_value = t.hash_value
  and s.sid = '&&1'
order by s.sid, t.piece
/

undefine 1
