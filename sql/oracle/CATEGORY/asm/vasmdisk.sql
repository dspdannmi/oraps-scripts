
--DESCRIBE: show ASM disk info from v$asm_disk

col failgroup format a10
col group_number heading "Grp#" format 999
col disk_number heading "Dsk#" format 999
col library format a10
col path format a30
col product format a10

col used heading "USED(%)" format 99999


select group_number, 
       disk_number, 
       mount_status, 
       header_status, 
       mode_status, 
       state, 
       redundancy, 
       library, 
       os_mb, 
       total_mb, 
       free_mb, 
       (total_mb-free_mb)*100/total_mb used, 
       name, 
       failgroup, 
       path, 
       product, 
       voting_file
from v$asm_disk
order by group_number, disk_number;

