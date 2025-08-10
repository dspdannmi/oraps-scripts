
--DESCRIBE: list invalid objects from dba_objects


set verify off

clear breaks
clear columns
clear computes

col owner format a15
col object_name format a45
col object_type format a20

select owner, 
       object_name,
       object_type
       object_id,
       status,
       temporary,
       generated,
       secondary
from dba_objects
where status != 'VALID'
  and owner like decode(upper('&&1'), null, '%', 'ALL', '%', upper('&&1'))
order by owner, object_name
/

undefine 1

