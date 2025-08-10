
--DESCRIBE: show maximum log sequence# from v$log_history

select 'MAX:' || max(sequence#)
from v$log_history
/
