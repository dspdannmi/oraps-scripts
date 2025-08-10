
--DESCRIBE: show temporary segments

set verify off

clear breaks
clear columns
clear computes

col segment_name format a40
col "BYTES (Mb)" format 999999999999

select owner, segment_name, tablespace_name, bytes/(1024*1024) "BYTES (Mb)"
from dba_segments
where segment_type = 'TEMPORARY'
order by 1,2,3
/
