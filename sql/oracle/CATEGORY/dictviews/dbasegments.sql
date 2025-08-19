
--DESCRIBE: show basic info about database segments

set verify off

clear breaks
clear computes

col type format a20
col tablespace_name format a18
col extents format 999999

col "SEGMENT" format a42
col "BYTES(Kb)" format 999999999
col "INITIAL(Kb)" format 9999999
col "NEXT(Kb)" format 9999999
col "MIN/MAX" format a12
col "PCTI" format 999

select owner || '.' || segment_name "SEGMENT",
       segment_type type,
       tablespace_name ,
       bytes/(1024) "BYTES(Kb)",
       extents,
       min_extents || '/' || max_extents "MIN/MAX",
       initial_extent/(1024) "INITIAL(Kb)",
       next_extent/(1024) "NEXT(Kb)",
       pct_increase "PCTI"
from dba_segments
where owner || '.' || segment_name like upper('%&&1%')
order by owner, segment_name
/

undefine 1
