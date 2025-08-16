
--DESCRIBE: Show current disk group usage

col total_mb format 999999999999
col free_mb format 999999999999
col used format 999.99

select name, 
       total_mb, 
       free_mb, 
       total_mb-free_mb used,
       (total_mb-free_mb)*100/total_mb pctused
from v$asm_diskgroup_stat
order by name;

