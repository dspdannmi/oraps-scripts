
--DESCRIBE: enables tracing for the current sid at highest level 12

set verify off

clear breaks
clear computes

alter session set events '10046 trace name context forever, level 12';


