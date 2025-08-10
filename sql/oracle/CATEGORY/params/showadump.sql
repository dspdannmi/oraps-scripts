
--DESCRIBE: show audit_file_dest setting

set verify off

clear breaks
clear columns
clear computes

select value
from v$parameter
where name = 'audit_file_dest'
/

