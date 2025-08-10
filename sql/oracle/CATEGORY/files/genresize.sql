
--DESCRIBE: generates resize statement for datafile when passed file_id# and new size

set verify off

define fileid='&1'
define newsize='&2'

col "RESIZE DATAFILE SQL" format a120

select 'alter database datafile ''' || file_name || ''' resize &newsize;' "RESIZE DATAFILE SQL"
from dba_data_files
where file_id = '&fileid'
/

undefine 1
undefine 2
