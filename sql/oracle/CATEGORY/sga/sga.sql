
--DESCRIBE: show info about the shared pool objects

set verify off

clear columns
clear breaks
clear computes

column owner format a14
column name format a30
column type format a20
col namespace format a20
col executions format 9999999999
col kept format a4


select owner ,
       name ,
       type ,
       namespace ,
       pins "USERS PINNING" ,
       loads "TIMES LOADED",
       executions ,
       kept
from v$db_object_cache
order by loads, executions, owner, name
/

