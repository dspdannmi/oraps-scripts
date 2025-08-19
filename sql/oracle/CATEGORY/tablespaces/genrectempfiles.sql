
--DESCRIBE: generates script to recreate tempfiles

set verify off

clear breaks

col sql_text heading "SQL_TEXT" format a120

select 'alter tablespace ' || tablespace_name || ' add tempfile ''' || file_name ||''';' sql_text
from dba_temp_files
order by tablespace_name, file_name
/

