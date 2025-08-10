
--DESCRIBE: generates script to move/rebuild tables

set verify off

clear breaks
clear columns
clear computes


select 'alter table ' || owner || '.' || table_name || ' move tablespace &new_tablespace ;'
from dba_tables
where owner || '.' || table_name like upper('%&owner_table%')
  and tablespace_name like upper('%&curr_tspace%')
/

undefine new_tablespace
undefine owner_table
undefine curr_tspace

