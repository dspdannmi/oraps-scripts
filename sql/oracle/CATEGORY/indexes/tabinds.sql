
--DESCRIBE: show index and index column info for indexes on a table

set verify off

clear breaks
clear columns
clear computes

col "TABLE" format a35
col "INDEX" format a35
col owner heading "INDX OWNER" format a15
col table_type heading "TBL TYPE" format a10
col uniqueness heading "UNIQ" format a4
col column_name heading "COLUMN" format a30
col tablespace_name format a18


break on "TABLE" skip 1 on "INDEX" skip 1 on table_type on tablespace_name on uniqueness

select i.table_owner || '.' || i.table_name "TABLE",
       i.owner || '.' || i.index_name "INDEX",
       i.table_type,
       i.tablespace_name,
       decode(i.uniqueness, 'UNIQUE', 'Y', ' ') uniqueness,
       c.column_name
from dba_indexes i, dba_ind_columns c
where (i.table_owner || '.' || i.table_name like upper('%&&1%') or i.owner || '.' || i.index_name like upper('%&&1%'))
  and i.owner = c.index_owner
  and i.index_name = c.index_name
  and i.table_owner = c.table_owner
  and i.table_name = c.table_name
order by i.table_owner, i.table_name, i.owner, i.index_name, c.column_position
/

undefine 1
