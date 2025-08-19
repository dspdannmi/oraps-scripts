
--DESCRIBE: list objects created recently

set verify off

clear breaks
clear computes

col owner_object format a50
col object_type format a25
col created format a18
col last_ddl_time_string format a18
col timestamp format a19


select owner || '.' || object_name owner_object, 
       object_type, 
       to_char(created, 'DD-MON-YYYY HH24:MI') created,
       to_char(last_ddl_time, 'DD-MON-YYYY HH24:MI') last_ddl_time_string,
       timestamp
from dba_objects
where trunc(sysdate) - trunc(created) < &&1
order by last_ddl_time, owner, object_name
/

undefine 1
