
--DESCRIBE: turns off tracing for a session

set verify off

clear breaks
clear columns
clear computes

accept sid char prompt       "sid:        "
accept serial char prompt    "serial#:    "

begin
    sys.dbms_system.set_ev(&sid, &serial, 10046, 0, '');
end;
/

undefine sid
undefine serial
