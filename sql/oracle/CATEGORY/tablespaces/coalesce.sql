
--DESCRIBE: coalesces a tablespace

set verify off

clear breaks
clear computes

alter tablespace &1 coalesce;

undefine 1


