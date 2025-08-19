
--DESCRIBE: show archived log filenames from v$archived_log

set verify off

clear breaks 

col name format a132

select name
from v$archived_log
order by sequence#
/
 
undefine 1

