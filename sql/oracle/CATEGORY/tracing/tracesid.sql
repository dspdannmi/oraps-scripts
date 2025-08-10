
--DESCRIBE: toggles tracing for a session

set verify off

clear breaks
clear columns
clear computes

accept sid char prompt       "sid:        "
accept serial char prompt    "serial#:    "
accept truefalse char prompt "true|false: "

begin
    dbms_system.set_sql_trace_in_session(&sid, &serial, &truefalse);
end;
/

undefine sid
undefine serial
undefine truefalse
