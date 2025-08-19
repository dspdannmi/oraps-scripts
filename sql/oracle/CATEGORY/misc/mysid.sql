
--DESCRIBE: show sid for current session

set verify off

clear breaks
clear computes

select sid
from v$mystat
where rownum < 2
/

undefine 1

