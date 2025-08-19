
--DESCRIBE: show all info about users from dba_users

set verify off

clear breaks
clear computes

col profile format a16
col username format a16
col external_name format a20

select  *
from dba_users
where username like upper('%&&1%')
order by username
/

undefine 1

