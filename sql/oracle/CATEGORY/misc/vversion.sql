
--DESCRIBE: select banner from v$version for Oracle Database row

set verify off

clear breaks
clear computes

select banner
from v$version
where lower(banner) like 'oracle database%'
order by 1
/

undefine 1
