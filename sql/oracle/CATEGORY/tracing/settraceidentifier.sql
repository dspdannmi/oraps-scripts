
--DESCRIBE: set tracefile identifier to help identify tracefiles on the server

set verify off

clear breaks
clear computes

alter session set tracefile_identifier='&&1';

undefine 1
