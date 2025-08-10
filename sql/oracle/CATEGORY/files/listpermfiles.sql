
--DESCRIBE: list datafiles with non-TEMPORARY contents

set verify off

clear breaks
clear columns
clear computes

col file_name format a60

select file_name
from dba_data_files a,
     dba_tablespaces b
where a.tablespace_name = b.tablespace_name
  and b.contents != 'TEMPORARY'
order by file_name
/

