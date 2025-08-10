
--DESCRIBE: show name and created date from v$database

set verify off

clear breaks
clear columns
clear computes

col created format a26
col name format a14

select name, 
       created
from v$database
/

undefine 1

