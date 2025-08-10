
--DESCRIBE: generates script to reset passwords

set verify off

clear breaks
clear columns
clear computes

select 'alter user ' || username || ' identified by values ''' || password || ''';'
from dba_users
order by username
/

undefine 1

