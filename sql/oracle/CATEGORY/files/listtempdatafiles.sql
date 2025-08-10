
--DESCRIBE: list temporary datafile (not tempfiles) filenames

set verify off

clear breaks
clear columns
clear computes

col file_name format a60

select file_name
from dba_data_files
where tablespace_name in 
   (select tablespace_name
    from dba_tablespaces
    where contents = 'TEMPORARY');
