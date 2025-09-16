
--DESCRIBE: select all from v$version

set verify off

clear breaks
clear computes

col banner format a60
col banner_full format a60
col banner_legacy format a60

select *
from v$version
order by 1
/

undefine 1
