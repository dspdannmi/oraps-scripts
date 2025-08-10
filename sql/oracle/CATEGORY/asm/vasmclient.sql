

--DESCRIBE: show info for ASM clients from v$asm_client

col compatible_version format a24
col instance_name format a20
col software_version format a20

select * from v$asm_client
/

