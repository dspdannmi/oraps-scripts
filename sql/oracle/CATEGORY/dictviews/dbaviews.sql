
--DESCRIBE: show all info about views from dba_views


set verify off

clear breaks
clear computes

select * 
from dba_views
where owner || '.' || view_name like upper('%&&1%')
order by owner, view_name
/

undefine 1

