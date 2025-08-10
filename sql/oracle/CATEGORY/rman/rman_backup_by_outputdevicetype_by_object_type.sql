
select distinct output_device_type, object_type
from v$rman_status
where operation = 'BACKUP'
  and trunc(start_time) > trunc(sysdate-31);


