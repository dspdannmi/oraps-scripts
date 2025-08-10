select sid, recid, to_char(start_time, 'DD-MON-YYYY HH24:MI:SS'), to_char(end_time, 'DD-MON-YYYY HH24:MI:SS'), operation, status, mbytes_processed/1024 "Processed(Gb)", input_bytes/1024/1024/1024 "Input(Gb)", output_bytes/1024/1024/1024 "Output(Gb)", object_type
from v$rman_status
order by sid, recid;
