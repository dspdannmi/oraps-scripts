
REM
REM Generate consistent output of objects to easily be able to compare
REM between databases

set pages 0 lines 180
col object format a180
set trimspool on

select owner || ',' || object_name || ',' || object_type || ',' || status || ',' || created object
from dba_objects
order by owner, object_name;

