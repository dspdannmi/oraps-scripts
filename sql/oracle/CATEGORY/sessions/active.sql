
--DESCRIBE: show only active sessions in order of sid

set verify off

col sid format 9999
col ser# format 99999
col pid format 9999
col username format a18
col program format a28
col serial# format 999999

col "LOGON" format a11
col "OSUSER V$S:V$P" format a17
col "SESSION" format a9

select s.sid,
       s.serial# ser#,
       s.username,
       s.osuser || ':' || p.username "OSUSER V$S:V$P",
       p.pid,
       p.spid,
       substr(s.program,1,28) program,
       p.background,
       s.lockwait,
       s.status,
       s.sql_id,
       to_char(logon_time, 'HH24:MI DD/MM') "LOGON"
from v$session s, v$process p
where p.addr = s.paddr
  and (s.sid like ('%&&1%')
           or upper(s.username) like upper('%&&1%')
           or p.pid like '%&&1%'
           or p.spid like '%&&1%')
  and s.status = 'ACTIVE'
order by s.sid
/

undefine 1

