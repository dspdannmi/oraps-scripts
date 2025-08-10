
--DESCRIBE: show user_dump_dest setting

set verify off

clear breaks
clear columns
clear computes

select value
from v$parameter
where name = 'user_dump_dest'
/

