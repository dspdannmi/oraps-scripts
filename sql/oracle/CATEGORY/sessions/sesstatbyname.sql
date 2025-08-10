
--DESCRIBE: show session stats based on statname

set verify off

clear breaks
clear columns
clear computes

col sid format 999999

select sid, 
       sn.name, 
       st.value
from v$sesstat st, 
     v$statname sn
where st.statistic# = sn.statistic#
  and sid = &&1
  and upper(sn.name) like upper('%&&2%')
order by sn.name
/

undefine 1
undefine 2

