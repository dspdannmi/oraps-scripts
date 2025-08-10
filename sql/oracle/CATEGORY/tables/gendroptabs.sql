
--DESCRIBE: generates script to drop tables cascade constraints

set verify off

clear breaks
clear columns
clear computes

select 'drop table ' || owner || '.' || table_name || ' cascade constraints;'
from dba_tables
where owner || '.' || table_name like upper('%&&1%')
/

undefine 1

