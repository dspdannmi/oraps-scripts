
--DESCRIBE: show programs currently running

set verify off

clear breaks
clear columns
clear computes

col sid format 9999
col ser# format 99999
col pid format 9999
col spid format a6
col username format a18
col program format a60
col serial# format 999999
col process heading "FGPID" format a12

col logon heading "LOGON" format a11
col osuser_v$s$p heading "OSUSER V$S:V$P" format a17

select s.sid,
       s.serial# ser#,
       s.username,
       s.osuser || ':' || p.username osuser_v$s$p,
       s.program,
       s.status,
       to_char(logon_time, 'HH24:MI DD/MM') logon
from v$session s, v$process p
where p.addr = s.paddr
  and (s.sid like ('%&&1%')
           or upper(s.username) like upper('%&&1%')
           or p.pid like '%&&1%'
           or p.spid like '%&&1%'
	   or upper(s.program) like upper('%&&1%'))
order by s.sid
/

undefine 1

