
--DESCRIBE: generates script to rebuild indexes

set verify off

clear breaks


select 'alter index ' || owner || '.' || index_name || ' rebuild tablespace &new_tspace ;'
from dba_indexes
where owner || '.' || index_name like upper('%&owner_index%')
  and tablespace_name like upper('%&orig_tspace%')
/

undefine new_tspace
undefine owner_index
undefine orig_tspace

