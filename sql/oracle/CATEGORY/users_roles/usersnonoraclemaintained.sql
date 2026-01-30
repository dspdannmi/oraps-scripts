
--DESCRIBE: list users that are not ORACLE_MAINTAINED

set verify off

clear breaks

col profile format a40
col username format a40
col created format a20
col expiry_date format a20
col lock_date format a20
col default_tablespace format a24
col account_status format a18


select username, created, default_tablespace, profile, account_status, lock_date, expiry_date
from dba_users
where oracle_maintained != 'Y'
order by username;

undefine 1

