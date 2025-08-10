
--DESCRIBE: show freespace in shared pool

set verify off

clear breaks
clear columns
clear computes

col pool    heading POOL
col name    heading NAME
col sgasize heading "ALLOCATED" format 999,999,999
col bytes   heading FREE FORMAT 999,999,999

select f.pool, 
       f.name, 
       s.sgasize, 
       f.bytes, 
       round(f.bytes/s.sgasize*100, 2) "% Free"
from (select sum(bytes) sgasize, 
	     pool FROM v$sgastat group by pool) s, 
     v$sgastat f
where f.name = 'free memory'
  and f.pool = s.pool
order by f.pool
/

undefine 1


