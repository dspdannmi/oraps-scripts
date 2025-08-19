
--DESCRIBE: list objects created on this calendar day

set verify off

clear breaks
clear computes

col owner format a20
col object_name format a40
col object_type format a25
col created format a20


select owner, 
       object_name, 
       object_type, 
       to_char(created, 'HH24:MI DD-MON-YYYY') "CREATED_TODAY"
from dba_objects
where trunc(created) = trunc(sysdate)
order by created, owner, object_name
/

