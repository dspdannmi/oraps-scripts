
--DESCRIBE: generates script to turn of systemwide trace

set verify off

clear breaks

select 'execute dbms_system.set_sql_trace_in_session(' || sid || ', ' || serial# || ', false);'
from v$session
where username not like 'SYS%'
/

undefine 1

