
--DESCRIBE: help script to add additional logfile to LogMiner

prompt Add other logfile to log miner
prompt

accept logfile char prompt "Enter other logfile: "
prompt

BEGIN
    dbms_logmnr.add_logfile(Options=>dbms_logmnr.addfile,
			    LogFileName=>'&logfile');
END;
/

undefine logfile

