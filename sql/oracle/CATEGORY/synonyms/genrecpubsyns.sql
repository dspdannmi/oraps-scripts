
--DESCRIBE: recreate public synonyms

set verify off

clear breaks

col owner format a15
col synonym format a45
col db_link format a30

col "TABLE" format a50

select 'create or replace public synonym ' || synonym_name || ' for ' || decode(table_owner, null, '', table_owner || '.') || table_name || decode(db_link, null, '', '@' || db_link) || ';'
from dba_synonyms
where owner = 'PUBLIC'
  and (table_owner like upper('%&&1%') or table_name like upper('%&&1%'))
/

undefine 1

