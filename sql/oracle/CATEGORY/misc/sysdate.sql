
--DESCRIBE: show current time from sysdate

set verify off

clear breaks
clear computes

col "SYSDATE" format a20

select to_char(sysdate, 'HH24:MI:SS DD-MON-YYYY') "SYSDATE"
from dual;

undefine 1

