
REM check to make sure after patching we don't get ORA-29548
REM would need to run ?/rdbms/admin/update_javavm_db.sql

select dbms_java.get_jdk_version() from dual;


REM does every temp tablespace have tempfiles that exist
REM any gauranteed restore points
REM sequences that are approaching max 
