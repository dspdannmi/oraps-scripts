
REM
REM Set to 15 min (am sure) interval and 12 days (pretty sure)
REM
execute dbms_workload_repository.modify_snapshot_settings(interval => 15,retention => 43200);
