

--DESCRIBE: show high version counts perhaps indicating lack of bind variables

set verify off

clear breaks

rem 
rem Metalink DocID 62143.1
rem

rem Versions occur when two or more SQL statements have identical text but underlying
rem objects or binds are different


select address, hash_value,
		version_count ,
        	users_opening ,
        	users_executing
		sql_text
from v$sqlarea
where version_count > 10
/


