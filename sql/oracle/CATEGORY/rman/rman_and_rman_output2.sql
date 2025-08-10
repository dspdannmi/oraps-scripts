select rman_status_recid, recid, output
from v$rman_output
where rman_status_recid in (15012, 15015)
order by rman_status_recid, recid
/
