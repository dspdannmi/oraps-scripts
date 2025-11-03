REM 
REM This is clearly an inefficient way and possibly the most inefficient way to capture the details
REM for this database however it is trying to be compataible across Oracle versions and also
REM must try to take in to account a database/instance that is only in NOMOUNT or MOUNT mode.
REM Therefore, before this script is judged negatively here are some of the challenges:
REM     - the script output needs to be readable/consumable by a BASH script and therefore merely
REM		dumping out "select * from ..." a table will not make this easy
REM     - columns are added over time such.  For example, with multi-tenant only from 12c onwards
REM		the CDB column on V$DATABASE did not exist in versions 11g and before
REM	- if the instance is not OPEN then DBA_ and other views are not available so need to rely
REM		strongly on V$
REM	- DBMS_OUTPUT is available in MOUNT mode in later versions including as recent as 10g
REM		so could have perhaps used that with PL/SQL however do not believe it is available
REM		in 9i or below so whilst could have made a call to not support 9i and below
REM		give it is relatively easy to create the SQL below, even though its not efficient
REM		thought it was best to try to support all versions.
REM

set lines 300
col SETTNG format a200

prompt <V_DATABASE>
select 'DBID:' || DBID from v$database;
select 'NAME:' || NAME from v$database;
select 'CREATED:' || CREATED from v$database;
select 'RESETLOGS_CHANGE#:' || RESETLOGS_CHANGE# from v$database;
select 'RESETLOGS_TIME:' || RESETLOGS_TIME from v$database;
select 'PRIOR_RESETLOGS_CHANGE#:' || PRIOR_RESETLOGS_CHANGE# from v$database;
select 'PRIOR_RESETLOGS_TIME:' || PRIOR_RESETLOGS_TIME from v$database;
select 'LOG_MODE:' || LOG_MODE from v$database;
select 'CHECKPOINT_CHANGE#:' || CHECKPOINT_CHANGE# from v$database;
select 'ARCHIVE_CHANGE#:' || ARCHIVE_CHANGE# from v$database;
select 'CONTROLFILE_TYPE:' || CONTROLFILE_TYPE from v$database;
select 'CONTROLFILE_CREATED:' || CONTROLFILE_CREATED from v$database;
select 'CONTROLFILE_SEQUENCE#:' || CONTROLFILE_SEQUENCE# from v$database;
select 'CONTROLFILE_CHANGE#:' || CONTROLFILE_CHANGE# from v$database;
select 'CONTROLFILE_TIME:' || CONTROLFILE_TIME from v$database;
select 'OPEN_RESETLOGS:' || OPEN_RESETLOGS from v$database;
select 'VERSION_TIME:' || VERSION_TIME from v$database;
select 'OPEN_MODE:' || OPEN_MODE from v$database;
select 'PROTECTION_MODE:' || PROTECTION_MODE from v$database;
select 'PROTECTION_LEVEL:' || PROTECTION_LEVEL from v$database;
select 'REMOTE_ARCHIVE:' || REMOTE_ARCHIVE from v$database;
select 'ACTIVATION#:' || ACTIVATION# from v$database;
select 'SWITCHOVER#:' || SWITCHOVER# from v$database;
select 'DATABASE_ROLE:' || DATABASE_ROLE from v$database;
select 'ARCHIVELOG_CHANGE#:' || ARCHIVELOG_CHANGE# from v$database;
select 'ARCHIVELOG_COMPRESSION:' || ARCHIVELOG_COMPRESSION from v$database;
select 'SWITCHOVER_STATUS:' || SWITCHOVER_STATUS from v$database;
select 'DATAGUARD_BROKER:' || DATAGUARD_BROKER from v$database;
select 'GUARD_STATUS:' || GUARD_STATUS from v$database;
select 'SUPPLEMENTAL_LOG_DATA_MIN:' || SUPPLEMENTAL_LOG_DATA_MIN from v$database;
select 'SUPPLEMENTAL_LOG_DATA_PK:' || SUPPLEMENTAL_LOG_DATA_PK from v$database;
select 'SUPPLEMENTAL_LOG_DATA_UI:' || SUPPLEMENTAL_LOG_DATA_UI from v$database;
select 'FORCE_LOGGING:' || FORCE_LOGGING from v$database;
select 'PLATFORM_ID:' || PLATFORM_ID from v$database;
select 'PLATFORM_NAME:' || PLATFORM_NAME from v$database;
select 'RECOVERY_TARGET_INCARNATION#:' || RECOVERY_TARGET_INCARNATION# from v$database;
select 'LAST_OPEN_INCARNATION#:' || LAST_OPEN_INCARNATION# from v$database;
select 'CURRENT_SCN:' || CURRENT_SCN from v$database;
select 'FLASHBACK_ON:' || FLASHBACK_ON from v$database;
select 'SUPPLEMENTAL_LOG_DATA_FK:' || SUPPLEMENTAL_LOG_DATA_FK from v$database;
select 'SUPPLEMENTAL_LOG_DATA_ALL:' || SUPPLEMENTAL_LOG_DATA_ALL from v$database;
select 'DB_UNIQUE_NAME:' || DB_UNIQUE_NAME from v$database;
select 'STANDBY_BECAME_PRIMARY_SCN:' || STANDBY_BECAME_PRIMARY_SCN from v$database;
select 'FS_FAILOVER_MODE:' || FS_FAILOVER_MODE from v$database;
select 'FS_FAILOVER_STATUS:' || FS_FAILOVER_STATUS from v$database;
select 'FS_FAILOVER_CURRENT_TARGET:' || FS_FAILOVER_CURRENT_TARGET from v$database;
select 'FS_FAILOVER_THRESHOLD:' || FS_FAILOVER_THRESHOLD from v$database;
select 'FS_FAILOVER_OBSERVER_PRESENT:' || FS_FAILOVER_OBSERVER_PRESENT from v$database;
select 'FS_FAILOVER_OBSERVER_HOST:' || FS_FAILOVER_OBSERVER_HOST from v$database;
select 'CONTROLFILE_CONVERTED:' || CONTROLFILE_CONVERTED from v$database;
select 'PRIMARY_DB_UNIQUE_NAME:' || PRIMARY_DB_UNIQUE_NAME from v$database;
select 'SUPPLEMENTAL_LOG_DATA_PL:' || SUPPLEMENTAL_LOG_DATA_PL from v$database;
select 'MIN_REQUIRED_CAPTURE_CHANGE#:' || MIN_REQUIRED_CAPTURE_CHANGE# from v$database;
select 'CDB:' || CDB from v$database;
select 'CON_ID:' || CON_ID from v$database;
select 'PENDING_ROLE_CHANGE_TASKS:' || PENDING_ROLE_CHANGE_TASKS from v$database;
select 'CON_DBID:' || CON_DBID from v$database;
select 'FORCE_FULL_DB_CACHING:' || FORCE_FULL_DB_CACHING from v$database;
select 'SUPPLEMENTAL_LOG_DATA_SR:' || SUPPLEMENTAL_LOG_DATA_SR from v$database;
prompt </V_DATABASE>

prompt <V_INSTANCE>
select 'INSTANCE_NUMBER:' || INSTANCE_NUMBER from v$instance;
select 'INSTANCE_NAME:' || INSTANCE_NAME from v$instance;
select 'HOST_NAME:' || HOST_NAME from v$instance;
select 'VERSION:' || VERSION from v$instance;
select 'VERSION_LEGACY:' || VERSION_LEGACY from v$instance;
select 'VERSION_FULL:' || VERSION_FULL from v$instance;
select 'STARTUP_TIME:' || STARTUP_TIME from v$instance;
select 'STATUS:' || STATUS from v$instance;
select 'PARALLEL:' || PARALLEL from v$instance;
select 'THREAD#:' || THREAD# from v$instance;
select 'ARCHIVER:' || ARCHIVER from v$instance;
select 'LOG_SWITCH_WAIT:' || LOG_SWITCH_WAIT from v$instance;
select 'LOGINS:' || LOGINS from v$instance;
select 'SHUTDOWN_PENDING:' || SHUTDOWN_PENDING from v$instance;
select 'DATABASE_STATUS:' || DATABASE_STATUS from v$instance;
select 'INSTANCE_ROLE:' || INSTANCE_ROLE from v$instance;
select 'ACTIVE_STATE:' || ACTIVE_STATE from v$instance;
select 'BLOCKED:' || BLOCKED from v$instance;
select 'CON_ID:' || CON_ID from v$instance;
select 'INSTANCE_MODE:' || INSTANCE_MODE from v$instance;
select 'EDITION:' || EDITION from v$instance;
select 'FAMILY:' || FAMILY from v$instance;
select 'DATABASE_TYPE:' || DATABASE_TYPE from v$instance;
prompt </V_INSTANCE>

select 'NUMBER_OF_STANDBY_DEST: ' || count(*)
from v$archive_dest
where status = 'VALID'
and target = 'STANDBY';


prompt <V_PDBS>
select con_id, name, open_mode, restricted
from v$pdbs
order by con_id;
prompt </V_PDBS>

select 'DBSIZE_GB:' || round(sum(bytes)/1024/1024/1024)
from v$datafile;

prompt <V_PARAMETERS>
select name || ':' || value from v$parameter where name = 'cluster_database';
prompt </V_PARAMETERS>
