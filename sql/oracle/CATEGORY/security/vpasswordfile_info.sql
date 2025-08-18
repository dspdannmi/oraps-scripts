
--DESCRIBE: show password file info from contents of v$passwordfile_info

set verify off

clear breaks
clear columns
clear computes

col file_name format a100
col format format a8
col is_asm format a6
col con_id format 999999

select * from v$passwordfile_info;

