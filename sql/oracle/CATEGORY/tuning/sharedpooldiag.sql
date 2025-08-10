
--DESCRIBE: various diagnostic SQL for shared pool

REM 
REM From  62143.1
REM 
REM Useful SQL for looking at Shared Pool problems
REM 
REM This section shows some example SQL that can be used to help find 
REM potential issues in the shared pool. The output of these statements 
REM should be spooled to a file.
REM 
REM NOTE: These statements may add to existing latch contention as 
REM       described in "Using V$ Views (V$SQL and V$SQLAREA)" above.
REM  
REM 
prompt
prompt Finding literal SQL
prompt

SELECT substr(sql_text,1,40) "SQL", 
       count(*) , 
       sum(executions) "TotExecs"
FROM v$sqlarea
WHERE executions < 5
GROUP BY substr(sql_text,1,40)
HAVING count(*) > 30
ORDER BY 2;

REM This helps find commonly used literal SQL - See "Eliminating Literal SQL" above.
REM Another way you might find these is to use the "plan_hash_value" column to group the examples ie:

prompt
prompt Finding literal SQL by plan_hash_value
prompt

SELECT substr(sql_text,1,40) "SQL", plan_hash_value,
       count(*) ,
       sum(executions) "TotExecs"
FROM v$sqlarea
WHERE executions < 5
GROUP BY plan_hash_value,  substr(sql_text,1,40)
HAVING count(*) > 30
ORDER BY 2;

prompt
prompt Finding the Library Cache hit ratio
prompt

SELECT SUM(PINS) "EXECUTIONS",
SUM(RELOADS) "CACHE MISSES WHILE EXECUTING"
FROM V$LIBRARYCACHE;

REM If the ratio of misses to executions is more than 1%, then try to reduce the library cache misses
REM Checking hash chain lengths:

SELECT hash_value, count(*)
FROM v$sqlarea 
GROUP BY hash_value
HAVING count(*) > 5
        ;
prompt  This should usually return no rows. If there are any HASH_VALUES with high counts 
prompt (double figures) then you may be seeing the effects of a bug, or an unusual form of 
prompt literal SQL statement. It is advisable to drill down and list out all the statements 
prompt mapping to the same HASH_VALUE. Eg:

SELECT sql_text 
FROM v$sqlarea 
WHERE hash_value= &example_hash_value;

prompt  and if these look the same get the full statements from V$SQLTEXT. It is possible 
prompt for many literals to map to the same hash value. Eg:In 7.3 two statements may 
prompt have the same hash value if a literal value occurs twice in the statement and there 
prompt are exactly 32 characters between the occurrences.
prompt
prompt Checking for high version counts:

SELECT address, 
       hash_value, 
       version_count ,
       users_opening ,
       users_executing,
       substr(sql_text,1,40) "SQL"
FROM v$sqlarea
WHERE version_count > 10;

prompt "Versions" of a statement occur where the SQL is character for character identical 
prompt but the underlying objects or binds etc.. are different as described in "Sharable SQL" 
prompt above. High version counts can occur in various Oracle8i releases due to problems 
prompt with progression monitoring. This can be disabled by setting SQLEXEC_PROGRESSION_COST 
prompt to '0' as described earlier in this note.
prompt
prompt Finding statement/s which use lots of shared pool memory:
prompt
prompt where MEMSIZE is about 10% of the shared pool size in bytes. This should show if there 
prompt are similar literal statements, or multiple versions of a statements which account 
prompt for a large portion of the  memory in the shared pool.

SELECT substr(sql_text,1,40) "Stmt", count(*),
       sum(sharable_mem)    "Mem",
       sum(users_opening)   "Open",
       sum(executions)      "Exec"
 FROM v$sql
GROUP BY substr(sql_text,1,40)
HAVING sum(sharable_mem) > &MEMSIZE;


prompt
prompt Allocations causing shared pool memory to be 'aged' out
prompt

SELECT * 
FROM x$ksmlru
WHERE ksmlrnum>0;

prompt  
prompt NOTE: This select returns no more than 10 rows and then erases the contents of the 
prompt X$KSMLRU table so be sure to SPOOL the output. The X$KSMLRU table shows which memory 
prompt allocations have caused the MOST memory chunks to be thrown out of the shared pool 
prompt since it was last queried. This is sometimes useful to help identify sessions or 
prompt statements which are continually causing space to be requested. If a system is well 
prompt behaved and uses well shared SQL, but occasionally slows down this select can help 
prompt identify the cause. Refer to Document 43600.1 for more information on X$KSMLRU.
prompt  
