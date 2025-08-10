
--DESCRIBE: show summary info from v$logmnr_contents view

set verify off

clear breaks
clear columns
clear computes

select  username, sql_redo, sql_undo
from  v$logmnr_contents
where username like upper('%&&1%')
/

