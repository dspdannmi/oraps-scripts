
--DESCRIBE: generates script to recreate object privs for a specified grantee

set verify off

clear breaks

col sql_text heading format a100

select 'grant ' || privilege || ' on ' || owner || '.' || table_name || ' to ' || grantee || ';' sql_text
from dba_tab_privs
where grantee like upper('%&&1%')
order by owner, table_name, privilege, grantee
/

undefine 1


