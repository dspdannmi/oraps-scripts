
--DESCRIBE: show detailed info on blocking sessions or sessions in lockwait


col sid format 9999
col pid format 9999
col username format a18
col "OSUSER (V$S)" format a10
col "OSUSER (V$P)" format a10
col "Logon" format a11


prompt
prompt =================================
prompt ~ SESSIONS WITH LOCKWAIT STATUS ~
prompt =================================

prompt

select s.sid, 
       s.serial#, 
       s.username, 
       s.osuser "OSUSER (V$S)",
       p.username "OSUSER (V$P)", 
       p.pid, 
       p.spid, 
       p.background, 
       s.lockwait, 
       s.status,
       to_char(logon_time, 'HH24:MI DD/MM') "Logon"
from v$session s, v$process p
where p.addr = s.paddr 
  and lockwait is not null
order by s.sid
/

prompt
prompt
prompt ===============================================================
prompt ~ LOCKS FROM v$lock WITH kaddr IN LOCKWAIT OR BLOCKING STATUS ~
prompt ===============================================================
prompt


select *
from v$lock
where kaddr in (select lockwait from v$session where lockwait is not null)
   or block != 0
/

prompt
prompt
prompt ===================================================
prompt ~ WAIT EVENTS FROM v$session_wait FOR LOCKS SHOWN ~
prompt ===================================================
prompt

select sid, event, wait_time, seconds_in_wait, state
from v$session_wait
where sid in (select sid
	      from v$lock
	      where kaddr in (select lockwait 
			      from v$session
			      where lockwait is not null)
                 or block != 0)
/
	     
undefine 1
