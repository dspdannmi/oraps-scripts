
--DESCRIBE: show basic info about triggers from dba_triggers

set verify off

clear columns
clear breaks
clear computes


col "TABLE" format a35
col "TRIGGER" format a45
col trigger_name format a35
col trigger_type format a20
col triggering_event format a20

break on "TABLE" skip 1

select table_owner || '.' || table_name "TABLE",
       owner || '.' || trigger_name "TRIGGER",
       trigger_type,
       triggering_event,
       status
from dba_triggers
where table_owner || '.' || table_name like upper('%&&1%')
   or owner || '.' || trigger_name like upper('%&&1%')
order by table_owner, table_name, owner, trigger_name
/

undefine 1

