
--DESCRIBE: help script to start LogMiner at the specified date/time

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

accept starttime char prompt "Start time: "
accept endtime char prompt "End time: "
prompt
accept filename char prompt "Enter dictionary filename: "


BEGIN
  dbms_logmnr.start_logmnr(DictFileName=>'&filename',
		           StartTime=>TO_DATE('&starttime','DD-MON-RRRR HH:MI:SS'),
			   EndTime=>TO_DATE('&endtime','DD-MON-RRRR HH:MI:SS'));
END;
/

undefine startscn
undefine endscn
undefine starttime
undefine endtime
undefine filename
