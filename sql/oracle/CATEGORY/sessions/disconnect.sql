
--DESCRIBE: disconnect a session after its transaction is completed

set verify off

clear breaks


alter system disconnect session '&sid, &serial' post_transaction;

undefine sid
undefine serial

