
--DESCRIBE: list segments in order by ascending size

set verify off

clear breaks

col segment_name format a50
col segsize heading "SIZE(Mb)" format 9999999.99

select owner || '.' || segment_name segment_name,
       segment_type,
       bytes/(1024*1024) segsize
from dba_segments
where owner || '.' || segment_name like upper('%&&1%')
order by bytes
/

undefine 1

