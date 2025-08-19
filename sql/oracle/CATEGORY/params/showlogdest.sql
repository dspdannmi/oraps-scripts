
--DESCRIBE: show archivelog destination info

set verify off

clear breaks

col location format a60

select replace(value, 'location=', '') location
from v$parameter
where name like 'log_archive_dest%'
  and name not like 'log_archive_dest_state%'
  and value is not null
/

