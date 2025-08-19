
--DESCRIBE: show open cursor info for sessions and database

set verify off

clear breaks
clear computes

break on sid skip 0

select sum(a.value), b.name
from v$sesstat a, v$statname b
where a.statistic# = b.statistic#
and b.name = 'opened cursors current'
group by b.name;


undefine 1
