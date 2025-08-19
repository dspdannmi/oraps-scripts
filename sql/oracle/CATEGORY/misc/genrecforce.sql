
--DESCRIBE: generates script to recompile objects regardless of current status 

set verify off

clear breaks

col sqltext heading "SQL_TEXT" format a120

select 'alter ' ||   decode(object_type, 'PACKAGE BODY', 'PACKAGE', object_type) ||
       ' ' || owner || '.' || object_name || ' compile ' ||
       decode(object_type, 'PACKAGE BODY', 'BODY;', ';') sqltext
from dba_objects
where owner || '.' || object_name like upper('%&&1%')
order by owner, object_name
/

