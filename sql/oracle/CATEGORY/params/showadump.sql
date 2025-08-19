
--DESCRIBE: show audit_file_dest setting

set verify off

clear breaks

select value
from v$parameter
where name = 'audit_file_dest'
/

