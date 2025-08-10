
--DESCRIBE: show info about granted system privileges


set verify on 

col privilege format a40

select *
from dba_sys_privs
where grantee || '.' || privilege like upper('%&1%')
order by grantee, privilege
/

undefine 1

