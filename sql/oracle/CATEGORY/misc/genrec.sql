
--DESCRIBE: generates script to recompile invalid objects

set verify off

clear breaks
clear columns
clear computes

col sqltext heading "SQL_TEXT" format a120

select 'alter ' ||   decode(object_type, 'PACKAGE BODY', 'PACKAGE', object_type) ||
       ' ' || owner || '.' || object_name || ' compile ' ||
       decode(object_type, 'PACKAGE BODY', 'BODY;', ';') sqltext
from dba_objects
where status != 'VALID'
  and owner || '.' || object_name like upper('%&&1%')
order by owner, object_name
/

