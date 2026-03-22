

--DESCRIBE: show info for ASM clients from v$asm_client

col GROUP_NUMBER format 999999999
col INSTANCE_NAME format a20
col DB_NAME format a10
col CLUSTER_NAME format a20
col STATUS format a12
col SOFTWARE_VERSION format a16
col COMPATIBLE_VERSION format a16

select * 
from v$asm_client
order by group_number, instance_name;

