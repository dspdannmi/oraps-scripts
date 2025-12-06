
--DESCRIBE: list profiles of users that are not Oracle maintained

set verify off

clear breaks

select distinct profile 
from dbausers 
where oracle_maintained != 'Y'
order by 1;

