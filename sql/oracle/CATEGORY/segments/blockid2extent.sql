
--DESCRIBE: identifies database segment for a given file_id# and block#

set verify off

clear breaks
clear computes

col segment format a55
col owner format a20

select owner || '.' || segment_name segment,
       segment_type
from dba_extents
where file_id = &&file_id
  and &&block_id between block_id and block_id + blocks - 1
/

undefine file_id
undefine block_id
