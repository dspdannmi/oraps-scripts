
--DESCRIBE: show the logging status of tables


set verify off

clear breaks

select owner, table_name, logging
from dba_tables
where owner || '.' || table_name like upper('%&&1%')
order by owner, table_name
/


undefine 1
