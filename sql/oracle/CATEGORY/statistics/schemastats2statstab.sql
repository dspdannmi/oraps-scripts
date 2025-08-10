
--DESCRIBE: calls DBMS_STATS to gather schema stats to STATSTAB table

prompt Gather stats to current user STATSTAB table
prompt

accept schema char prompt "Enter schema to gather: "
accept statid char prompt "Enter STATID for this gather: "
accept sample char prompt "Enter sample estimate % or null for complete: "

rem    PROCEDURE GATHER_SCHEMA_STATS
rem     Argument Name                  Type                    In/Out Default?
rem     ------------------------------ ----------------------- ------ --------
rem     OWNNAME                        VARCHAR2                IN
rem     ESTIMATE_PERCENT               NUMBER                  IN     DEFAULT
rem     BLOCK_SAMPLE                   BOOLEAN                 IN     DEFAULT
rem     METHOD_OPT                     VARCHAR2                IN     DEFAULT
rem     DEGREE                         NUMBER                  IN     DEFAULT
rem     GRANULARITY                    VARCHAR2                IN     DEFAULT
rem     CASCADE                        BOOLEAN                 IN     DEFAULT
rem     STATTAB                        VARCHAR2                IN     DEFAULT
rem     STATID                         VARCHAR2                IN     DEFAULT
rem     OPTIONS                        VARCHAR2                IN     DEFAULT
rem     OBJLIST                        DBMS_STATS              OUT
rem     STATOWN                        VARCHAR2                IN     DEFAULT
rem     NO_INVALIDATE                  BOOLEAN                 IN     DEFAULT
rem     GATHER_TEMP                    BOOLEAN                 IN     DEFAULT
rem     GATHER_FIXED                   BOOLEAN                 IN     DEFAULT


BEGIN
  DBMS_STATS.gather_schema_stats (
    ownname          => upper('&schema'),
    estimate_percent => &sample,
    block_sample     => false,
    method_opt       => 'FOR ALL COLUMNS SIZE 1',
    degree           => null,
    granularity      => 'ALL',
    cascade          => true,
    stattab          => 'STATSTAB',
    statid           => '&statid',
    options          => 'GATHER',
    statown          => USER);
END;
/

undefine schema
undefine statid
undefine sample
