
--DESCRIBE: calls DBMS_STATS to drop the STATSTAB table

prompt Dropping stat table STATSTAB from current user 

rem    PROCEDURE DROP_STAT_TABLE
rem     Argument Name                  Type                    In/Out Default?
rem     ------------------------------ ----------------------- ------ --------
rem     OWNNAME                        VARCHAR2                IN
rem     STATTAB                        VARCHAR2                IN



execute dbms_stats.drop_stat_table(USER, 'STATSTAB');


