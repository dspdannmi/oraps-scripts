
--DESCRIBE: select container (old method)

show pdbs

prompt

accept con_name prompt "Enter CON_NAME: "
set verify off
alter session set container=&con_name ;
set verify on

undefine 1

col container_name new_value _con_name noprint
set termout off
select sys_context('userenv', 'con_name') as container_name
from dual;
set termout on

REM define _CONTAINER_NAME
set sqlprompt "_user'@'_connect_identifier'{'_con_name'} SQL> '"

