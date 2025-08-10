
--DESCRIBE: calls dbms_stats to gather schame stats to dictionary

accept schema char prompt "Enter schema to gather: "
accept sample char prompt "Enter estimate % or null for complete: "

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
    options          => 'GATHER');
END;
/


undefine schema
undefine sample
