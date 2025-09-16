
--DESCRIBE: show object grants for a specified object

set verify off

clear breaks
clear computes

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
where owner || '.' || table_name like upper('%&&1%')
order by grantee, owner, table_name, privilege
/

undefine 1

