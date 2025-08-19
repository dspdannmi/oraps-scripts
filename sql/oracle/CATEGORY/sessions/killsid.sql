
--DESCRIBE: terminates session with sid and serial#

set verify off

clear breaks

alter system kill session '&&1, &&2'
/

undefine 1
undefine 2



