
--DESCRIBE: show synonyms that reference a database link

set verify off

clear columns
clear breaks
clear computes

col owner format a15
col synonym format a45
col db_link format a30

col "TABLE" format a50

select owner,
       synonym_name,
       table_owner || '.' || table_name "TABLE",
       db_link
from dba_synonyms
where db_link like upper('%&1%')
order by owner, synonym_name
/

undefine 1

