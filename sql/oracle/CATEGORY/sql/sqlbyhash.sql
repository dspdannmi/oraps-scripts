
--DESCRIBE: show all sql by hash value

set verify off

clear breaks
clear columns
clear computes

col sid format 999999
col username format a18
col command_type format 999
col sql_text format a75

break on sid skip 1 on username on command_type

select sql_text
from v$sqltext
where hash_value = &&1
order by piece
/


undefine 1


