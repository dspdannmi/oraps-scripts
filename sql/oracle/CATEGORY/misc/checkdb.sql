
--DESCRIBE: perform some validation on the database

prompt =============================================
prompt GLOBAL NAME
prompt =============================================
prompt
@ globalname

prompt
prompt

prompt =============================================
prompt TEMP FILES
prompt =============================================
@ dbatempfiles


prompt
prompt


prompt =============================================
prompt DB LINKS
prompt =============================================
@ dbadblinks

prompt
prompt


prompt =============================================
prompt CHECK DB LINKS
prompt =============================================
spool /tmp/checklinks.$$.sql
@ genchecklinks
spool off
@ /tmp/checklinks.$$.sql

connect /

prompt =============================================
prompt MISSING FILES 
prompt =============================================
@ missing

