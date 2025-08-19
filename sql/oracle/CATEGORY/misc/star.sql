
--DESCRIBE: script to easily do select(*) from object passed as parameter

set verify off

clear breaks
clear computes

select *
from &&1
/

undefine 1

