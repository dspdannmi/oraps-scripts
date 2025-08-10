
--DESCRIBE: calls DBMS_STATS to commence monitoring of a schema for changes


prompt Monitor schema for changes for statistics
prompt
prompt 9i only

prompt
prompt

rem    PROCEDURE ALTER_SCHEMA_TAB_MONITORING
rem     Argument Name                  Type                    In/Out Default?
rem     ------------------------------ ----------------------- ------ --------
rem     OWNNAME                        VARCHAR2                IN     DEFAULT
rem     MONITORING                     BOOLEAN                 IN     DEFAULT


accept schema char prompt "Enter schema to monitor: "
accept truefalse char prompt "Turn on: [true|false]: "

begin
    dbms_stats.alter_schema_tab_monitoring('&schema', &truefalse);
end;
/

undefine schema
undefine truefalse
