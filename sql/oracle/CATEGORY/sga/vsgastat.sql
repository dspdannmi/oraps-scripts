
--DESCRIBE: select all from v$sgastat

set verify off

clear breaks
clear columns
clear computes

col name format a35

select *
from v$sgastat
/

undefine 1

