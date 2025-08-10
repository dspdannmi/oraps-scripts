
--DESCRIBE: calls DBMS_STATS to import schema stats

prompt Import stats from STATSTAB for current user to data dictionary
prompt

rem    PROCEDURE IMPORT_SCHEMA_STATS
rem     Argument Name                  Type                    In/Out Default?
rem     ------------------------------ ----------------------- ------ --------
rem     OWNNAME                        VARCHAR2                IN
rem     STATTAB                        VARCHAR2                IN
rem     STATID                         VARCHAR2                IN     DEFAULT
rem     STATOWN                        VARCHAR2                IN     DEFAULT
rem     NO_INVALIDATE                  BOOLEAN                 IN     DEFAULT


accept schema char prompt "Enter schema owner of stats to import: "
accept statid char prompt "Enter STATID for stats to import: "

BEGIN
  DBMS_STATS.import_schema_stats (
    ownname  => upper('&schema'),
    stattab  => 'STATSTAB',
    statid   => '&statid',
    statown  => user);
END;
/

undefine schema
undefine statid
