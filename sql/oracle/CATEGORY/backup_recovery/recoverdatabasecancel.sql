
--DESCRIBE: recover database using backup controlfile until cancel

set verify off

clear breaks
clear computes

recover database using backup controlfile until cancel;
