
--DESCRIBE: enables system trace at various levels

prompt ALTER SYSTEM SET EVENTS '10046 trace name context off';
prompt
prompt  Level   Description
prompt  0       Disabled
prompt  1       Same as ALTER SESSION SET sql_trace = TRUE 
prompt  4       Include bind information
prompt  8       Include event wait statistics
prompt  12      Include bind information and event wait statistics
prompt
prompt


ALTER SYSTEM SET EVENTS '10046 trace name context forever, level &level';

undefine level
