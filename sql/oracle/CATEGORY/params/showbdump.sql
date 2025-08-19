
--DESCRIBE: show background_dump_dest setting

set verify off

clear breaks

select value
from v$parameter
where name = 'background_dump_dest'
/

