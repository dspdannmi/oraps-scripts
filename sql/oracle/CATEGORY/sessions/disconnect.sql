
--DESCRIBE: disconnect a session after its transaction is completed

set verify off

clear columns
clear breaks
clear computes


alter system disconnect session '&sid, &serial' post_transaction;

undefine sid
undefine serial

