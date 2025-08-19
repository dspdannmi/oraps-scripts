
--DESCRIBE: list objects that do not have public synonyms

set verify off

clear breaks
clear computes

col owner format a15
col object_name format a45
col object_type format a20

select o.owner, o.object_name, o.object_type
from dba_objects o
where o.object_type not in ('SYNONYM','DATABASE LINK', 'JAVA CLASS')
and not exists
(select 1
 from dba_synonyms s
 where s.table_owner = o.owner
   and s.table_name = o.object_name
   and s.owner = 'PUBLIC')
/
