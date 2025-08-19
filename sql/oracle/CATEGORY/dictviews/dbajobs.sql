
--DESCRIBE: show info from dba_jobs

set verify off

clear breaks
clear computes

select job, 
       log_user, 
       priv_user, 
       schema_user, 
       to_char(last_date, 'DD-MON-YYYY HH24:MI:SS'),
       to_char(this_date,'DD-MON-YYYY HH24:MI:SS'), 
       to_char(next_date,'DD-MON-YYYY HH24:MI:SS'), 
       broken, 
       interval, 
       failures, 
       what
from dba_jobs
order by job
/

