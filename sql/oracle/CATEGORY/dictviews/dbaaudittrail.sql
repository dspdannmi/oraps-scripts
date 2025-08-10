
--DESCRIBE: show basic information from dba_audit_trail

set verify off

clear breaks
clear columns
clear computes

select username, action, action_name
from dba_audit_trail
/

