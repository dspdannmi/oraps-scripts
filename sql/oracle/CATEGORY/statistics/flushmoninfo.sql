
--DESCRIBE: calls dbms_stats to flush database monitoring info

prompt 
prompt Data can be flushed in several ways. 
prompt
prompt In Oracle 8i, you can wait it out for 3 hours. 
prompt In Oracle 9i and higher, you only need to wait 15 minutes. 
prompt In either version, restart the database. 
prompt For immediate results in Oracle 9i and higher, use the DBMS_STATS.flush_database_monitoring_info package. 
prompt 

rem    PROCEDURE FLUSH_DATABASE_MONITORING_INFO


prompt Not doing it but syntax is
prompt

prompt exec dbms_stats.flush_database_monitoring_info;

