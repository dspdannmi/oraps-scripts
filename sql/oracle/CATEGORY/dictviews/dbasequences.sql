
--DESCRIBE: show basic info about database sequences

set verify off

clear breaks
clear computes

col sequence heading "SEQUENCE" format a45
col min_value heading "MIN" format 9999999999
col max_value heading "MAX" format 999999999999999999999999999999
col increment_by heading "INC" format 999999
col cycle_flag heading "CYCLE" format a7
col order_flag heading "ORDER" format a7
col cache_size heading "CACHE SIZE" format 999999999
col last_number heading "LAST"
col value heading "MIN/MAX" format a38

select sequence_owner || '.' || sequence_name sequence,
       min_value || '/' || max_value value,
       increment_by,
       cycle_flag,
       order_flag,
       cache_size,
       last_number
from dba_sequences
where sequence_owner || '.' || sequence_name like upper('%&&1%')
order by sequence_owner, sequence_name
/

undefine 1
