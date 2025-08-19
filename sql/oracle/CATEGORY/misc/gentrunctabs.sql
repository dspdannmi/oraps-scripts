
--DESCRIBE: generates script to truncate all tables for an owner

set verify off

clear breaks

select 'truncate table ' || owner || '.' || table_name || ';'
from dba_tables
where owner like upper('%&&1%')
order by 1;

undefine 1

