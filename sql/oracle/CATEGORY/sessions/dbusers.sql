
--DESCRIBE: show user, sid, pid, lockwait, logon status of currently connected sessions

set verify off

clear breaks

col sid format 9999
col ser# format 99999
col pid format 9999
col spid format a6
col username format a18
col program format a28
col serial# format 999999
col process heading "FGPID" format a14

col logon heading "LOGON" format a11
col osuser_v$s$p heading "OSUSER V$S:V$P" format a17

select s.sid,
       s.serial# ser#,
       s.username,
       s.osuser || ':' || p.username osuser_v$s$p,
       p.pid,
       p.spid,
       s.process,
       substr(s.program,1,28) program,
       p.background,
       s.lockwait,
       s.status,
       to_char(logon_time, 'HH24:MI DD/MM') logon
from v$session s, v$process p
where p.addr (+) = s.paddr
  and (s.sid like ('%&&1%')
           or upper(s.username) like upper('%&&1%')
           or p.pid like '%&&1%'
           or p.spid like '%&&1%'
	   or s.process like '%&&1%')
order by s.sid
/

undefine 1

