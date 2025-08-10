
--DESCRIBE: show constraints and parent-child relationships

rem
rem Show the indexes on a table
rem
rem Author:     Michael Dann
rem             26-MAR-1999
rem

set verify off

col "Table" format a35
col "Indx Owner" format a15
col "Indx Name" format a30
col "Tbl Type" format a12
col "Unique" format a8
col "Column" format a25
col "Tspace" format a15

break on "Table" skip 1 on "Indx Owner" on "Indx Name" skip 1 on "Tbl Type" on "Unique" on "Tspace" on "Con"

select i.table_owner || '.' || i.table_name "Table",
       i.owner "Indx Owner", 
       i.index_name "Indx Name", 
       i.table_type "Tbl Type", 
       decode(i.uniqueness, 'UNIQUE', 'Y', ' ') "Unique", 
       i.tablespace_name "Tspace",
       decode(co.constraint_type, null, '', 'Yes') "Con",
       c.column_name "Column"
from dba_indexes i, dba_ind_columns c, dba_constraints co
where i.table_owner = decode('&&1', '', user, upper('&&1'))
  and i.table_name = upper('&&2')
  and i.owner = c.index_owner
  and i.index_name = c.index_name
  and i.table_owner = c.table_owner
  and i.table_name = c.table_name
  and i.owner = co.owner (+)
  and i.index_name = co.constraint_name (+)
  and co.constraint_type (+) = 'P'
order by i.owner, i.index_name, c.column_position
/
undefine 1
undefine 2

