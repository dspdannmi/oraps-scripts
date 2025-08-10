
--DESCRIBE: generates script to create public synonyms

set verify off

clear breaks
clear columns
clear computes

select 'create public synonym ' || object_name || ' for ' || owner || '.' || object_name || ';'
from dba_objects
where object_type in ('PACKAGE', 'PROCEDURE', 'SEQUENCE', 'TABLE', 'VIEW', 'FUNCTION')
and owner like upper('%&&1%')
/

undefine 1

