
column address new_value v_address
column hash_value new_value v_hash_value

select address, hash_value from v$sqlarea where sql_id = '&sqlid';

select sql_id, executions
from v$sql
where sql_id = '&sqlid';

set serveroutput on

prompt
prompt Flush sql_id (&sqlid) from shared_pool
exec dbms_shared_pool.purge('&v_address,&v_hash_value','C')

