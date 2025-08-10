
--DESCRIBE: calls DBMS_STATS to delete schema stats

prompt Delete data dictionary schema stats
prompt

rem    PROCEDURE DELETE_SCHEMA_STATS
rem     Argument Name                  Type                    In/Out Default?
rem     ------------------------------ ----------------------- ------ --------
rem     OWNNAME                        VARCHAR2                IN
rem     STATTAB                        VARCHAR2                IN     DEFAULT
rem     STATID                         VARCHAR2                IN     DEFAULT
rem     STATOWN                        VARCHAR2                IN     DEFAULT
rem     NO_INVALIDATE                  BOOLEAN                 IN     DEFAULT


accept schema char prompt "Enter schema for stats drop: "
BEGIN
  DBMS_STATS.delete_schema_stats (upper('&schema'));
END;
/


undefine schema
