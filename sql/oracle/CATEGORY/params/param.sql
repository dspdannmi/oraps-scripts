
--DESCRIBE: show info about initialization parameters


set verify off

clear breaks
clear columns
clear computes

col name format a35
col value format a25

select name,
       value,
       isdefault,
       isses_modifiable,
       issys_modifiable,
       ismodified,
       isadjusted
from v$parameter
where upper(name) like upper('%&&1%')
order by name
/

undefine 1
