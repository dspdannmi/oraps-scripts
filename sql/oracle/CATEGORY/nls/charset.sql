
--DESCRIBE: show database characterset info from NLS_DATABASE_PARAMETERS

set verify off

col parameter format a26
col value format a18

select parameter, value
from nls_database_parameters
where parameter in ('NLS_CHARACTERSET', 'NLS_NCHAR_CHARACTERSET')
order by 1;


