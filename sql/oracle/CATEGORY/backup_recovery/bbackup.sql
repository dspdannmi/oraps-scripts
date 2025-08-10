set pages 0
set lines 132

--DESCRIBE: place all tablespaces of a database in backup mode

set echo off
set termout off
set feedback off
set verify off

spool /tmp/bbackup.sql

select 'alter tablespace ' || tablespace_name || ' begin backup;'
from dba_tablespaces
where contents != 'TEMPORARY'
order by tablespace_name
/
spool off


set echo on
set termout on
set feedback on

alter system switch logfile;

set echo off

@ login.sql

@ /tmp/bbackup.sql
!rm -f /tmp/bbackup.sql /tmp/bbackup2.sql

@ backupstatus

