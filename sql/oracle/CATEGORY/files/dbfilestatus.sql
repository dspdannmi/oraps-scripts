
--DESCRIBE: list datafiles status and backup status 

--the format for this is intended to be consumed by other scripts
--such as for scripted clones/refreshes

set verify off

clear breaks
clear columns
clear computes

col "FILE/BKUP STATUS" format a120


select a.name || ':' || a.status || ':' || b.status || ':' || b.change# "FILE/BKUP STATUS"
from v$datafile a, v$backup b
where a.file# = b.file#
order by a.name
/

