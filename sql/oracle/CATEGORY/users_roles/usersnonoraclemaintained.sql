
--DESCRIBE: list users that are not ORACLE_MAINTAINED

set verify off

clear breaks

col profile format a40
col username format a40
col created format a24
col default_tablespace format a24

select username, created, default_tablespace, profile
from dba_users
where oracle_maintained != 'Y'
order by username;

undefine 1

