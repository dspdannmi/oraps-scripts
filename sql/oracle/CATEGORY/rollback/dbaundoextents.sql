
--DESCRIBE: show detail info about dba_undo_extents

set verify off

clear breaks
clear computes

select owner, tablespace_name, status, sum(bytes)/(1024*1024)
from dba_undo_extents
group by owner, tablespace_name, status
/

undefine 1

