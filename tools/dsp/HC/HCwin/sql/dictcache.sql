REM ===========================================================================================
REM
REM
REM ===========================================================================================

set termout on
prompt Retrieving Data Dictionary Cache Performance...
set termout off

spool output/dictcache.htm
prompt <HTML>
prompt <HEAD>
prompt <META HTTP-EQUIV="Expires" CONTENT="Mon, 06 Jan 1990 00:00:01 GMT">
prompt <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
prompt </HEAD>
prompt <BODY>
prompt <CENTER><FONT FACE="Arial" SIZE="2">
prompt <TABLE WIDTH="100%">
prompt <TR>
select '<TD><B><FONT FACE="Arial" SIZE="2"><A HREF="dictcache.htm" TARGET="_blank">'||SYSDATE||'</A></FONT></B></TD>' from dual;
select '<TD ALIGN="RIGHT"><B><FONT FACE="Arial" SIZE="2">'||name||'</FONT></B></TD>' from sys.v_$database;
prompt </TR>
prompt </TABLE><BR>
prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=6>
prompt  <FONT SIZE="4"><B>Data Dictionary Cache Statistics</B></FONT>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Parameter</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Gets</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>GetMisses</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="2"><B>% Cache Misses (1)</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Count</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Usage</B></FONT></TD>
prompt </TR>
select '<TR>
	<TD><FONT FACE="Arial" SIZE="2">'||parameter||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||to_char(gets,'999G999G999G999G999')||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||to_char(getmisses,'999G999G999G999G999')||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||to_char(round(getmisses/gets,2)*100,'990.90')||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||to_char(count,'999G999G999G999G999')||'</FONT></TD>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||to_char(usage,'999G999G999G999G999')||'</FONT></TD>
	</TR>' 
from 	sys.v_$rowcache
where 	gets > 0
order 	by (getmisses/gets)*100 desc;
prompt </TABLE><BR>
prompt </FONT></CENTER>
prompt </BODY></HTML>
spool off

