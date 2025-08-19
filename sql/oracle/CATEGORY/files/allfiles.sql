
--DESCRIBE: list all filenames from v$controlfile, v$logfile and v$datafile

set verify off

clear breaks
clear computes

col type format a14
col name format a60

break on type skip 1

select name, 'CONTROLFILE' "TYPE" 
from v$controlfile
union
select member, 'REDOLOG' "TYPE" 
from v$logfile
union
select name, 'DATAFILE' "TYPE" 
from v$datafile
order by 2
/

