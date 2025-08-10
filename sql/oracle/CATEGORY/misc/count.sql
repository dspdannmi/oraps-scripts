
set verify off

--DESCRIBE: count rows in table/view passed as the parameter

clear breaks
clear columns
clear computes

select count(*)
from &&1
/

undefine 1

