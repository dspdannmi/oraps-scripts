
--DESCRIBE: show redo size statistics for current session

set verify off

clear breaks
clear computes

col sid format 999999
col name format a14
col value format 9999999999999999999999999999


select sid,
       sn.name,
       st.value
from v$mystat st,
     v$statname sn
where st.statistic# = sn.statistic#
  and sn.name = 'redo size'
order by 3
/


undefine 1

