
--DESCRIBE: show all java policy grants/revokes

set verify off

clear breaks
clear computes

col name format a40
col kind format a12
col type_name format a30
col action format a20
col type_schema format a12

select * 
from dba_java_policy
order by name, kind
/

