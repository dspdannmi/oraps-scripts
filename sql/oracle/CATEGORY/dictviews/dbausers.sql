
--DESCRIBE: show basic info on users from dba_users

set verify off

clear breaks
clear columns
clear computes

col username format a28
col password format a20

col user_id format 99999999999
col "DEFAULT_TS" format a24
col "TEMP_TS" format a12
col profile format a16

select user_id, 
       username, 
       password, 
       default_tablespace "DEFAULT_TS", 
       temporary_tablespace "TEMP_TS", 
       created, 
       profile
from dba_users
where username like upper('%&&1%')
order by username
/

undefine 1

