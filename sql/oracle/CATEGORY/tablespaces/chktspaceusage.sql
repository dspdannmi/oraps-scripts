
--DESCRIBE: show tablespace usage by owner and segment type

set verify off

clear breaks
clear columns
clear computes

col owner format a20
col tablespace_name format a24

break on tablespace_name on owner

select distinct tablespace_name,
		owner, 
                segment_type, 
		count(*)
from dba_segments
group by tablespace_name, owner, segment_type
order by tablespace_name, owner, segment_type
/

