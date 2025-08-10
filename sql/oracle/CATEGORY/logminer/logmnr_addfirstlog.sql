
--DESCRIBE: help script to add first logfile to LogMiner

prompt Add first logfile to log miner
prompt

accept logfile char prompt "Enter first logfile: "
prompt

BEGIN
    dbms_logmnr.add_logfile(Options=>dbms_logmnr.new,
			    LogFileName=>'&logfile');
END;
/

undefine logfile

