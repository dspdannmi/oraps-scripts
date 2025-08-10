
--DESCRIBE: show source code for stored procedures/functions etc from dba_source

set verify off

clear columns
clear breaks
clear computes

select text
from dba_source
where owner || '.' || name like upper('%&object%')
  and type like upper('%&type%')
order by owner, name, type, line
/

clear breaks
clear columns

undefine object
undefine type

