
--DESCRIBE: show archived redo by day from v$archived_log

set verify off

clear breaks
clear computes

col total_size heading "TOTAL (Gb)" format 999999999.99

select trunc(first_time), sum(blocks*block_size)/1024/1024/1024 total_size
from v$archived_log
group by trunc(first_time)
order by 1;
