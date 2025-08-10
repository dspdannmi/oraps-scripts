
--DESCRIBE: show package body

set verify off

clear breaks
clear columns
clear computes

set pages 0

set trimout off

select text
from dba_source
where owner || '.' || name = upper('&1')
  and type = 'PACKAGE BODY'
order by line
/

set pages 80

undefine 1
