
--DESCRIBE: checks for segments constrained by freespace or maxextents

set verify off

clear breaks
clear columns
clear computes

col owner format a20
col tablespace_name format a28
col segment_name format a45
col "NEXT(Mb)" format 999999
col "MAX(Mb)" format 999999

prompt
prompt Extents that can not throw four extents:

select s.owner, 
       s.segment_name, 
       s.segment_type, 
       s.tablespace_name, 
       s.next_extent/(1024*1024) "NEXT(Mb)", 
       max(f.bytes)/(1024*1024) "MAX(Mb)"
from dba_segments s, dba_free_space f
where s.tablespace_name = f.tablespace_name
group by s.owner, s.segment_name, s.segment_type, s.tablespace_name, s.next_extent
having max(f.bytes) < 4 * s.next_extent
/


col extents format 99999999
col max_extents format 999999999999

prompt
prompt Segments reaching max extents (80%):

select owner, 
       segment_name, 
       segment_type, 
       tablespace_name, 
       extents, 
       max_extents
from dba_segments
where decode(max_extents, 0, 1, extents/max_extents) > 0.80
order by owner, segment_name
/

