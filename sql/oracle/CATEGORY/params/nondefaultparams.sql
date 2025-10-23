
--DESCRIBE: list initialization parameters that contain non-default settings

set verify off

clear breaks
clear computes

col name format a120

select name || '=' ||  value name
from v$parameter
where isdefault != 'TRUE'
order by name
/

