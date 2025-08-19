
--DESCRIBE: list controlfile filenames

set verify off

clear breaks

col name format a60

select name
from v$controlfile
order by name
/

