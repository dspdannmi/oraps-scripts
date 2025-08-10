
--DESCRIBE: list unusable indexes

set verify off

clear breaks
clear columns
clear breaks

select a.owner, index_name, table_owner, table_name, a.tablespace_name, bytes/(1024*1024) "MB"
from dba_indexes a, dba_segments b
where a.owner || '.' || index_name like '%&&1%'
  and a.owner = b.owner
  and a.index_name = b.segment_name
  and status = 'UNUSABLE'
order by 1
/

undefine 1

