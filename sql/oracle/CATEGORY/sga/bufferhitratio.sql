
--DESCRIBE: show buffer hitratio

set verify off

clear breaks
clear computes

rem -----------------------------------------------------------------------
rem Filename:   bufhitra.sql
rem Purpose:    Measure the Buffer Cache Hit Ratio 
rem             Increase DB_BLOCK_BUFFER if cache hit ratio < 90%
rem Date:       30-May-2002
rem Author:     Anonymous
rem -----------------------------------------------------------------------

select 1-(phy.value / (cur.value + con.value)) "Cache Hit Ratio",
round((1-(phy.value / (cur.value + con.value)))*100,2)  "% Ratio"
from v$sysstat cur, v$sysstat con, v$sysstat phy
where cur.name = 'db block gets' and
      con.name = 'consistent gets' and
      phy.name = 'physical reads' 
/

