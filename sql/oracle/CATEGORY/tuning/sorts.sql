
--DESCRIBE: show session sort information

set verify off

clear breaks
clear computes

select si.sid,
       u.username,
       u.tablespace,
       u.segtype,
       count(u.extents),
       sum(u.blocks)
from v$sort_usage u,
     v$session si
where u.session_addr = si.saddr
group by si.sid, u.username, u.tablespace, u.segtype
order by si.sid
/

