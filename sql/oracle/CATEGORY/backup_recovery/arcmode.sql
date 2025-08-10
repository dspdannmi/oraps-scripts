
--DESCRIBE: show the archive log_mode  of the database

set verify off

clear breaks
clear columns
clear computes

select log_mode
from v$database
/

