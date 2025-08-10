

--DESCRIBE: creates dbms_stats STATSTAB table

prompt Creating stat table STATSTAB as current user in default tablespace


rem    PROCEDURE CREATE_STAT_TABLE
rem     Argument Name                  Type                    In/Out Default?
rem     ------------------------------ ----------------------- ------ --------
rem     OWNNAME                        VARCHAR2                IN
rem     STATTAB                        VARCHAR2                IN
rem     TBLSPACE                       VARCHAR2                IN     DEFAULT


execute dbms_stats.create_stat_table(USER, 'STATSTAB');
