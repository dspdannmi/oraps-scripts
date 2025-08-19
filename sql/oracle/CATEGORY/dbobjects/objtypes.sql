
--DESCRIBE: list distinct object_types in use in current database

set verify off

clear breaks
clear computes

select distinct object_type
from dba_objects
order by object_type
/
