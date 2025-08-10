
--DESCRIBE: dumps all file headers

set verify off

alter session set events 'immediate trace name file_hdrs level 10'
/
