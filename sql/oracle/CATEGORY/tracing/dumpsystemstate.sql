
--DESCRIBE: dump system state

set verify off

clear breaks
clear columns
clear computes


prompt
prompt This will error if max_dump_file_size is set too low
prompt This will no affect the operation of the database
prompt
prompt Press enter to continue
accept userinput

alter session set events 'immediate trace name systemstate level 8';

undefine 1

