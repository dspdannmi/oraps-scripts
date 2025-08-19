
--DESCRIBE: show statements that are using a large percentage of shared pool

set verify off

clear breaks

rem 
rem Metalink DocID 62143.1
rem

rem Find statements that are usuing a large percentage of the shared pool


select substr(sql_text,1,80) "Stmt", count(*),
       sum(sharable_mem)    "Mem",
       sum(users_opening)   "Open",
       sum(executions)      "Exec"
from v$sql
group by substr(sql_text,1,80)
having sum(sharable_mem) > (select 0.10 * to_number(value) 
			    from v$parameter 
			    where name = 'shared_pool_size')
/


