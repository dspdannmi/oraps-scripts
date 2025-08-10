select t1.sid, t2.value-t1.value
from t1, t2, v$statname sn
where t1.sid=t2.sid
  and t1.statistic# = t2.statistic#
  and t1.statistic# = sn.statistic#
  and sn.name = 'redo size'
order by 2
/
