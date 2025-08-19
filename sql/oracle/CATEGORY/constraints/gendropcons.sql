
--DESCRIBE: generates drop constraints script for tables

set verify off

clear computes

select 'alter table ' || owner || '.' || table_name || ' drop constraint ' || constraint_name || ';'
from dba_constraints
where owner || '.' || table_name like upper('%&&1%')
order by owner, table_name
/

undefine 1

