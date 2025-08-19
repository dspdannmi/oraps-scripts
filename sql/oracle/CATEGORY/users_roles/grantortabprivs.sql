
--DESCRIBE: show object grants given by a specified grantor

set verify off

clear breaks

break on grantee

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
where grantor like upper('%&&1%')
order by grantee, owner, table_name, privilege
/

undefine 1

