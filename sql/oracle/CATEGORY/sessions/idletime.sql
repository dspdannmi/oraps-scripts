
--DESCRIBE: show connected sessions in ascending order of connect time

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
col "LAST ACTIVE" format a18

select s.sid,
       s.serial# ser#,
       s.username,
       s.osuser || ':' || p.username "OSUSER V$S:V$P",
       substr(s.program,1,28) program,
       s.status,
       to_char(sysdate - s.last_call_et/(24*60*60), 'HH24:MI DD/MM') "LAST ACTIVE"
from v$session s, v$process p
where p.addr = s.paddr
  and (s.sid like ('%&&1%')
           or upper(s.username) like upper('%&&1%')
           or p.pid like '%&&1%'
           or p.spid like '%&&1%')
order by s.last_call_et desc
/

undefine 1

