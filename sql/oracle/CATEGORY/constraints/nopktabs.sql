
--DESCRIBE: list tables with no primary key

set verify off

clear breaks
clear computes

select a.owner,
       a.table_name
from dba_tables a
where a.owner || '.' || a.table_name like upper('&&1')
  and not exists (select '1' from dba_constraints b
                  where b.owner = a.owner
                    and b.table_name = a.table_name
                    and b.constraint_type = 'P')
order by a.owner, a.table_name
/

undefine 1

