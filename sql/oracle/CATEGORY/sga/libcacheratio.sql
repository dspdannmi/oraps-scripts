
--DESCRIBE: show library cache hitratio

set verify off

clear breaks

rem 
rem Metalink DocID 62143.1
rem

rem  Finding the library cache hit ratio
rem

select sum(pins) "EXECUTIONS",
       sum(reloads) "CACHE MISSES WHILE EXECUTING"
from v$librarycache
/

