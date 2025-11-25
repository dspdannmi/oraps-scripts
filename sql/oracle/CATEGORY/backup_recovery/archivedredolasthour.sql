
--DESCRIBE: show archivelogs in last hour

set verify off

clear breaks
clear computes

col ft format a20 heading "FIRST_TIME"
col nt format a20 heading "NEXT_TIME"

select thread#, sequence#, name, to_char(first_time, 'YYYY-MM-DD:HH24:MI:SS') ft, to_char(next_time, 'YYYY-MM-DD:HH24:MI:SS') nt, standby_dest, archived, applied, deleted, status
from v$archived_log
where first_time > sysdate-1/24
order by first_time;


