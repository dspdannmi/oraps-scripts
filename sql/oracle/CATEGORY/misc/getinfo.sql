
declare
  v_DBID	        v$database.DBID%TYPE;
  v_NAME	        v$database.NAME%TYPE;
  v_LOG_MODE	        v$database.LOG_MODE%TYPE;
  v_OPEN_MODE	        v$database.OPEN_MODE%TYPE;
  v_PROTECTION_MODE	v$database.PROTECTION_MODE%TYPE;
  v_PROTECTION_LEVEL	v$database.PROTECTION_LEVEL%TYPE;
  v_DATABASE_ROLE	v$database.DATABASE_ROLE%TYPE;
  v_FORCE_LOGGING	v$database.FORCE_LOGGING%TYPE;
  v_FLASHBACK_ON	v$database.FLASHBACK_ON%TYPE;
  v_DB_UNIQUE_NAME	v$database.DB_UNIQUE_NAME%TYPE;

  v_INSTANCE_NAME       v$instance.INSTANCE_NAME%TYPE;
  v_STARTUP_TIME       v$instance.STARTUP_TIME%TYPE;
  v_STATUS       v$instance.STATUS%TYPE;
  v_DATABASE_STATUS       v$instance.DATABASE_STATUS%TYPE;

  v_INSTANCE_TYPE       varchar2(16);

  inst_tab dbms_utility.instance_table;
  inst_cnt NUMBER;
begin




    select DBID ,NAME ,LOG_MODE ,OPEN_MODE ,PROTECTION_MODE ,PROTECTION_LEVEL ,DATABASE_ROLE ,FORCE_LOGGING ,FLASHBACK_ON ,DB_UNIQUE_NAME
    into v_DBID, v_NAME, v_LOG_MODE, v_OPEN_MODE, v_PROTECTION_MODE, v_PROTECTION_LEVEL, v_DATABASE_ROLE, v_FORCE_LOGGING, v_FLASHBACK_ON, v_DB_UNIQUE_NAME 
    from v$database;

    select instance_name, startup_time, status, database_status
    into v_INSTANCE_NAME, v_STARTUP_TIME, v_STATUS, v_DATABASE_STATUS
    from v$instance;

    IF dbms_utility.is_cluster_database THEN
        dbms_utility.active_instances(inst_tab, inst_cnt);
        dbms_output.put_line('-' || inst_tab.FIRST);
        dbms_output.put_line(TO_CHAR(inst_cnt));
        v_INSTANCE_TYPE := 'RAC instance';
      ELSE
        v_INSTANCE_TYPE := 'Single instance';
      END IF;

    dbms_output.put_line('DBID:             ' || v_DBID);
    dbms_output.put_line('DATABASE NAME:    ' || v_NAME);
    dbms_output.put_line('INSTANCE_NAME:    ' || v_INSTANCE_NAME);
    dbms_output.put_line('DB_UNIQUE_NAME:   ' || v_DB_UNIQUE_NAME);

    dbms_output.put_line('INSTANCE_TYPE:    ' || v_INSTANCE_TYPE);
  
    dbms_output.put_line('INSTANCE_STATUS:  ' || v_STATUS);
    dbms_output.put_line('OPEN_MODE:        ' || v_OPEN_MODE);
    dbms_output.put_line('PROTECTION_MODE:  ' || v_PROTECTION_MODE);
    dbms_output.put_line('PROTECTION_LEVEL: ' || v_PROTECTION_LEVEL);
    dbms_output.put_line('DATABASE_ROLE:    ' || v_DATABASE_ROLE);


    dbms_output.new_line;
    dbms_output.new_line;

    dbms_output.put_line('STARTUP_TIME:     ' || to_char(v_STARTUP_TIME, 'YYYY-MM-DD:HH24:MI:SS'));
    dbms_output.put_line('DATABASE_STATUS:  ' || v_DATABASE_STATUS);
    dbms_output.put_line('LOG_MODE:         ' || v_LOG_MODE);
    dbms_output.put_line('FORCE_LOGGING:    ' || v_FORCE_LOGGING);
    dbms_output.put_line('FLASHBACK_ON:     ' || v_FLASHBACK_ON);
end;
/
