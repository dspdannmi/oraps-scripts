
--DESCRIBE: show core_dump_dest setting

set verify off

clear breaks

select value
from v$parameter
where name = 'core_dump_dest'
/

