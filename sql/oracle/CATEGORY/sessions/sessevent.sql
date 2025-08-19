
--DESCRIBE: show all from v$session_event

set verify off

clear breaks
clear computes

break on sid skip 1

col event format a34
col sid format 99999
col max_wait format 999999999
col time_waited format 999999999
col total_waits format 999999999

select * 
from v$session_event
where sid like '%&&1%'
order by sid, average_wait
/

undefine 1
