
--DESCRIBE: show table column privilege info 

set verify off

clear breaks
clear computes

col "TABLE" format a45
col "COLUMN" format a30
col privilege format a15
col grantee format a15
col grantor format a15

select owner || ',' ||
       table_name || ',' ||
max(decode(privilege, 'INSERT', 'Y', null)) || ',' ||
max(decode(privilege, 'EXECUTE', 'Y', null)) || ',' ||
max(decode(privilege, 'ALTER', 'Y', null)) || ',' ||
max(decode(privilege, 'UPDATE', 'Y', null)) || ',' ||
max(decode(privilege, 'DELETE', 'Y', null))
from dba_tab_privs
where grantee = 'PUBLIC'
  and privilege != 'SELECT'
  and owner not like 'SYS%'
group by owner, table_name
order by owner,table_name
/
