
--DESCRIBE: show session_wait p2 info


set verify off

clear breaks
clear computes

break on sid skip 0

col sid format 999999
col event format a40
col p2 format 99999999999
col p2text format a20
col p2raw format a20
col wait_time format 99999999
col state format a14
col seconds_in_wait heading "SECONDS" format 99999999
col mins heading "MINUTES" format 9999999

select sid,
       event,
       p2,
       p2text,
       p2raw,
       wait_time,
       seconds_in_wait,
       state
from v$session_wait
where sid = '&&1'
order by sid
/


undefine 1

