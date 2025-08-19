
--DESCRIBE: show enqueue waits from v$session_wait

set verify off

clear breaks

select chr(bitand(p1,-16777216)/16777215)||
       chr(bitand(p1, 16711680)/65535) "Lock",
       to_char( bitand(p1, 65535) )    "Mode"
from v$session_wait
where event = 'enqueue'
/

