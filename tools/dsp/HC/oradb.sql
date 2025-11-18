
Adhoc IDEAS for Health Checks

REM check to make sure after patching we don't get ORA-29548
REM would need to run ?/rdbms/admin/update_javavm_db.sql

select dbms_java.get_jdk_version() from dual;



REM
REM Timezone
REM
select * from v$timezone_file;

select tz_version || ' please read  Doc ID 1255474.1 as per oracle-base.com recommendation when doing this' from registry$database;

REM does every temp tablespace have tempfiles that exist
REM any gauranteed restore points
REM sequences that are approaching max 


- pdbs without saved state


REM > 1 v$thread (redo log thread) when database is not RAC - might indicate an incomplete transition from RAC-enabled databse to single-instance


check inodes on filesystems

check semaphores and such things as these can give "no space on device" linux errors

check permissions on /tmp
check permissions on /var/tmp

