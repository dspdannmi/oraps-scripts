

--DESCRIBE: select all from user constraints

set verify off

clear breaks
clear columns
clear computes

select *
from user_constraints
where constraint_name like upper('%&&1%')
   or table_name like upper('%&&1%')
/
