

--DESCRIBE: show transaction info for a sid

set verify off

clear breaks
clear computes

col used_urec format 9999999999999
col name format a30

set verify off

define sid = &1

select *
from v$transaction
where addr = (select taddr
              from v$session
              where sid = &&sid)
/

prompt

select sid, 
       username, 
       xidusn,
       segment_name,
       used_urec,
       used_ublk
from v$transaction t, v$session s, dba_rollback_segs rs
where s.taddr = t.addr
  and xidusn = rs.segment_id
  and s.sid=&&sid
/


undefine sid
undefine 1
