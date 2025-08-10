
--DESCRIBE: show all from dba_segments

set verify off

clear breaks
clear columns
clear computes

col owner format a14
col segment_name format a34
col tablespace_name format a18

col type format a20
col tablespace_name format a18
col extents format 999999

col "SEGMENT" format a42
col "BYTES(Kb)" format 9999999
col "INITIAL(Kb)" format 9999999
col "NEXT(Kb)" format 9999999
col "MIN/MAX" format a12
col pct_increase heading PCT format 999 
col min_extents heading MIN format 999999
col max_extents heading MAX format 99999999999
col freelists heading FREELSTS format 99999
col freelist_groups heading FLIST_GRPS format 99999
col initial_extent heading INITIAL format 9999999999
col next_extent heading NEXT format 999999999
col blocks format 9999999


select *
from dba_segments
where owner || '.' || segment_name like upper('%&&1%')
order by owner, segment_name
/

undefine 1

