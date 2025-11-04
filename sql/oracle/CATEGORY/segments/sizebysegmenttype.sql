
--DESCRIBE: show total space by owner and segment type

set verify off

clear breaks
clear computes

col owner format a32
col segment_type format a32
col "COUNT" format 99999
col "SIZE(GB)" format 99999999

select owner, segment_type, count(*) "COUNT", sum(bytes)/1024/1024/1024 "SIZE(GB)"
from dba_segments
where upper(owner) like upper('%&&1&')
  or upper(segment_type) like upper('%&&1%')
group by owner, segment_type
order by 1,2;

