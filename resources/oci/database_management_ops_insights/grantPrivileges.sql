set echo on
set serveroutput on
set verify off
set linesize 32767
set feedback off
set heading off

declare
    role_exist integer;
    db_version v$instance.version%type;
    db_major_version INTEGER;
    db_minor_version INTEGER;
    db_sub_version INTEGER;
    is_db_cdb varchar2(3);
    dbrole varchar2(25);
    monuser varchar2(25);
    number_Of_grants_given INTEGER;
    user_exist integer;
    db_role varchar2(25);
   qualifier varchar2(50);
    sql_stmt varchar2(64) := 'select upper(cdb) from v$database';
   con_id_stmt varchar2(64) := q'[select SYS_CONTEXT ('USERENV', 'CON_ID') from dual]';
   up_sql_stmt varchar2(64) := q'[select value from v$parameter where name = 'common_user_prefix']';
   user_prefix varchar2(30);
   con_id number;
    invoked_by_opsi BOOLEAN;
    access_to_containers BOOLEAN;
   is_dg_monitoring_user BOOLEAN;
begin

    if ('&3' ='Y') then
        invoked_by_opsi := TRUE;
    else
        invoked_by_opsi := FALSE;
    end if;

    if ('&4' ='Y') then
        access_to_containers := TRUE;
    else
        access_to_containers := FALSE;
    end if;

   if ('&5' ='Y') then
       is_dg_monitoring_user := TRUE;
   else
       is_dg_monitoring_user := FALSE;
    end if;

    select version into db_version from v$instance;
    dbms_output.put_line ('Version: ' || db_version);

    /*
    db_version = 12.1.0.2.0
    db_major_version=12
    db_minor_version=1
    db_sub_version=2
    */

   select to_number(SUBSTR(db_version,
                           1,
                           Instr(db_version, '.', 1, 1)-1 )) ,
              to_number(substr(db_version,
                           Instr(db_version, '.', 1, 1)+1 ,
                           Instr(db_version, '.', 1, 2) - Instr(db_version, '.', 1, 1)-1)),
              to_number(substr(db_version,
                           Instr(db_version, '.', 1, 3)+1 ,
                           Instr(db_version, '.', 1, 4) - Instr(db_version, '.', 1, 3)-1))
    into db_major_version, db_minor_version , db_sub_version
   from dual;

    /*
    Skip if the DB version was < 11.2.0.4
    */

    if ( (db_major_version < 11) or (db_major_version = 11 and ( db_minor_version < 2 or (db_minor_version = 2 and db_sub_version < 4) ) ) ) then
        dbms_output.put_line ('ERROR: DB Management, Monitoring and Operations Insights is not supported for the version through OCI: ' || db_version);
        RAISE_APPLICATION_ERROR(-20001, 'DB Management, Monitoring and Operations Insights is not supported for the version through OCI: ' || db_version);
    end if;

    /*
    CDB column not available in 11 version of dbs, provide default value as 'NO'
    */
    if (db_major_version > 11) then
       execute immediate sql_stmt into is_db_cdb ;
    else
       is_db_cdb := 'NO';
    end if;

    dbms_output.put_line ('Is CDB: ' || is_db_cdb);

    if (is_db_cdb = 'YES') then
     execute immediate con_id_stmt into con_id;
     dbms_output.put_line ('Is CON: ' || con_id);
      if(access_to_containers) then
        qualifier := 'CONTAINER=ALL';
      else
         qualifier := '';
      end if;
      dbms_output.put_line ('qualifier is ' || qualifier);
   else
      qualifier := '';
   end if;

   if (is_db_cdb = 'YES' and con_id = 1) then
       execute immediate up_sql_stmt into user_prefix;
       dbms_output.put_line ('Is prefix: ' || user_prefix);
        dbrole := user_prefix || 'oci_mon_role';
        monuser := '&1';
        if (length(monuser)<length(user_prefix) or upper(substr(monuser,1,length(user_prefix))) <> user_prefix)  then
           dbms_output.put_line ('ERROR: Provided database details were CDB database, so user to be created should start with prefix ' || user_prefix);
           RAISE_APPLICATION_ERROR(-20001, 'User to be created should start with prefix ' || user_prefix);
        end if;
    else
       dbrole := 'oci_mon_role';
       monuser := '&1';
    end if;

    select count(*) into role_exist from dba_roles where role=upper(dbrole);
    if (role_exist = 0) then
       execute immediate 'create role ' || dbrole || ' ' || qualifier ;
    end if;

    select count(*) into user_exist from dba_users where username=upper(monuser);
    if (user_exist = 0) then
         if (con_id = 1) then
            execute immediate 'create user ' || monuser || ' identified by &2 '|| ' container = ALL';
         else
            execute immediate 'create user ' || monuser || ' identified by &2';
         end if;
    end if;

   /* grant privileges to created role*/

   dbms_output.put_line ('granting create session to ' || monuser);
   execute immediate 'grant create session to ' || monuser || ' ' || qualifier;

   dbms_output.put_line ('granting select on dba_data_files to '|| dbrole);
   execute immediate 'grant select on dba_data_files to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on dba_free_space to '|| dbrole);
   execute immediate 'grant select on dba_free_space to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on dba_tablespaces to '|| dbrole);
   execute immediate 'grant select on dba_tablespaces to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on dba_tablespace_usage_metrics to '|| dbrole);
   execute immediate 'grant select on dba_tablespace_usage_metrics to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on dba_temp_files to '|| dbrole) ;
   execute immediate 'grant select on dba_temp_files to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on dba_undo_extents to '|| dbrole);
   execute immediate 'grant select on dba_undo_extents to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on dba_scheduler_job_run_details to '|| dbrole);
   execute immediate 'grant select on dba_scheduler_job_run_details to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on dba_scheduler_jobs to '|| dbrole);
   execute immediate 'grant select on dba_scheduler_jobs to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on dba_jobs to '|| dbrole);
   execute immediate 'grant select on dba_jobs to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on dba_indexes to '|| dbrole);
   execute immediate 'grant select on dba_indexes to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on dba_ind_partitions to '|| dbrole);
   execute immediate 'grant select on dba_ind_partitions to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on dba_ind_subpartitions to '|| dbrole);
   execute immediate 'grant select on dba_ind_subpartitions to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on dba_invalid_objects to '|| dbrole);
   execute immediate 'grant select on dba_invalid_objects to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on v_$sqlstats to '|| dbrole);
   execute immediate 'grant select on v_$sqlstats to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on gv_$sqlstats to '|| dbrole);
   execute immediate 'grant select on gv_$sqlstats to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on v_$controlfile to '|| dbrole);
   execute immediate 'grant select on v_$controlfile to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on gv_$controlfile to '|| dbrole);
   execute immediate 'grant select on gv_$controlfile to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on v_$controlfile_record_section to '|| dbrole);
   execute immediate 'grant select on v_$controlfile_record_section to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on gv_$controlfile_record_section to '|| dbrole);
   execute immediate 'grant select on gv_$controlfile_record_section to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on gv_$database to '|| dbrole);
   execute immediate 'grant select on gv_$database to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on v_$database to '|| dbrole);
   execute immediate 'grant select on v_$database to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on v_$session to '|| dbrole);
   execute immediate 'grant select on v_$session to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on gv_$session to '|| dbrole);
   execute immediate 'grant select on gv_$session to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on gv_$instance to '|| dbrole);
   execute immediate 'grant select on gv_$instance to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on v_$instance to '|| dbrole);
   execute immediate 'grant select on v_$instance to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on gv_$log to '|| dbrole);
   execute immediate 'grant select on gv_$log to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on v_$log to '|| dbrole);
   execute immediate 'grant select on v_$log to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on gv_$osstat to '|| dbrole);
   execute immediate 'grant select on gv_$osstat to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on v_$osstat to '|| dbrole);
   execute immediate 'grant select on v_$osstat to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on gv_$parameter to '|| dbrole);
   execute immediate 'grant select on gv_$parameter to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on v_$parameter to '|| dbrole);
   execute immediate 'grant select on v_$parameter to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on gv_$nls_parameters to '|| dbrole);
   execute immediate 'grant select on gv_$nls_parameters to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on v_$nls_parameters to '|| dbrole);
   execute immediate 'grant select on v_$nls_parameters to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on gv_$archive_dest to '|| dbrole);
   execute immediate 'grant select on gv_$archive_dest to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on v_$archive_dest to '|| dbrole);
   execute immediate 'grant select on v_$archive_dest to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on gv_$archive_dest_status to '|| dbrole);
   execute immediate 'grant select on gv_$archive_dest_status to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on v_$archive_dest_status to '|| dbrole);
   execute immediate 'grant select on v_$archive_dest_status to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on gv_$logmnr_session to '|| dbrole);
   execute immediate 'grant select on gv_$logmnr_session to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on v_$logmnr_session to '|| dbrole);
   execute immediate 'grant select on v_$logmnr_session to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on dba_logmnr_session to '|| dbrole);
   execute immediate 'grant select on dba_logmnr_session to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on gv_$logmnr_stats to '|| dbrole);
   execute immediate 'grant select on gv_$logmnr_stats to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on v_$logmnr_stats to '|| dbrole);
   execute immediate 'grant select on v_$logmnr_stats to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on gv_$dataguard_stats to '|| dbrole);
   execute immediate 'grant select on gv_$dataguard_stats to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on v_$dataguard_stats to '|| dbrole);
   execute immediate 'grant select on v_$dataguard_stats to '|| dbrole || ' ' || qualifier;
   
   dbms_output.put_line ('granting select on v_$rman_backup_job_details to '|| dbrole);
   execute immediate 'grant select on v_$rman_backup_job_details to '|| dbrole || ' ' || qualifier;
   
   dbms_output.put_line ('granting select on v_$backup_piece_details to '|| dbrole);
   execute immediate 'grant select on v_$backup_piece_details to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on gv_$pgastat to '|| dbrole);
   execute immediate 'grant select on gv_$pgastat to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on v_$pgastat to '|| dbrole);
   execute immediate 'grant select on v_$pgastat to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on v_$recovery_file_dest to '|| dbrole);
   execute immediate 'grant select on v_$recovery_file_dest to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on v_$rman_status to '|| dbrole);
   execute immediate 'grant select on v_$rman_status to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on gv_$services to '|| dbrole);
   execute immediate 'grant select on gv_$services to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on v_$services to '|| dbrole);
   execute immediate 'grant select on v_$services to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on gv_$sgastat to '|| dbrole);
   execute immediate 'grant select on gv_$sgastat to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on v_$sgastat to '|| dbrole);
   execute immediate 'grant select on v_$sgastat to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on gv_$sort_segment to '|| dbrole);
   execute immediate 'grant select on gv_$sort_segment to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on v_$sort_segment to '|| dbrole);
   execute immediate 'grant select on v_$sort_segment to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on v_$sysmetric to '|| dbrole);
   execute immediate 'grant select on v_$sysmetric to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on gv_$sysmetric to '|| dbrole);
   execute immediate 'grant select on gv_$sysmetric to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on gv_$sysmetric_history to '|| dbrole);
   execute immediate 'grant select on gv_$sysmetric_history to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on v_$sysmetric_history to '|| dbrole);
   execute immediate 'grant select on v_$sysmetric_history to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on v_$sysstat to '|| dbrole);
   execute immediate 'grant select on v_$sysstat to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on gv_$sysstat to '|| dbrole);
   execute immediate 'grant select on gv_$sysstat to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on gv_$system_parameter to '|| dbrole);
   execute immediate 'grant select on gv_$system_parameter to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on v_$system_parameter to '|| dbrole);
   execute immediate 'grant select on v_$system_parameter to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on v_$system_wait_class to '|| dbrole);
   execute immediate 'grant select on v_$system_wait_class to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on gv_$system_wait_class to '|| dbrole);
   execute immediate 'grant select on gv_$system_wait_class to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on gv_$version to '|| dbrole);
   execute immediate 'grant select on gv_$version to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on v_$version to '|| dbrole);
   execute immediate 'grant select on v_$version to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on gv_$dlm_misc to '|| dbrole);
   execute immediate 'grant select on gv_$dlm_misc to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on v_$dlm_misc to '|| dbrole);
   execute immediate 'grant select on v_$dlm_misc to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting execute on sys.dbms_drs to '|| dbrole);
   execute immediate 'grant execute on sys.dbms_drs to '|| dbrole || ' ' || qualifier;


   /* Privileges that can be added only for DBs above version 12 */
   if (db_major_version >= 12) then
   
       dbms_output.put_line ('granting select on cdb_data_files to '|| dbrole);
       execute immediate 'grant select on cdb_data_files to '|| dbrole || ' ' || qualifier;

       dbms_output.put_line ('granting select on cdb_free_space to '|| dbrole);
       execute immediate 'grant select on cdb_free_space to '|| dbrole || ' ' || qualifier;

       dbms_output.put_line ('granting select on cdb_tablespaces to '|| dbrole);
       execute immediate 'grant select on cdb_tablespaces to '|| dbrole || ' ' || qualifier;

       dbms_output.put_line ('granting select on cdb_tablespace_usage_metrics to '|| dbrole);
       execute immediate 'grant select on cdb_tablespace_usage_metrics to '|| dbrole || ' ' || qualifier;

       dbms_output.put_line ('granting select on cdb_temp_files to '|| dbrole);
       execute immediate 'grant select on cdb_temp_files to '|| dbrole || ' ' || qualifier;

       dbms_output.put_line ('granting select on cdb_undo_extents to '|| dbrole);
       execute immediate 'grant select on cdb_undo_extents to '|| dbrole || ' ' || qualifier;

       dbms_output.put_line ('granting select on cdb_scheduler_job_run_details to '|| dbrole);
       execute immediate 'grant select on cdb_scheduler_job_run_details to '|| dbrole || ' ' || qualifier;

       dbms_output.put_line ('granting select on cdb_scheduler_jobs to '|| dbrole);
       execute immediate 'grant select on cdb_scheduler_jobs to '|| dbrole || ' ' || qualifier;

       dbms_output.put_line ('granting select on cdb_jobs to '|| dbrole);
       execute immediate 'grant select on cdb_jobs to '|| dbrole || ' ' || qualifier;

       dbms_output.put_line ('granting select on cdb_indexes to '|| dbrole);
       execute immediate 'grant select on cdb_indexes to '|| dbrole || ' ' || qualifier;

       dbms_output.put_line ('granting select on cdb_ind_partitions to '|| dbrole);
       execute immediate 'grant select on cdb_ind_partitions to '|| dbrole || ' ' || qualifier;

       dbms_output.put_line ('granting select on cdb_ind_subpartitions to '|| dbrole);
       execute immediate 'grant select on cdb_ind_subpartitions to '|| dbrole || ' ' || qualifier;

       dbms_output.put_line ('granting select on cdb_invalid_objects to '|| dbrole);
       execute immediate 'grant select on cdb_invalid_objects to '|| dbrole || ' ' || qualifier;

       dbms_output.put_line ('granting select on gv_$containers to '|| dbrole);
       execute immediate 'grant select on gv_$containers to '|| dbrole || ' ' || qualifier;

       dbms_output.put_line ('granting select on v_$containers to '|| dbrole);
       execute immediate 'grant select on v_$containers to '|| dbrole || ' ' || qualifier;

       dbms_output.put_line ('granting select on gv_$con_sysstat to '|| dbrole);
       execute immediate 'grant select on gv_$con_sysstat to '|| dbrole || ' ' || qualifier;

       dbms_output.put_line ('granting select on v_$con_sysstat to '|| dbrole);
       execute immediate 'grant select on v_$con_sysstat to '|| dbrole || ' ' || qualifier;

       dbms_output.put_line ('granting select on gv_$con_system_wait_class to '|| dbrole);
       execute immediate 'grant select on gv_$con_system_wait_class to '|| dbrole || ' ' || qualifier;

       dbms_output.put_line ('granting select on v_$con_system_wait_class to '|| dbrole);
       execute immediate 'grant select on v_$con_system_wait_class to '|| dbrole || ' ' || qualifier;

       dbms_output.put_line ('granting select on v_$con_sys_time_model to '|| dbrole);
       execute immediate 'grant select on v_$con_sys_time_model to '|| dbrole || ' ' || qualifier;

       dbms_output.put_line ('granting select on gv_$con_sys_time_model to '|| dbrole);
       execute immediate 'grant select on gv_$con_sys_time_model to '|| dbrole || ' ' || qualifier;

       dbms_output.put_line ('granting select on v_$pdbs to '|| dbrole);
       execute immediate 'grant select on v_$pdbs to '|| dbrole || ' ' || qualifier;

       dbms_output.put_line ('granting select on gv_$pdbs to '|| dbrole);
       execute immediate 'grant select on gv_$pdbs to '|| dbrole || ' ' || qualifier;

       dbms_output.put_line ('granting select on v_$disk_restore_range to '|| dbrole);
       execute immediate 'grant select on v_$disk_restore_range to '|| dbrole || ' ' || qualifier;
   
       dbms_output.put_line ('granting select on v_$sbt_restore_range to '|| dbrole);
       execute immediate 'grant select on v_$sbt_restore_range to '|| dbrole || ' ' || qualifier;

   end if;
   /* END OF  Privileges that can be added only for DBs above version 12 */


   /* Privileges that can be added only for DBs above version 12.2 */
   if (db_major_version > 12 or (db_major_version = 12 and db_minor_version >= 2)) then

   dbms_output.put_line ('granting select on gv_$con_sysmetric to '|| dbrole);
   execute immediate 'grant select on gv_$con_sysmetric to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on v_$con_sysmetric to '|| dbrole);
   execute immediate 'grant select on v_$con_sysmetric to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on gv_$con_sysmetric_history to '|| dbrole);
   execute immediate 'grant select on gv_$con_sysmetric_history to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on v_$con_sysmetric_history to '|| dbrole);
   execute immediate 'grant select on v_$con_sysmetric_history to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on gv_$fs_failover_observers to '|| dbrole);
   execute immediate 'grant select on gv_$fs_failover_observers to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on v_$fs_failover_observers to '|| dbrole);
   execute immediate 'grant select on v_$fs_failover_observers to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on gv_$dg_broker_config to '|| dbrole);
   execute immediate 'grant select on gv_$dg_broker_config to '|| dbrole || ' ' || qualifier;

   dbms_output.put_line ('granting select on v_$dg_broker_config to '|| dbrole);
   execute immediate 'grant select on v_$dg_broker_config to '|| dbrole || ' ' || qualifier;

   end if;
   /* END OF Privileges that can be added only for DBs above version 12.2 */

   /* OPSI additional privileges */
   if(invoked_by_opsi) then
       
       dbms_output.Put_line ('granting select on v_$active_session_history to ' || dbrole );
       execute immediate 'grant select on v_$active_session_history to ' || dbrole || ' ' || qualifier;
       
       dbms_output.Put_line ('granting select on gv_$active_session_history to ' || dbrole );
       execute immediate 'grant select on gv_$active_session_history to ' || dbrole || ' ' || qualifier;
       
       dbms_output.Put_line ('granting select on v_$sql to  ' || dbrole);
       execute immediate 'grant select on v_$sql to ' || dbrole || ' ' || qualifier;
       
       dbms_output.Put_line ('granting select on gv_$sql to ' || dbrole );
       execute immediate 'grant select on gv_$sql to ' || dbrole || ' ' || qualifier;
       
       dbms_output.Put_line ('granting select on v_$ash_info to ' || dbrole );
       execute immediate 'grant select on v_$ash_info to ' || dbrole || ' ' || qualifier;
       
       dbms_output.Put_line ('granting select on gv_$ash_info to ' || dbrole );
       execute immediate 'grant select on gv_$ash_info to ' || dbrole || ' ' || qualifier;
       
       dbms_output.Put_line ('granting select on v_$sqlcommand to ' || dbrole );
       execute immediate 'grant select on v_$sqlcommand to ' || dbrole || ' ' || qualifier;
       
       dbms_output.Put_line ('granting select on gv_$sqlcommand to ' || dbrole );
       execute immediate 'grant select on gv_$sqlcommand to ' || dbrole || ' ' || qualifier;
       
       dbms_output.Put_line ('granting select on v_$sql_plan to  ' || dbrole);
       execute immediate 'grant select on v_$sql_plan to ' || dbrole || ' ' || qualifier;
       
       dbms_output.Put_line ('granting select on gv_$sql_plan to  ' || dbrole);
       execute immediate 'grant select on gv_$sql_plan to ' || dbrole || ' ' || qualifier;
       
       dbms_output.Put_line ('granting select on v_$sqlarea_plan_hash to  ' || dbrole);
       execute immediate 'grant select on v_$sqlarea_plan_hash to ' || dbrole || ' ' || qualifier;
       
       dbms_output.Put_line ('granting select on gv_$sqlarea_plan_hash to  ' || dbrole);
       execute immediate 'grant select on gv_$sqlarea_plan_hash to ' || dbrole || ' ' || qualifier;
       
       dbms_output.Put_line ('granting select on v_$sqlstats to  ' || dbrole);
       execute immediate 'grant select on v_$sqlstats to ' || dbrole || ' ' || qualifier;
       
       dbms_output.Put_line ('granting select on gv_$sqlstats to  ' || dbrole);
       execute immediate 'grant select on gv_$sqlstats to ' || dbrole || ' ' || qualifier;

       dbms_output.Put_line ('granting select on gv_$asm_client to  ' || dbrole);
       execute immediate 'grant select on gv_$asm_client to ' || dbrole || ' ' || qualifier;

       dbms_output.Put_line ('granting select on v_$asm_diskgroup_stat to  ' || dbrole);
       execute immediate 'grant select on v_$asm_diskgroup_stat to ' || dbrole || ' ' || qualifier;

       /* Privileges that can be added only for DBs above version 12 */
       if (db_major_version >= 12) then
           /* Required for DBCS */                      
           dbms_output.put_line ('granting alter session to ' || dbrole);
           execute immediate 'grant alter session to ' || dbrole || ' ' || qualifier;

           dbms_output.put_line ('granting set container to ' || dbrole);
           execute immediate 'grant set container to ' || dbrole || ' ' || qualifier;

           /* Required for ADDM */
           dbms_output.put_line ('granting SELECT ANY DICTIONARY to ' || dbrole);
           execute immediate 'grant SELECT ANY DICTIONARY to ' || dbrole || ' ' || qualifier;

           /* Required for Exadata collections */
           dbms_output.Put_line ('granting select on v_$cell_disk_history to  ' || dbrole);
           execute immediate 'grant select on v_$cell_disk_history to ' || dbrole || ' ' || qualifier;

           dbms_output.Put_line ('granting select on v_$cell_config to  ' || dbrole);
           execute immediate 'grant select on v_$cell_config to ' || dbrole || ' ' || qualifier;

           dbms_output.Put_line ('granting select on v_$cell_config_info to  ' || dbrole);
           execute immediate 'grant select on v_$cell_config_info to ' || dbrole || ' ' || qualifier;

           /* Addition grants required for AWR Report Collection */
           dbms_output.Put_line ('granting read on awr_pdb_snapshot to ' || dbrole);
           execute immediate 'grant read on awr_pdb_snapshot to ' || dbrole || ' ' || qualifier;

           dbms_output.Put_line ('granting execute on dbms_workload_repository to ' || dbrole);
           execute immediate 'grant execute on dbms_workload_repository to ' || dbrole;

           /* Addition grants required for AWR Snapshot Collection */
           dbms_output.put_line('granting execute on SYS.DBMS_SWRF_INTERNAL to ' || dbrole);
           EXECUTE IMMEDIATE 'grant execute on SYS.DBMS_SWRF_INTERNAL to ' || dbrole;

           dbms_output.put_line('granting execute on dbms_lob to ' || dbrole);
           EXECUTE IMMEDIATE 'grant execute on dbms_lob to ' || dbrole;

           dbms_output.put_line('granting execute on utl_file to ' || dbrole);
           EXECUTE IMMEDIATE 'grant execute on utl_file to ' || dbrole;

           dbms_output.put_line('granting read,write on DIRECTORY DATA_PUMP_DIR to ' || dbrole);
           EXECUTE IMMEDIATE 'grant read,write on DIRECTORY DATA_PUMP_DIR to ' || dbrole;
       end if;
       /* END of OPSI privileges that can be added only for DBs above version 12 */

   end if;   
   /* End of OPSI additional privileges */

   if (is_db_cdb = 'YES' and con_id = 1) then
       execute immediate 'alter user ' || monuser || ' set container_data=all CONTAINER=CURRENT';
   end if;

   execute immediate 'grant ' || dbrole || ' to ' || monuser || ' ' || qualifier;

   if (is_dg_monitoring_user) then
       execute immediate 'grant SYSDG' || ' to ' || monuser || ' ' || qualifier;
       dbms_output.Put_line ('granting SYSDG role to ' || monuser);
   end if;

   SELECT COUNT(*) into number_of_grants_given
   FROM (SELECT DISTINCT table_name, PRIVILEGE
           FROM dba_role_privs rp
           JOIN role_tab_privs rtp
           ON (rp.granted_role = rtp.role)
   WHERE rp.grantee = UPPER(monuser) );
   dbms_output.put_line (number_Of_grants_given || ' Grants given to user ' || monuser);
end;
/
exit;
