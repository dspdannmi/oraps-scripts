
select trunc(first_time), dest_id, sum(blocks*block_size)/1024/1024/1024 "DAILY(Gb)"
from v$archived_log
group by trunc(first_time), dest_id
order by 1;

