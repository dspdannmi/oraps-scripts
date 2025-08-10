
--DESCRIBE: show sessions waiting/holding on library cache pin (sysdba from 9i up)

set verify off

clear breaks
clear columns
clear computes

select s.sid, 
       kglpnmod "MODE", 
       kglpnreq "REQ"
from x$kglpn p, 
     v$session s
where p.kglpnuse=s.saddr
  and kglpnhdl='&P1RAW'
/

