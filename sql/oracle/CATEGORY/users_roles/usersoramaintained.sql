
--DESCRIBE: list users by created date

set verify off

clear breaks

col oracle_maintained format a18
col username format a40
col created format a24

select oracle_maintained, username, created
from dba_users
order by created;

undefine 1

