
--DESCRIBE: show table column privilege info 

set verify off

clear breaks
clear columns
clear computes

col "TABLE" format a45
col "COLUMN" format a30
col privilege format a15
col grantee format a15
col grantor format a15

select owner || '.' || table_name "TABLE",
       column_name "Column",
       privilege, 
       grantee,
       grantor,
       grantable
from dba_col_privs
where owner || '.' || table_name || '.' || column_name like upper('&&1')
order by owner, table_name, column_name, privilege, grantee
/

undefine 1

