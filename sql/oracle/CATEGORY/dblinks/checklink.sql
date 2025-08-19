
--DESCRIBE: check connectivity of database link 

set verify off

clear breaks
clear computes

break on "OWNER" skip 1

col status heading "STATUS" format a8


select 'SUCCESS' status
from dual@&&1
/

undefine 1
