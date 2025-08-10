
--DESCRIBE: take all tablespaces out of backup mode 

set pages 0
set lines 132

set echo off
set termout off
set feedback off
set verify off

spool /tmp/ebackup.sql

select 'alter tablespace ' || tablespace_name || ' end backup;'
from dba_tablespaces
where contents != 'TEMPORARY'
order by tablespace_name
/
spool off


set echo on
set termout on
set feedback on


set echo off

@ login.sql

@ /tmp/ebackup.sql

set echo on

alter system switch logfile;

set echo off

@ login.sql

!rm -f /tmp/ebackup.sql

@ backupstatus

