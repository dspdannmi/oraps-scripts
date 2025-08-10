
--DESCRIBE: generate enable constraints sql for non-enabled constraints

set verify off


clear breaks
clear columns
clear computes

break on parent_owner skip 1 on parent_table skip 1 on parent_con on child_owner on ref_owner on child_con

col parent_owner format a12
col parent_table format a25
col parent_type format a8
col child_owner format a12
col child_con format a25
col ref_owner format a12
col ref_name format a25
col parent_status format a8 heading "PStat"
col child_status format a8 heading "CStat"

select 'alter table ' || owner || '.' || table_name || ' enable constraint ' || constraint_name || ';'
from dba_constraints
where owner || '.' || table_name like upper('%&&1%')
  and status != 'ENABLED'
order by 1
/

undefine 1

