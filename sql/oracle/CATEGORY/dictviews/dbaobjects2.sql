
--DESCRIBE: show all from dba_objects

set verify off

clear breaks
clear computes

col owner format a15
col object_name format a40
col object_type format a15
col status format a12

select *
from dba_objects
where owner || '.' || object_name like upper('%&&1%')
order by owner, object_name
/

undefine 1

