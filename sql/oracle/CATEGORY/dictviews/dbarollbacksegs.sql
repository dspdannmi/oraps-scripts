
--DESCRIBE: show info from dba_rollback_segs

set verify off

clear breaks
clear computes

col tablespace_name format a28
col "INITIAL(Mb)" format 99999999
col "NEXT(Mb)" format 99999999
col pctinc format 999999
col status format a12

select segment_name,
       owner,
       tablespace_name,
       initial_extent/(1024*1024) "INITIAL(Mb)",
       next_extent/(1024*1024) "NEXT(Mb)",
       min_extents,
       max_extents,
       pct_increase pctinc,
       status
from dba_rollback_segs
order by segment_name
/

