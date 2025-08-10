
--DESCRIBE: show hash chain lengths


set verify off

clear breaks
clear columns
clear computes

rem 
rem Metalink DocID 62143.1
rem

rem Checking for hash chain lengths

rem Should usually return 0 rows.  If large or double figure often means a bug.
rem Advisable to drill down to look at the actual sql 

select hash_value, 
       count(*)
from v$sqlarea 
group by hash_value 
having count(*) > 5
/


