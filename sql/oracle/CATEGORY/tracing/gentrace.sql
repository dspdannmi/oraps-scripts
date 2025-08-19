
--DESCRIBE: generates script to put all sessions in trace mode

set verify off

clear breaks

select 'execute dbms_system.set_sql_trace_in_session(' || sid || ', ' || serial# || ', true);'
from v$session
where username not like 'SYS%'
/

undefine 1

