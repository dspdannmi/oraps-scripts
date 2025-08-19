
--DESCRIBE: show non-select grants given to public

set verify off

clear breaks
clear computes

select *
from dba_tab_privs
where grantee = 'PUBLIC'
  and privilege != 'SELECT'
  and owner || '.' || table_name like upper('%&&1%')
/

undefine 1


