
--DESCRIBE: show online backup status for individual datafiles

set verify off

clear breaks
clear columns
clear computes

col name format a80 

select name, b.status
from v$datafile a, 
     v$backup b
where a.file# = b.file#
/

