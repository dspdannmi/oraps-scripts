
--DESCRIBE: show constraints for a table

set verify off

break on "TABLE" skip 1 on "CONSTRAINT" on "Type" on "CHILD TABLES" on "PARENT TABLE"

col "TABLE" format a35
col "CONSTRAINT" format a18
col "Type" format a1
col "Col Name" format a20

select a.owner || '.' || a.table_name "TABLE",
       a.constraint_name "CONSTRAINT",
       a.constraint_type "Type",
       decode(b.owner, null, '', rpad(b.owner || '.' ||  b.table_name, 33, ' ')) "CHILD TABLES",
       decode(a.constraint_type, 'R', rpad(c.owner || '.' || c.table_name,33,' '),'') "PARENT TABLE"
from dba_constraints a, dba_constraints b, dba_constraints c
where a.owner = b.r_owner (+)
  and a.constraint_name = b.r_constraint_name (+)
  and a.r_owner = c.owner (+)
  and a.r_constraint_name = c.constraint_name (+)
  and a.owner || '.' || a.table_name like upper('&&1')
order by a.owner, a.table_name, a.constraint_name
/

select a.owner || '.' || a.table_name "TABLE",
       a.constraint_name "CONSTRAINT",
       a.constraint_type "Type",
       b.column_name "Col Name",
       b.position
from dba_constraints a, dba_cons_columns b
where a.owner = b.owner (+)
  and a.constraint_name = b.constraint_name (+)
  and a.owner || '.' || a.table_name like upper('&&1')
order by a.owner, a.table_name, a.constraint_name, b.position
/


undefine 1
