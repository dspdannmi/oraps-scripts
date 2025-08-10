
--DESCRIBE: show basic info from dba_part_tables

set verify off

clear breaks
clear columns
clear computes

col "TABLE" format a50
col parttype format a10
col subtype format a10

select owner || '.' || table_name "TABLE",
       partitioning_type parttyp,
       subpartitioning_type subtype,
       partition_count,
       def_tablespace_name
from dba_part_tables
where owner || '.' || table_name like upper('%&1%')
/

undefine 1

