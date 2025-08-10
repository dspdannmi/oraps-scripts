
--DESCRIBE: show session related info including wait status, session stats etc

set verify off
set echo off

prompt Session ID: &&sid

prompt ================
prompt ~ SESSION INFO ~
prompt ================

@ dbusers &&sid



prompt ==================
prompt ~ SESSION EVENTS ~
prompt ==================

@ sessevent &&sid

prompt
prompt =================
prompt ~ SESSION WAITS ~
prompt =================

@ sesswait &&sid

prompt
prompt =================
prompt ~ SESSION STATS ~
prompt =================

@ sesstat &&sid

prompt
prompt ===============
prompt ~ SESSION I/O ~
prompt ===============

select sid, 
       block_gets, 
       consistent_gets, 
       physical_reads, 
       block_changes, 
       consistent_changes, 
       1-(physical_reads/(block_gets+consistent_gets)) "Hit Ratio"
from v$sess_io
where sid = '&&sid'
/

undefine 1
undefine 7
