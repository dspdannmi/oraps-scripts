
--DESCRIBE: generates script to recreate object grants for a specified owner

set verify off

clear breaks
clear columns
clear computes

col "SQL" format a80

select 'ALTER SESSION SET CURRENT_SCHEMA = ' || username || ';'
from dba_users
where upper(username) = upper('&&1');

prompt

select 'grant ' || privilege || ' on ' || owner || '.' || table_name || ' to ' || grantee || 
       decode(grantable, 'YES', ' with grant option;', ';') "SQL"
from dba_tab_privs
where upper(owner) = upper('&&1')
/

undefine 1
