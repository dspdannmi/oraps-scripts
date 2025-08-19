
--DESCRIBE: show summary info from v$session_wait for a session

set verify off

clear breaks
clear computes

break on sid skip 0

col sid format 999999
col event format a40
col p1 heading "P1" format a40
col wait_time format 99999999
col state format a14
col seconds_in_wait heading "SECS(Mins) IN WAIT" format a20
col mins heading "MINUTES" format 9999999

select sid,
       event,
       p1text || ' (p1=' || p1 || ')' p1,
       wait_time,
       seconds_in_wait || ' (mins=' || trunc(seconds_in_wait/60) || ')' seconds_in_wait,
       state
from v$session_wait
where sid = '&&1'
order by sid
/


undefine 1
