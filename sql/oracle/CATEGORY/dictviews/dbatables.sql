
--DESCRIBE: show basic info about tables from dba_tables

set verify off

clear breaks
clear columns
clear computes

col "TABLE" format a50

col tablespace_name format a24
col pct_free heading "PCTFREE" format 999
col pct_used heading "PCTUSED" format 999
col ini_trans heading "INITRANS" format 999999
col max_trans heading "MAX_TRANS" format 999999
col freelists heading "FREELISTS" format 9999
col freelist_groups heading "FLIST_GROUPS" format 9999

select owner || '.' || table_name "TABLE", 
       tablespace_name,
       pct_free,
       pct_used,
       ini_trans,
       max_trans,
       freelists,
       freelist_groups
from dba_tables
where owner || '.' || table_name like upper('%&1%')
order by owner, table_name
/

undefine 1

