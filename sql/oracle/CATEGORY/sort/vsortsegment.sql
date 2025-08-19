
--DESCRIBE:  show sort segment info from v$sort_segment

set verify off

clear breaks
clear computes

col total heading "TOTAL(Mb)"
col used heading "USED(Mb)"
col free heading "FREE(Mb)"
col max heading "MAX SIZE(MB)"


rem SQL_GOES_HERE

select value db_block_size from v$parameter where name = 'db_block_size'
/

select tablespace_name,
       (total_blocks*&&db_block_size)/(1024*1024) total,
       (used_blocks*&&db_block_size)/(1024*1024) used,
       (free_blocks*&&db_block_size)/(1024*1024) free,
       (max_blocks*&&db_block_size)/(1024*1024) max
from v$sort_segment
/



undefine 1
undefine db_block_size

