
--DESCRIBE: show redo log switches per day from v$log_history
 
select trunc(first_time), count(*)
from v$log_history
group by trunc(first_time)
order by 1
/
