
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


MINI-HC
-------

GI
--
* ASM instance not running
* alert log

DB
--
* check both DB (traditional) or CDB + PDBs (multi-tenant)
* DB down/uncontactable
	* DB not in expected state (OPEN, MOUNT, etc.)
	* PDB not in expected state
        * PDB in different state to saved state
* sessions in lockwait
* tablespaces nearly full or full
* temp tablespaces nearly full or full
* sessions in resumable wait
* dataguard lag
* archiver error
* asm disk usage nearly full or full
* v$recovery_area_usage full or nearly full
* no full or L0 backup in last X days
* ADVANCED:
	* locked user since start time
	* expected fill of tablespace in next 10mins based on rate of fill
* any guaranteed resetore points older than 2 days
 

LSN
---
* listener down

OS
--
* filesystems nearly full or full
* ADVANCED:
	* expected fill of filesystem in next 10mins based on rate of fill


