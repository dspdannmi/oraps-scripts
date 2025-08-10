
--DESCRIBE: show Oracle Apps form users

set verify off

clear columns
clear breaks
clear computes

column "User Name" format a10
column "ClPID" format a8

select d.user_name "User Name",
       b.sid SID,b.serial# "Serial#", to_number(c.spid) "OS PID", a.SPID "ClPID",
              to_char(START_TIME,'DD-MON-YY HH24:MI:SS') "STime"
from APPS.FND_LOGINS a, v$session b, v$process c, APPS.FND_USER d
where b.paddr = c.addr
  and a.pid=c.pid
  and a.spid = b.process
  and d.user_id = a.user_id
  and (d.user_name = 'USER_NAME' OR 1=1)
  and (c.spid like '%&&1%'
     or upper(d.user_name) like upper('%&&1%')
     or b.sid like '%&&1%'
     or a.spid like '%&&1%')
order by to_number(c.spid)
/

undefine 1

