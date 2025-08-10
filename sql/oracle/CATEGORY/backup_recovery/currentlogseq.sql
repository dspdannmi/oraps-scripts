
--DESCRIBE: show current log sequence# 

set verify off

clear breaks
clear columns
clear computes

select sequence#
from v$log
where status = 'CURRENT'
/

