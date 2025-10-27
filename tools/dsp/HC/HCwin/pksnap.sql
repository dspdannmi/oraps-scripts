REM ===========================================================================================
REM
REM  Notes:   This script calls the appropriate pksnap#.sql script.
REM
REM  Usage:   Login to sqlplus as sys or system
REM
REM ===========================================================================================


set echo        off
set feedback    off
set verify      off
set heading     off
set termout     off
set pause       off
set define      off
set timing      off

set trimspool   on

set pagesize    0
set linesize    500

ttitle off
btitle off

spool pksnap_main.sql
select '@pksnap'||substr(version,1,instr(version,'.')-1) 
from   v$instance;
spool off

@pksnap_main

exit
