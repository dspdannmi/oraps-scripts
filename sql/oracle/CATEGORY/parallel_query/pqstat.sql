

--DESCRIBE: creates procedure to view current status of parallel SQL

rem 
rem  Seems to work on 9i as well
rem

rem  Script Name:	PQSTAT.SQL 
rem  Oracle Versions:	Oracle 7.3 and 8.0.3 
rem                     The script will NOT work in 7.2 or earlier. 
rem  Author:		RPOWELL.UK 
rem  Purpose:		This script creates a simple procedure to view the 
rem			current status of single instance parallel SQL. 
rem 			The script can easily be modified to collect extra 
rem			information. At present it reports on wait states and 
rem			physical IO and CPU for each session. This helps  
rem			identify busy and idle sessions in a PQ operation. 
rem  Installation:	To install the script CONNECT as SYS in Server Manager 
rem  Usage:		set serveroutput on 
rem  			execute pqstat;	  -- Gives Summary of all PQ sessions 
rem					     and slaves running. 
rem			execute pqstat(1); -- Gives the current SQL for each 
rem					     PQ session also. 
rem			execute pqstat(0, SID ); 
rem					  -- Gives the summary of PQ slaves 
rem					     for the given SID 
rem			execute pqstat(1, SID ); 
rem					  -- as above plus current SQL . 
rem 
rem 
Create or Replace Procedure PqStat( detail number := 0, forsid number:=0 ) is 
  -- 
  SepLine varchar2(80) := '-------------------------------'; 
  nqueries number := 0; 
  doprint  boolean; 
  -- 
  -- Get Query Coordinators or a specific one (by SID)  
  -- 
  Cursor QCcursor( insid number ) is 
    select distinct KXFPDPCPR , qc.SID 
      from X$KXFPDP qs, V$SESSION qc  
     where KXFPDPCPR!=hextoraw('0') 
       and KXFPDPPRO!=hextoraw('0') 
       and bitand(KXFPDPFLG,16)=0 /* Slave not Idle */ 
       and qc.paddr=qs.KXFPDPCPR 
       and (insid=0 or qc.sid=insid) 
  ; 
  -- 
  -- Get all local Query Slaves for a given QC 
  -- 
  Cursor QScursor( creator raw ) is 
    select KXFPDPNAM, qs.KXFPDPPRO 
      from X$KXFPDP qs 
     where qs.KXFPDPCPR=creator 
       and KXFPDPPRO!=hextoraw('0') 
  ; 
  -- 
  -- Show Useful Stats for a session (CPU + Physical IO) 
  -- 
  Procedure ShowPhys(prefix varchar2, insid number ) is 
    Cursor IOcursor is 
      select n.name, v.value 
        from v$sesstat v, v$statname n 
       where (n.name like 'physical%'  or n.name like 'CPU used by this%') 
	 and v.statistic#=n.statistic# 
    	 and v.sid=insid 
    ; 
    i number:=0; 
  Begin 
    For IO in IOcursor  
    Loop 
      dbms_output.put(prefix||IO.name||'='||IO.value); 
      i:=i+1; 
    End Loop; 
    dbms_output.put_line(' '); 
  End; 
  -- 
  -- Show wait status of given session 
  -- 
  Procedure ShowWait(prefix varchar2, insid number ) is 
    WaitInfo VarChar2(20); 
    Cursor SWcursor is 
      select * 
        from v$session_wait 
       where sid=insid 
    ; 
    Cursor DQcursor(dqcode number) is 
      select indx||'='||reason from X$KXFPSDS where indx=dqcode 
    ; 
  Begin 
    For SW in SWcursor  
    Loop 
      if (SW.event='parallel query dequeue wait') then 
         open DQcursor( SW.p1 ); 
         fetch DQcursor into SW.event; 
         SW.p1text:=null; 
         SW.p1:=null; 
  	 close DQcursor; 
      end if; 
      if (SW.wait_time=0) then 
        dbms_output.put_line(prefix|| 
		'WAITING '||SW.seconds_in_wait||'s for "'|| 
		SW.event||'" '|| 
		SW.p1text||'='||SW.p1||' '|| 
		SW.p2text||'='||SW.p2||' '|| 
		SW.p3text||'='||SW.p3); 
      else  
        dbms_output.put_line(prefix||'RUNNING (wait seq#='||SW.seq#||')'); 
      end if; 
    End Loop; 
  End; 
  -- 
  -- Show current SQL statement for the given session 
  -- 
  Procedure ShowSQL(prefix varchar2, addr raw, hash number ) is 
    Cursor SQLcursor is 
      select sql_text  
        from v$sqltext  
       where address=addr and hash_value=hash 
      order by piece; 
  Begin 
    dbms_output.put_line(' '); 
    For SQ in SQLcursor  
    Loop 
      dbms_output.put_line(prefix||SQ.sql_text); 
    End Loop; 
    dbms_output.put_line(' '); 
  End; 
  -- 
  Procedure ShowSid(prefix varchar2, inpaddr raw ) is 
    Cursor SIDcursor is 
      select s.sid, spid, pid, c.terminal, s.process, osuser ,  
		s.username username, s.machine, 
		s.sql_address, s.sql_hash_value 
        from v$process c, v$session s 
       where c.addr=inpaddr 
	 and c.addr=s.paddr 
    ; 
  Begin 
    For SID in SIDcursor  
    Loop 
      dbms_output.put(prefix||' Sid='||SID.sid||' ServerPid='||SID.spid); 
      if (prefix='QC') then 
	dbms_output.put(' User='||SID.username|| 
         ' Client='||SID.process||' on '||SID.machine ); 
      end if; 
      dbms_output.put_line(' '); 
      ShowPhys('  ',SID.sid); 
      ShowWait('  ',SID.sid); 
      if (detail>0) then  
        ShowSQL('     ', SID.sql_address, SID.sql_hash_value); 
      end if; 
    End Loop; 
  End; 
  -- 
Begin 
  dbms_output.enable(1000000); 
  dbms_output.put('Parallel Queries Running'); 
  if (forsid!=0) then 
    dbms_output.put(' for QC SID='||forsid); 
  end if; 
  dbms_output.put_line(' '); 
  For QC in QCcursor( forsid ) 
  Loop 
    doprint:=TRUE; 
    For QS in QScursor( QC.kxfpdpcpr ) 
    Loop 
      If DoPrint Then 
    	nqueries:=nqueries+1; 
    	dbms_output.put_line(SepLine); 
	ShowSid('QC',QC.kxfpdpcpr ); 
	DoPrint:=FALSE; 
      End If; 
      ShowSid(QS.kxfpdpnam,QS.kxfpdppro); 
    End Loop; 
  End Loop; 
  dbms_output.put_line(SepLine); 
  dbms_output.put_line(nqueries||' Parallel Queries Found'); 
End; 
