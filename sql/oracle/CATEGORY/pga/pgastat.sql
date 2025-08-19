
--DESCRIBE: select all from v$pgastat

set verify off

clear breaks
clear computes

col name format a40

select *
from v$pgastat
/

