
--DESCRIBE: archive the current redo log

set verify off

clear breaks
clear columns
clear computes

alter system archive log current;

