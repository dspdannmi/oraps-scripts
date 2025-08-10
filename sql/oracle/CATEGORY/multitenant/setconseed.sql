
--DESCRIBE: set container to CDB$ROOT

alter session set container=pdb$seed;

col container_name new_value _con_name noprint
set termout off
select sys_context('userenv', 'con_name') as container_name
from dual;
set termout on

REM define _CONTAINER_NAME
set sqlprompt "_user'@'_connect_identifier'{'_con_name'} SQL> '"

