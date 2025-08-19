
--DESCRIBE: display info from user_errors

set verify off

clear breaks
clear computes

set serveroutput on size 50000

@ printtbl 'select * from user_errors'

undefine 1

