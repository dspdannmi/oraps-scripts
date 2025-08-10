
--DESCRIBE: show role, system and object privileges of a user

set verify off

clear breaks
clear columns
clear computes

col granted_role format a40
col owner format a20
col grantor format a20
col grantee format a20

select *
from dba_role_privs
where grantee like upper('%&&1%')
/


col privilege heading "SYSTEM_PRIVILEGE" 

select *
from dba_sys_privs
where grantee like upper ('%&&1%')
/


col privilege heading "OBJECT_PRIVILEGE"

select *
from dba_tab_privs
where grantee like upper ('%&&1%')
/


undefine 1

