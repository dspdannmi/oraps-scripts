
--DESCRIBE: show the various statid values from the STATSTAB table

set verify off

clear breaks
clear computes

select distinct statid
from statstab
/

