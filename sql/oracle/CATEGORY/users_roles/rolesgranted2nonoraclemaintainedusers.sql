
--DESCRIBE: list all roles granted to users that are not Oracle maintained

set verify off

clear breaks

select distinct granted_role 
from dba_role_privs 
where grantee in (select username from dba_users where oracle_maintained != 'Y')
order by 1;

