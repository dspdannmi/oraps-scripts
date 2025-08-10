
--DESCRIBE: show main info from dba_constraints

set verify off

clear breaks
clear columns
clear computes


col "TABLE" format a38
col constraint_name format a30
col table_name format a30
col r_owner format a15
col r_constraint_name format a30
col "REF_CONSTRAINT" format a34
col "DEL_RULE" format a10
col "DEF?" format a4



select owner || '.' || table_name "TABLE",
       constraint_name,
       constraint_type,
       decode(r_owner, null, '', r_owner || '.' || r_constraint_name) "REF_CONSTRAINT",
       delete_rule "DEL_RULE",
       decode(status, 'ENABLED', 'Y', 'N') status, 
       decode(deferrable, 'DEFERRABLE', 'Y', 'N') "DEF?",
       decode(deferred, 'DEFERRED', 'Yes', 'IMMEDIATE', 'Imm', '???') deferred,
       decode(validated, 'VALIDATED', 'Y', 'N') "Val?",
       decode(generated, 'GENERATED NAME', 'Y', 'N') "GenName?",
       bad,
       rely
from dba_constraints
where owner || '.' || constraint_name like upper('&&1')
order by 1
/

undefine 1

