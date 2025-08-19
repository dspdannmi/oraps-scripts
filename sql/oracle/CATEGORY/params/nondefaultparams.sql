
--DESCRIBE: list initialization parameters that contain non-default settings

set verify off

clear breaks
clear computes

select name || '=' ||  value name
from v$parameter
where isdefault != 'TRUE'
order by name
/

