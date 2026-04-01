
--DESCRIBE: display information from database to give to DBvisit to obtain license

col name format a32
col value format a32
col platform_name format a60

set echo on
set feedback on
set termout on

select name, value
from v$parameter
where name = 'db_name';

prompt

select name, platform_name
from v$database;

