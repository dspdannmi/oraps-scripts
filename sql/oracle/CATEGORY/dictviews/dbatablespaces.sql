
--DESCRIBE: show basic info about tablespaces

set verify off

clear breaks
clear columns
clear computes

col tablespace_name format a18
col "Initial (Kb)" format 999999999.99
col "Next (Kb)" format 999999999.99
col "MIN/MAX" format a14
col pct_increase heading "PCTI" format 9999

select tablespace_name,
       initial_extent/1024 "INITIAL(Kb)", 
       next_extent/1024 "NEXT(Kb)", 
       min_extents || '/' ||  max_extents "MIN/MAX", 
       pct_increase,
       status, 
       contents
from dba_tablespaces
where tablespace_name like upper('%&&1%')
order by tablespace_name
/

undefine 1

