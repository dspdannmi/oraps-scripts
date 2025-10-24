
--DESCRIBE: Show ASM disk group usage

col total_mb format 999999999999
col free_mb format 999999999999
col used format 999.99

select name, 
       total_mb, 
       free_mb, 
       total_mb-free_mb used,
       usable_file_mb,
       (total_mb-free_mb)*100/total_mb pctused,
       decode(sign(usable_file_mb), -1, '*** negative usable ***')
from v$asm_diskgroup_stat
order by name;

