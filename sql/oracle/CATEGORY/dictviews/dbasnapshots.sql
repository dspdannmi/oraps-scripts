
--DESCRIBE: show basic info about snapshots from dba_snapshots

set verify off

clear breaks
clear computes

col error format 9999999
col "LAST_REFRESH" format a20

select owner, 
       name, 
       table_name, 
       error, 
       to_char(last_refresh, 'DD-MON-YYYY HH24:MI:SS') "LAST_REFRESH" 
from dba_snapshots
order by 1,2
/

