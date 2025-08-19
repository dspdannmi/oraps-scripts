
--DESCRIBE: determine freespace at end of datafile and then generates shrink script based on that

set verify off

clear breaks

col db_block_size format a16


column value new_val blksize

select value db_block_size from v$parameter where name = 'db_block_size'
/

select 'alter database datafile ''' || file_name || ''' resize ' || ceil( (nvl(hwm,1)*&&blksize)/1024/1024 ) || 'm;'
from dba_data_files a,
     ( select file_id, max(block_id+blocks-1) hwm
         from dba_extents
        group by file_id ) b
where a.file_id = b.file_id(+)
/


