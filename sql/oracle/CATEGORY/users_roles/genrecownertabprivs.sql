
--DESCRIBE: generates script to recreate object privs for a specified owner 

set verify off

clear breaks
clear columns
clear computes

col sql_text heading format a100

select 'grant ' || privilege || ' on ' || owner || '.' || table_name || ' to ' || grantee || ';' sql_text
from dba_tab_privs
where owner like upper('%&&1%')
order by owner, table_name, privilege, grantee
/

undefine 1


