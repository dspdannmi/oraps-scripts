

--DESCRIBE: show info about object dependencies from dba_dependencies

set verify off

clear breaks
clear computes

col object format a40
col referencedobj format a40
col type format a14
col ref_type format a14
col referenced_link_name format a20

select owner || '.' || name object,
       type,
       referenced_owner || '.' || referenced_name referencedobj,
       referenced_type ref_type,
       referenced_link_name,
       dependency_type
from dba_dependencies
where owner || '.' || name like upper('%&&1%')
   or referenced_owner || '.' || referenced_name like upper('%&&1%')
order by owner, name, referenced_owner, referenced_name
/


undefine 1

