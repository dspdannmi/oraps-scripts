
--DESCRIBE: show database uptime in days and hours and startup time

set verify off

select sysdate-startup_time "DAYS",
       (sysdate-startup_time)*24 "HOURS",
       to_char(startup_time, 'DD-MON-YYYY HH24:MI:SS') "UP SINCE"
from v$instance
/

