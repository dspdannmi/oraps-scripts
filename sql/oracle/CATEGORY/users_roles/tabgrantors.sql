
--DESCRIBE: list distinct grantors of object privileges

set verify off

clear breaks
clear computes

select distinct grantor
from dba_tab_privs
/
