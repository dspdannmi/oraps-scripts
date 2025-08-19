
--DESCRIBE: generate resize script for datafile

set verify off

clear breaks

prompt whenever sqlerror continue

select 'alter database datafile ' || file# || ' resize ' || ceil(bytes/(1024*1024)) || 'm;'
from v$datafile
order by to_number(file#)
/

