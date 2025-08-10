
--DESCRIBE: deletes schema stats from the STATSTAB table

prompt Delete schema stats from STATSTAB
prompt

rem    PROCEDURE DELETE_SCHEMA_STATS
rem     Argument Name                  Type                    In/Out Default?
rem     ------------------------------ ----------------------- ------ --------
rem     OWNNAME                        VARCHAR2                IN
rem     STATTAB                        VARCHAR2                IN     DEFAULT
rem     STATID                         VARCHAR2                IN     DEFAULT
rem     STATOWN                        VARCHAR2                IN     DEFAULT
rem     NO_INVALIDATE                  BOOLEAN                 IN     DEFAULT



select distinct statid
from statstab
/

accept statid char prompt "Enter statid to delete: "
accept schema char prompt "Enter schema to delete: "

BEGIN
  DBMS_STATS.delete_schema_stats (
    ownname  => upper('&schema'),
    stattab  => 'STATSTAB',
    statid   => '&statid',
    statown  => user);
END;
/

prompt
select distinct statid
from statstab
/


undefine statid
undefine schema

