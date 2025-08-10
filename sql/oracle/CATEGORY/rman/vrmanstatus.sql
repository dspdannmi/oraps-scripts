
--DESCRIBE: show output from v$rman_status

select recid, stamp, parent_recid, parent_stamp, session_recid, session_stamp, operation, status, mbytes_processed, to_char(start_time, 'DD-MON-YYYY HH24:MI:SS'), to_char(end_time, 'DD-MON-YYYY HH24:MI:SS'), output_device_type
from v$rman_status
where start_time > sysdate-31
order by start_time;
