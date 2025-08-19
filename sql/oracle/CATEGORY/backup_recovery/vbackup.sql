
--DESCRIBE: select all from v$backup

set verify off

clear breaks 
clear computes

select *
from v$backup
order by file#
/
 
undefine 1

