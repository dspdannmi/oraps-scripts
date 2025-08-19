
--DESCRIBE: show session_wait p3 info


set verify off

clear breaks
clear computes

break on sid skip 0

col sid format 999999
col event format a40
col p3 format 99999999999
col p3text format a20
col p3raw format a20
col wait_time format 99999999
col state format a14
col seconds_in_wait heading "SECONDS" format 99999999
col mins heading "MINUTES" format 9999999

select sid,
       event,
       p3,
       p3text,
       p3raw,
       wait_time,
       seconds_in_wait,
       state
from v$session_wait
where sid = '&&1'
order by sid
/


undefine 1

