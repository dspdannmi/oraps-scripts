
--DESCRIBE: automatic recover database using backup controlfile until cancel

set verify off

clear breaks
clear columns
clear computes

recover automatic database using backup controlfile until cancel;
