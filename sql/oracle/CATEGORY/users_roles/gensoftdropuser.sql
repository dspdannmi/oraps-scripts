
--DESCRIBE: generates script to drop all objects for a specified owner 

set verify off

clear breaks
clear columns
clear computes

col sqltext heading "rem DROP USER OBJECTS"

select 'drop ' || object_type || ' ' || owner || '.' || object_name || ' ' || decode(object_type, 'TABLE', ' cascade constraints;', ';') sqltext
from dba_objects
where owner = upper('&&1')
  and object_type not in ('INDEX')
  and not (object_type = 'SEQUENCE' and object_name like 'AQ$\_%' escape '\')
/

undefine 1
