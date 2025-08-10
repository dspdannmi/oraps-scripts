
--DESCRIBE: show ddl for object using dbms_metadata.get_ddl procedure

col "DDL" format a130 wrap on


select dbms_metadata.get_ddl(upper('&object_type'),
                             upper('&object_name'), 
                             decode('&&schema', '', user, upper('&&schema')))  "DDL"
from dual
/

undefine object_type
undefine object_name
