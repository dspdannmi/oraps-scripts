
--DESCRIBE: display contents of v$access

set verify off

clear breaks
clear columns
clear computes

col sid format 99999
col owner format a30
col object format a60
col type format a24


select * from v$access
where owner || '.' || object like upper('%&&1%')
order by owner, object
/

undefine 1

