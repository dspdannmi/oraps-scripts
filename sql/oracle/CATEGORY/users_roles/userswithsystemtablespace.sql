
--DESCRIBE: list non-SYS and non-SYSTEM users with SYSTEM as default tablespace

set verify off

clear breaks

col username format a32

select username
from dba_users
where default_tablespace = 'SYSTEM'
  and username not in ('SYS', 'SYSTEM')
order by username;


undefine 1

