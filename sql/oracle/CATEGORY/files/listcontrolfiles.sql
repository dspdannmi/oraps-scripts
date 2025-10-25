
--DESCRIBE: list controlfile filenames

set verify off

clear breaks

col name format a100

select name
from v$controlfile
order by name
/

