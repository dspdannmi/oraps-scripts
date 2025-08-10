
--DESCRIBE: help script to start LogMiner at specified SCN

rem  
rem  
rem  Parameters of "dbms_logmnr.start_logmnr": 
rem  
rem  StartScn Default 0, 
rem  EndScn Default 0, 
rem  StartTime Default '01-Jan-1988', 
rem  EndTime Default '01-Jan-2988', 
rem  DictFileName Default '', 
rem  Options Default 0 (= a debug flag, not yet being used) 

prompt Date Format:  15-Jan-2000 08:00:00

accept startscn number prompt "Start SCN: "
accept endscn number prompt "End SCN: "
prompt
accept filename char prompt "Enter dictionary filename: "


BEGIN
  dbms_logmnr.start_logmnr(DictFileName=>'&filename',
			   StartScn=>&startscn,
			   EndScn=>&endscn);
END;
/

undefine startscn
undefine endscn
undefine starttime
undefine endtime
undefine filename
