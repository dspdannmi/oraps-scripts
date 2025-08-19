

--DESCRIBE: show all contents from dba_indexes

set verify off

clear breaks
clear computes

col owner format a16
col table_owner format a16
col table_name format a30
col index_name format a30
col index_type format a14
col tablespace_name format a18


select *
from dba_indexes
where owner || '.' || index_name like upper('%&1%')
order by owner, index_name
/

undefine 1

