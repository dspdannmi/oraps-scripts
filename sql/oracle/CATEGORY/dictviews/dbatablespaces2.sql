
--DESCRIBE: show all info about tablespaces from dba_tablespaces

set verify off

clear breaks
clear computes

col tablespace_name format a18
col initial_extent heading "INITIAL" format 9999999999
col next_extent heading "NEXT" format 9999999999
col min_extents heading "MIN" format 99999999
col max_extents heading "MAX" format 9999999999
col min_extlen heading "MIN_EXTLEN" format 9999999999
col "Next (Mb)" format 999999999.99
col "MIN/MAX" format a14
col pct_increase heading "PCTI" format 999


select *
from dba_tablespaces
where tablespace_name like upper('%&&1%')
order by tablespace_name
/

undefine 1

