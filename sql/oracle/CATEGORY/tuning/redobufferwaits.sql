
--DESCRIBE: show statistics for 'redo log space wait time' events

set verify off

clear breaks
clear computes


select sum(value) "Redo Buffer Waits"
from v$sysstat
where  name = 'redo log space wait time'
/


