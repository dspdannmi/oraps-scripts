
--DESCRIBE: list online and standby redolog filenames

set verify off

clear breaks

col member format a60

select member
from v$logfile
order by member
/

