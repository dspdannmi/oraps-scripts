
select df.tablespace_name, min(f.creation_time)
from dba_data_files df, v$datafile f
where df.file_id = f.file#
group by df.tablespace_name
order by 2;
