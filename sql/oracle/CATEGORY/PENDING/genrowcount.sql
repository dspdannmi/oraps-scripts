select 'select ''' || owner || '.' || table_name || ':'' || count(*) from ' || owner || '.' || table_name || ';'
from dba_tables
where owner != 'SYS'
order by owner, table_name
/
