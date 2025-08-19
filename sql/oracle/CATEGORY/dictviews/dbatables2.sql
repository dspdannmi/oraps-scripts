
--DESCRIBE: show all info about tables from dba_tables

set verify off

clear breaks
clear computes

col owner format a14
col table_name format a36
col "TSpace" format a20
col cluster_name format a16
col iot_name format a16

select *
from dba_tables
where owner || '.' || table_name like upper('%&1%')
order by owner, table_name
/

undefine 1

