
--DESCRIBE: show pct complete from v$session_longops that are in progress

set verify off

clear breaks
clear columns
clear computes


select a.sid, a.serial#, opname, target, units, sofar, totalwork, (sofar/totalwork)*100 "PCT"
from v$session_longops a, v$session b
where a.sid = b.sid
  and a.serial# = b.serial#
  and sofar != totalwork
  and totalwork != 0
/


undefine 1
