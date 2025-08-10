
--DESCRIBE: generates drop objects script for schema and object

set verify off

clear breaks
clear computes
clear columns

select 'drop ' || object_type || ' ' || owner || '.' || object_name || ';'
from dba_objects
where owner || '.' || object_name like upper('%&&1%')
/

undefine 1

