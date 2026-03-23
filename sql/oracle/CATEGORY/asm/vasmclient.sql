

--DESCRIBE: show info for ASM clients from v$asm_client

col GROUP_NUMBER format 999999999
col "DISK_GROUP" format a20
col INSTANCE_NAME format a20
col DB_NAME format a10
col CLUSTER_NAME format a20
col STATUS format a12
col SOFTWARE_VERSION format a16
col COMPATIBLE_VERSION format a16

select d.name "DISK_GROUP", instance_name, db_name, cluster_name, status, software_version, compatible_version
from v$asm_client c, v$asm_diskgroup d
where c.group_number = d.group_number
order by d.name, instance_name, db_name;

