
--DESCRIBE: calculate number of days from now until given date

set verify off

clear breaks
clear columns
clear computes

col "DAYS TO GO" format a14

select trunc(to_date('&&1', 'DD-MON-YYYY') - sysdate) || ' days' "DAYS TO GO"
from dual
/

undefine 1

