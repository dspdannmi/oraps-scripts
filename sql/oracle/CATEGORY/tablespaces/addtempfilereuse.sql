
--DESCRIBE: add tempfile reuse to existing temporary tablepaces X=needs updating

set verify off

clear breaks
clear columns
clear computes

alter tablespace &1 add tempfile '&2' reuse;

undefine 1
undefine 2

