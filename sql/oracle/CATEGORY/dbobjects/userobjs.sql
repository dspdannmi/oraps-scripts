
--DESCRIBE: list users, types of objects owner and count of objects

set verify off

clear breaks
clear columns
clear computes

break on owner

col owner format a35
col object_type format a35
col "COUNT" format 99999999

select owner, 
       object_type, 
       count(*) "COUNT"
from dba_objects
where owner || '.' || object_type like upper('%&&1%')
group by owner, object_type
order by owner, object_type
/

undefine 1

