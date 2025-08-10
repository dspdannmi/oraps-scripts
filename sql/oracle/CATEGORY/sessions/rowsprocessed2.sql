
--DESCRIBE: show detailed info about all sqltext and rows_processed from v$session and v$sqlarea

set verify off

clear breaks
clear computes
clear columns

col sid format 999999

select a.sid, b.rows_processed
from v$session a, v$sqlarea b
where a.sql_address = b.address
  and a.sql_hash_value = b.hash_value
order by a.sid
/

