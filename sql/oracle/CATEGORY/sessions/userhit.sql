
--DESCRIBE: show the hit-ratio for a given session

set verify off

clear breaks
clear computes

col "HIT RATIO" format 0.99

select io.sid, 
       se.username, 
       decode(block_gets+consistent_gets, 0, 0, 1-(physical_reads/(block_gets+consistent_gets))) "HIT RATIO"
from v$sess_io io,
     v$session se
where se.username is not null
  and io.sid = se.sid
  and io.sid like '%&&1%'
order by se.sid
/

undefine 1


