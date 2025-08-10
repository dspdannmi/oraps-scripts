
--DESCRIBE: show created and last_ddl_time for an object

set verify off

clear breaks
clear columns
clear computes

col object format a50
col created format a20
col last_ddl format a20

select owner || '.' || object_name object, 
       object_type,
       to_char(created, 'DD-MON-YYYY HH24:MI:SS') created,
       to_char(LAST_DDL_TIME, 'DD-MON-YYYY HH24:MI:SS') last_ddl
from dba_objects
where owner || '.' || object_name like upper('%&&1%')
/


undefine 1

