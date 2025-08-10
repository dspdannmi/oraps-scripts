
--DESCRIBE: show basic info about table partitions from dba_tab_partitions

set verify off

clear breaks
clear columns
clear computes

break on "TABLE"

col "TABLE" format a40

select table_owner || '.' || table_name "TABLE",
partition_name,
subpartition_count,
high_value,
tablespace_name
from dba_tab_partitions
where table_owner || '.' || table_name like upper('%&&1%')
order by table_owner, table_name, partition_name
/

undefine 1
