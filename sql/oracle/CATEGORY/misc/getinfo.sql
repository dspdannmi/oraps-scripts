

set feedback off


prompt <V_INSTANCE>
@printtbl 'select * from v$instance'
prompt </V_INSTANCE>

prompt <V_DATABASE>
@printtbl 'select * from v$database'
prompt </V_DATABASE>

select 'NUMBER_OF_STANDBY_DEST: ' || count(*)
from v$archive_dest
where status = 'VALID'
and target = 'STANDBY';

select 'DBSIZE_GB:' || round(sum(bytes)/1024/1024/1024)
from v$datafile;



rem col con_id format 99999999999999
col con_id format 99999
col name format a28 heading "CON_NAME"
col open_mode format a10
col restricted format a10

prompt <V_PDBS>
select con_id, name, open_mode, restricted
from v$pdbs
order by con_id;
prompt </V_PDBS>
