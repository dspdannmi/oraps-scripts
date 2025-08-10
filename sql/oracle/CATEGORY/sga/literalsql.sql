

--DESCRIBE: show literal sql

rem 
rem Metalink DocID 62143.1
rem

rem  Finding literal SQL
rem

set verify off

clear breaks
clear columns
clear computes

col "SQL" format a40
col "COUNT" format 9999999999
col "TOT_EXECS" format 9999999999

select substr(sql_text,1,40) "SQL", 
       count(*) "COUNT", 
       sum(executions) "TOT_EXECS"
from v$sqlarea
where executions < 5
group by substr(sql_text,1,40)
having count(*) > 30
order by 2
/

