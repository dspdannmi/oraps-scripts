
--DESCRIBE: show package specification

set verify off
set trimout off
set pages 0

clear breaks
clear computes

select text
from dba_source
where owner || '.' || name = upper('&1')
  and type = 'PACKAGE'
order by line
/

set pages 80 

undefine 1
