
--DESCRIBE: generates script to assist with recreating all database links

set verify off
set serveroutput on size 50000

--
-- This script should be run from connect as SYSDBA as after Oracle9i
-- and later, a DBA account may not necessarily have access to the
-- sys.link$ table
--

select decode(a.owner#, 1, 'PUBLIC',username) || ':' || name || ':' || userid || ':' || nvl(a.password, '--------') || ':' || host
from sys.link$ a, dba_users  b 
where a.owner# = b.user_id (+)
/
