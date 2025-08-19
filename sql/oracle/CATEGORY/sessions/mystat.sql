
--DESCRIBE: display session stats for current session

set verify off

clear breaks
clear computes

col sid format 999999
col name format a34
col value format 9999999999999999999999999999


select sn.statistic#,
       sn.name,
       st.value
from v$mystat st,
     v$statname sn
where st.statistic# = sn.statistic#
  and lower(sn.name) like '%&&1%'
order by sn.statistic#
/


undefine 1

