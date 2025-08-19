
--DESCRIBE: shows whether stats where system or user generated

set verify off

clear breaks

col user_stats format a25  heading "User generated? (USER_STATS)"

select owner, 
       table_name, 
       user_stats 
from dba_tables
where owner || '.' || table_name like upper('%&&1%')
/

undefine 1

