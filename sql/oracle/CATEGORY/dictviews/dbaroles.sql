
--DESCRIBE: show database roles from dba_roles

set verify off

clear breaks
clear columns
clear computes

select *
from dba_roles
where role like upper('%&&1%')
order by role
/

undefine 1

