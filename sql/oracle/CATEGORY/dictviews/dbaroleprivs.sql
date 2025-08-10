
--DESCRIBE: show basic info on granted roles

set verify off

break on granted_role

col granted_role format a40

select granted_role, grantee, admin_option, default_role
from dba_role_privs
where granted_role like upper('%&&1%')
   or grantee like upper('%&&1%')
order by granted_role, grantee
/

undefine 1

