
--DESCRIBE: show open mode of database

col open_mode format a10

select open_mode
from v$database
/
