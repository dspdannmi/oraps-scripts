
--DESCRIBE: list segment count by non-Oracle maintained users

set verify off

clear breaks
clear columns
clear computes

col segment_name format a40
col "BYTES (Mb)" format 999999999999

select owner, segment_name, count(*)
from dba_segments
where owner not in (select username from dba_users where oracle_maintained = 'Y')
order by 1,2,3
/
