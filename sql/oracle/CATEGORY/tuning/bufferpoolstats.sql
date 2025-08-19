
--DESCRIBE: show buffer pool statistics

set verify off

clear breaks
clear computes

select id, 
       name,
       db_block_change,
       db_block_gets,
       consistent_gets,
       physical_reads,
       physical_writes
from v$buffer_pool_statistics
order by 1,2;

