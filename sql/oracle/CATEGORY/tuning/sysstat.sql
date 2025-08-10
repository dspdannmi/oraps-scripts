
--DESCRIBE: show system stats 

set verify off

clear breaks
clear columns
clear computes

col sid format 999999

select sn.name, 
       st.value
from v$sysstat st, 
     v$statname sn
where st.statistic# = sn.statistic#
  and upper(sn.name) like upper('%&&1%')
order by sn.name
/

undefine 1

