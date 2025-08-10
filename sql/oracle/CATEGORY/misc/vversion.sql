
--DESCRIBE: select all from v$version

set verify off

clear breaks
clear columns
clear computes

select *
from v$version
order by 1
/

undefine 1
