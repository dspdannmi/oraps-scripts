
--DESCRIBE: select all from v$logfile

col member format a80

select *
from v$logfile
order by group#, member
/
