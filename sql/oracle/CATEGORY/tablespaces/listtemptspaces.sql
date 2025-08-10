
--DESCRIBE: list name of tablespaces with TEMPORARY contents

set verify off

clear breaks
clear columns
clear computes

select tablespace_name
from dba_tablespaces
where contents = 'TEMPORARY'
order by 1
/
