
--DESCRIBE: show redo size statistics for sessions

set verify off

clear breaks
clear columns
clear computes

col sid format 9999
col ser# format 99999
col pid format 9999
col spid format a6
col username format a18
col program format a28
col serial# format 999999
col process heading "FGPID" format a6

col logon heading "LOGON" format a11
col osuser_v$s$p heading "OSUSER V$S:V$P" format a17

select s.sid,
       s.serial# ser#,
       s.username,
       substr(s.program,1,28) program,
       s.lockwait,
       st.value redosize,
       s.status,
       to_char(logon_time, 'HH24:MI DD/MM') logon
from v$session s, v$process p, v$sesstat st, v$statname sn
where p.addr = s.paddr
  and (s.sid like ('%&&1%')
           or upper(s.username) like upper('%&&1%')
           or p.pid like '%&&1%'
           or p.spid like '%&&1%'
	   or s.process like '%&&1%')
  and (st.statistic# = sn.statistic# and sn.name = 'redo size' and st.sid = s.sid)
order by redosize
/

undefine 1
