
--DESCRIBE: show only active sessions in order of sid

set verify off

clear breaks
clear columns
clear computes

col sid format 9999
col ser# format 99999
col pid format 9999
col username format a18
col program format a28
col serial# format 999999

col "LOGON" format a11
col "OSUSER V$S:V$P" format a17
col "SESSION" format a9

select s.sql_id, 
       s.prev_sql_id,
       s.sid,
       s.serial# ser#,
       s.username,
       s.osuser || ':' || p.username "OSUSER V$S:V$P",
       p.pid,
       p.spid,
       substr(s.program,1,18) program,
       s.lockwait,
       s.status
from v$session s, v$process p
where p.addr = s.paddr
  and (s.sql_id = '&1' or s.prev_sql_id = '&1')
order by s.sid
/

undefine 1

