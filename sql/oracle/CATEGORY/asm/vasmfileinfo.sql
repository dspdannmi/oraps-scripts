
--DESCRIBE: show ASM file info from v$asm_file and v$asm_alias

col type format a24

select f.group_number, 
       f.file_number, 
       a.name, 
       f.bytes, 
       f.type, 
       f.redundancy, 
       f.striped, 
       f.creation_date
from v$asm_file f, v$asm_alias a
where f.group_number = a.group_number (+)
  and f.file_number = a.file_number (+)
order by group_number, a.name
/

