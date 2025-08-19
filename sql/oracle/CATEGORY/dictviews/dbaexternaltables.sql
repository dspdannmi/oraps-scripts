
--DESCRIBE: list basic info on external tables

set verify off

clear breaks
clear computes

select owner || '.' || table_name,
       default_directory_owner,
       default_directory_name,
       access_type
from dba_external_tables
where owner || '.' || table_name like upper('%&&1%')
/

undefine 1

