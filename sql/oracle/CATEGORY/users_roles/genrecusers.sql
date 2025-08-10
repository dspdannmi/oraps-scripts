
--DESCRIBE: generates basic script to recreate users

set verify off

clear breaks
clear columns
clear computes

select 'create user ' || username || ' identified by values ''' || password || ''' temporary tablespace ' || temporary_tablespace ||
' default tablespace ' || default_tablespace || ';'
from dba_users
/


undefine 1

