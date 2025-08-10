
--DESCRIBE: show all from dba_synonyms

set verify off

clear breaks
clear columns
clear computes

col db_link format a15

select *
from dba_synonyms
where synonym_name like upper('%&&1%')
  or owner like upper('%&&1%')
order by owner, synonym_name
/

undefine 1

