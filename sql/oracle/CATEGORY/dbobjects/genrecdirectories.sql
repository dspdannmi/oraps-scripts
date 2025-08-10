
--DESCRIBE: generate script to recreate database directories

set verify off

clear breaks
clear columns
clear computes

break on owner

col object_type format a35
col "COUNT" format 99999999

select 'create or replace directory ' || directory_name || ' as ''' || directory_path || ''';'
from dba_directories
/


undefine 1

