
--DESCRIBE: show datafile backup status

set verify off

clear breaks
clear columns
clear computes

select distinct t.name, 
		b.status
from v$datafile d, 
     v$tablespace t, 
     v$backup b
where d.ts# = t.ts#
  and d.file# = b.file#
/

