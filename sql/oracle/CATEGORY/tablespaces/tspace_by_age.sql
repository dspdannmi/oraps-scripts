
--DESCRIBE: list tablespaces by age of oldest datafile

set verify off

clear breaks
clear computes


select df.tablespace_name, to_char(min(f.creation_time), 'YYYY-MM-DD HH24:MI')
from dba_data_files df, v$datafile f
where df.file_id = f.file#
group by df.tablespace_name
order by 2;

undefine 1


