
--DESCRIBE: show parent child relationship constraints between tables

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

select a.owner parent_owner, 
       a.table_name parent_table, 
       a.constraint_name parent_con, 
       a.constraint_type parent_type, 
       a.status parent_status,
       b.owner child_owner, 
       b.constraint_name child_con, 
       b.r_owner ref_owner, 
       b.status child_status
from dba_constraints a, dba_constraints b
where a.owner = b.r_owner (+)
  and a.constraint_name = b.r_constraint_name (+)
  and a.constraint_type != 'R'
  and (a.owner = '&&owner' or b.r_owner = '&&owner')
order by 1,2,3,4,5,7,6
/

undefine 1

