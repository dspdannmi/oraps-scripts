
--DESCRIBE: list grantees and granted privs for superuser-type system privs

rem -----------------------------------------------------------------------
rem Filename:   badsysprivs.sql
rem Purpose:    Database users with deadly system privilages assigned to 
rem             them.
rem Date:       04-Nov-2001
rem Author:     Frank Naude, Oracle FAQ
rem -----------------------------------------------------------------------

set verify off

clear breaks
clear computes

select grantee, privilege, admin_option
from   sys.dba_sys_privs 
where  (privilege like '% ANY %'
  or   privilege in ('BECOME USER', 'UNLIMITED TABLESPACE')
  or   admin_option = 'YES')
 and   grantee not in ('SYS', 'SYSTEM', 'OUTLN', 'AQ_ADMINISTRATOR_ROLE',
                       'DBA', 'EXP_FULL_DATABASE', 'IMP_FULL_DATABASE',
                       'OEM_MONITOR', 'CTXSYS', 'DBSNMP', 'IFSSYS',
                       'IFSSYS$CM', 'MDSYS', 'ORDPLUGINS', 'ORDSYS',
                       'TIMESERIES_DBA')
/

