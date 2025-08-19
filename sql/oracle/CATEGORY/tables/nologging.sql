
--DESCRIBE: show nologging tables

set verify off

clear breaks
clear computes

select owner, 
       table_name, 
       logging
from dba_tables
where logging != 'YES'
  and owner || '.' || table_name like upper('%&&1%')
/

undefine 1
