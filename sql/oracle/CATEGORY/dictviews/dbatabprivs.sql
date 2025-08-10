
--DESCRIBE: show basic info about granted object privileges from dba_tab_privs

set verify off

col owner format a25
col "TABLE" format a50
col privilege format a25
col grantee format a25
col grantor format a25

select grantee, 
       owner || '.' || table_name "TABLE",
       grantor,
       privilege, 
       grantable
from dba_tab_privs
where owner || '.' || table_name like upper('%&&1%')
order by owner, table_name, privilege, grantee
/

undefine 1

