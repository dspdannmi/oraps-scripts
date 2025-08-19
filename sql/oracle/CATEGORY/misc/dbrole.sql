
--DESCRIBE: show database_role from v$database

set verify off

clear breaks

col database_role format a18
col name format a14

select name, 
       database_role
from v$database
/

undefine 1

