
--DESCRIBE: show all info about table columns from dba_tab_columns

set verify off

clear breaks
clear columns
clear computes

select *
from dba_tab_columns
where column_name like upper('%&&1%')
   or owner || '.' || table_name like upper('%&&1%')
/

undefine 1
