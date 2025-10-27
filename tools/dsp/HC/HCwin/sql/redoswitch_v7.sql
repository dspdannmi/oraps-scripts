REM ===========================================================================================
REM
REM ===========================================================================================

set termout on
prompt Retrieving Redo Log Switch History...
set termout off
spool output/redoswitch.htm

prompt <HTML>
prompt <HEAD>
prompt <META HTTP-EQUIV="Expires" CONTENT="Mon, 06 Jan 1990 00:00:01 GMT">
prompt <META HTTP-EQUIV="Pragma" CONTENT="no-cache">
prompt </HEAD>
prompt <BODY>
prompt <CENTER><FONT FACE="Arial" SIZE="2">
prompt <TABLE WIDTH="100%">
prompt <TR>
select '<TD><B><FONT FACE="Arial" SIZE="2">'||SYSDATE||'</FONT></B></TD>' from dual;
select '<TD ALIGN="RIGHT"><B><FONT FACE="Arial" SIZE="2">'||name||'</FONT></B></TD>' from sys.v_$database;
prompt </TR>
prompt </TABLE><BR>
prompt <TABLE BORDER=1 CELLPADDING=5>
prompt <TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#FFFFFF" COLSPAN=25>
prompt  <FONT SIZE="4"><B>Redo Log Switch History (Hourly)</B></FONT>
prompt  </TD>
prompt </TR>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99" NOWRAP><FONT FACE="Arial" SIZE="2"><B>DAY </B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>00</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>01</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>02</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>03</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>04</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>05</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>06</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>07</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>08</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>09</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>10</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>11</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>12</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>13</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>14</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>15</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>16</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>17</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>18</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>19</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>20</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>21</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>22</B></FONT></TD>
prompt  <TD ALIGN="CENTER" BGCOLOR="#CCCC99"><FONT FACE="Arial" SIZE="2"><B>23</B></FONT></TD>
prompt </TR>
select '<TR>
	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||to_char(to_date(substr(time,1,8),'MM/DD/YY'),'YYYY/MM/DD')||'</FONT></TD>
       	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||decode(sum(decode(substr(time,10,2),'00',1,0)),0,'-',sum(decode(substr(time,10,2),'00',1,0)))||'</FONT></TD>
       	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||decode(sum(decode(substr(time,10,2),'01',1,0)),0,'-',sum(decode(substr(time,10,2),'01',1,0)))||'</FONT></TD>
       	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||decode(sum(decode(substr(time,10,2),'02',1,0)),0,'-',sum(decode(substr(time,10,2),'02',1,0)))||'</FONT></TD>
       	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||decode(sum(decode(substr(time,10,2),'03',1,0)),0,'-',sum(decode(substr(time,10,2),'03',1,0)))||'</FONT></TD>
       	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||decode(sum(decode(substr(time,10,2),'04',1,0)),0,'-',sum(decode(substr(time,10,2),'04',1,0)))||'</FONT></TD>
       	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||decode(sum(decode(substr(time,10,2),'05',1,0)),0,'-',sum(decode(substr(time,10,2),'05',1,0)))||'</FONT></TD>
       	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||decode(sum(decode(substr(time,10,2),'06',1,0)),0,'-',sum(decode(substr(time,10,2),'06',1,0)))||'</FONT></TD>
       	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||decode(sum(decode(substr(time,10,2),'07',1,0)),0,'-',sum(decode(substr(time,10,2),'07',1,0)))||'</FONT></TD>
       	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||decode(sum(decode(substr(time,10,2),'08',1,0)),0,'-',sum(decode(substr(time,10,2),'08',1,0)))||'</FONT></TD>
       	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||decode(sum(decode(substr(time,10,2),'09',1,0)),0,'-',sum(decode(substr(time,10,2),'09',1,0)))||'</FONT></TD>
       	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||decode(sum(decode(substr(time,10,2),'10',1,0)),0,'-',sum(decode(substr(time,10,2),'10',1,0)))||'</FONT></TD>
       	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||decode(sum(decode(substr(time,10,2),'11',1,0)),0,'-',sum(decode(substr(time,10,2),'11',1,0)))||'</FONT></TD>
       	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||decode(sum(decode(substr(time,10,2),'12',1,0)),0,'-',sum(decode(substr(time,10,2),'12',1,0)))||'</FONT></TD>
       	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||decode(sum(decode(substr(time,10,2),'13',1,0)),0,'-',sum(decode(substr(time,10,2),'13',1,0)))||'</FONT></TD>
       	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||decode(sum(decode(substr(time,10,2),'14',1,0)),0,'-',sum(decode(substr(time,10,2),'14',1,0)))||'</FONT></TD>
       	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||decode(sum(decode(substr(time,10,2),'15',1,0)),0,'-',sum(decode(substr(time,10,2),'15',1,0)))||'</FONT></TD>
       	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||decode(sum(decode(substr(time,10,2),'16',1,0)),0,'-',sum(decode(substr(time,10,2),'16',1,0)))||'</FONT></TD>
       	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||decode(sum(decode(substr(time,10,2),'17',1,0)),0,'-',sum(decode(substr(time,10,2),'17',1,0)))||'</FONT></TD>
       	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||decode(sum(decode(substr(time,10,2),'18',1,0)),0,'-',sum(decode(substr(time,10,2),'18',1,0)))||'</FONT></TD>
       	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||decode(sum(decode(substr(time,10,2),'19',1,0)),0,'-',sum(decode(substr(time,10,2),'19',1,0)))||'</FONT></TD>
       	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||decode(sum(decode(substr(time,10,2),'20',1,0)),0,'-',sum(decode(substr(time,10,2),'20',1,0)))||'</FONT></TD>
       	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||decode(sum(decode(substr(time,10,2),'21',1,0)),0,'-',sum(decode(substr(time,10,2),'21',1,0)))||'</FONT></TD>
       	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||decode(sum(decode(substr(time,10,2),'22',1,0)),0,'-',sum(decode(substr(time,10,2),'22',1,0)))||'</FONT></TD>
       	<TD ALIGN="CENTER"><FONT FACE="Arial" SIZE="2">'||decode(sum(decode(substr(time,10,2),'23',1,0)),0,'-',sum(decode(substr(time,10,2),'23',1,0)))||'</FONT></TD>
       </TR>'
from 	sys.v_$log_history
group	by to_char(to_date(substr(time,1,8),'MM/DD/YY'),'YYYY/MM/DD')
order	by to_char(to_date(substr(time,1,8),'MM/DD/YY'),'YYYY/MM/DD') desc;
prompt </TABLE><BR>
prompt </FONT></CENTER>
prompt </BODY></HTML>
spool off
