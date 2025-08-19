
--DESCRIBE: display duplicate grants where this is already a grant to public

set verify off

clear breaks

select *
from dba_tab_privs x
where grantee != 'PUBLIC'
  and exists
(select 'x' from dba_tab_privs y
 where grantee = 'PUBLIC'
   and y.owner = x.owner
   and y.table_name = x.table_name
   and y.privilege = x.privilege
   and y.grantable = x.grantable)
order by owner, table_name
/

