
--DESCRIBE: Show current disk group usage

select name, 
       total_mb, 
       free_mb, 
       total_mb-free_mb used,
       (total_mb-free_mb)*100/total_mb pctused
from v$asm_diskgroup_stat
order by name;

