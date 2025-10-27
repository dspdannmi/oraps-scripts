REM ===========================================================================================
REM
REM
REM ===========================================================================================

set termout on
prompt Retrieving Database Options...
set termout off

spool output/options.htm
prompt <HTML>
prompt <HEAD>
prompt <META HTTP-EQUIV="Expires" CONTENT="Mon, 06 Jan 1990 00:00:01 GMT">
prompt <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
prompt </HEAD>
prompt <BODY>
prompt <CENTER><FONT FACE="Arial" SIZE="2">
prompt <TABLE WIDTH="100%">
prompt <TR>
select '<TD><B><FONT FACE="Arial" SIZE="2"><A HREF="options.htm" TARGET="_blank">'||SYSDATE||'</A></FONT></B></TD>' from dual;
select '<TD ALIGN="RIGHT"><B><FONT FACE="Arial" SIZE="2">'||name||'</FONT></B></TD>' from sys.v_$database;
prompt </TR>
prompt </TABLE><BR>
prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=5>
prompt  <FONT SIZE="4"><B>Database Options</B></FONT>
prompt  </TD>
prompt </TR>
prompt <TR>
prompt 	<TD BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="2"><B>Option (1)</B></FONT></TD>
prompt 	<TD BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>Value</B></FONT></TD>
prompt </TR>
select '<TR>
	<TD><FONT FACE="Arial" SIZE="2">'||initcap(parameter)||'</FONT></TD>
	<TD><FONT FACE="Arial" SIZE="2">'||value||'</FONT></TD>
	</TR>'
from 	sys.v_$option;
prompt </TABLE><BR>
prompt </FONT></CENTER>
prompt </BODY></HTML>
spool off

