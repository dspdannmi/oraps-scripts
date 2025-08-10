
--DESCRIBE: show basic info about indexes from dba_indexes

set verify off

clear breaks
clear columns
clear computes

col "INDEX" format a40
col "TABLE" format a40
col index_type format a14
col tablespace_name format a18

select  owner || '.' || index_name "INDEX", 
	index_type, 
	table_owner || '.' || table_name "TABLE", 
	table_type, 
	uniqueness, 
	tablespace_name
from dba_indexes
where owner || '.' || index_name like upper('%&1%')
order by owner, index_name
/

undefine 1

