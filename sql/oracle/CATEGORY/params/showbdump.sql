
--DESCRIBE: show background_dump_dest setting

set verify off

clear breaks
clear columns
clear computes

select value
from v$parameter
where name = 'background_dump_dest'
/

