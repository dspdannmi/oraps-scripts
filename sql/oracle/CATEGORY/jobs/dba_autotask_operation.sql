
--DESCRIBE: show contents of dba_autotask_operation

set verify off

clear breaks
clear computes


col client_name format a40
col operation_name format a30
col operation_tag format a10 heading "Operation|Tag"
col priority_override format a9 heading "Priority|Override"
col attributes format a70
col use_resource_estimates format a12 heading "Use Resource|Estimates"
col status format a8
col last_change format a38

select client_name, operation_name, operation_tag, priority_override, attributes, use_resource_estimates, status, last_change 
from dba_autotask_operation;

