
--DESCRIBE: list users by created date

set verify off

clear breaks

col username format a40
col create format a24

select username, created
from dba_users
order by created;

undefine 1

