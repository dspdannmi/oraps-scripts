
--DESCRIBE: show value of log_archive_format

set verify off

clear breaks

select value
from v$parameter
where name = 'log_archive_format'
/

