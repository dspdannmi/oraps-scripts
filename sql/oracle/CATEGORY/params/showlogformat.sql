
--DESCRIBE: show value of log_archive_format

set verify off

clear breaks
clear columns
clear computes

select value
from v$parameter
where name = 'log_archive_format'
/

