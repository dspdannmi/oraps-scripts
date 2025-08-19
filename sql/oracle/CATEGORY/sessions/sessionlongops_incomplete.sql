
--DESCRIBE: show rows from v$session_longops that are in progress

set verify off

clear breaks
clear computes

col sql_text format a100 wrap

select * 
from v$session_longops 
where sofar != totalwork
/


undefine 1
