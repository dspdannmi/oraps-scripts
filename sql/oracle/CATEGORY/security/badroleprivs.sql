
--DESCRIBE: list grantees and granted roles for super-user type roles

rem -----------------------------------------------------------------------
rem Filename:   badroles.sql
rem Purpose:    Database users with deadly roles assigned to them.
rem Date:       04-Nov-2001
rem Author:     Frank Naude, Oracle FAQ
rem -----------------------------------------------------------------------

set verify off

clear breaks
clear columns
clear computes


select grantee, granted_role, admin_option
from   sys.dba_role_privs 
where  granted_role in ('DBA', 'AQ_ADMINISTRATOR_ROLE',
                       'EXP_FULL_DATABASE', 'IMP_FULL_DATABASE',
                       'OEM_MONITOR')
  and  grantee not in ('SYS', 'SYSTEM', 'OUTLN', 'AQ_ADMINISTRATOR_ROLE',
                       'DBA', 'EXP_FULL_DATABASE', 'IMP_FULL_DATABASE',
                       'OEM_MONITOR', 'CTXSYS', 'DBSNMP', 'IFSSYS',
                       'IFSSYS$CM', 'MDSYS', 'ORDPLUGINS', 'ORDSYS',
                       'TIMESERIES_DBA')
/


