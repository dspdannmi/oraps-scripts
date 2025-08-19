
--DESCRIBE: show datablock wait information

set verify off

clear breaks
clear computes

col name format a50

select name, count
from x$kcbfwait, v$datafile
where indx + 1 = file#;

