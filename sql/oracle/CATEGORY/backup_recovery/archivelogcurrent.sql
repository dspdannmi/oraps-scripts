
--DESCRIBE: archive the current redo log

set verify off

clear breaks
clear computes

alter system archive log current;

