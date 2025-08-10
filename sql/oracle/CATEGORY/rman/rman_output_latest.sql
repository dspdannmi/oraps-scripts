select
output
from
v$rman_output
where
session_recid = (select max(session_recid) from v$rman_status) order by recid ;

