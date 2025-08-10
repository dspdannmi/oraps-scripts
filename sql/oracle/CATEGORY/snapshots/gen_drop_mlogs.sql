
--DESCRIBE: generate script to drop snapshot logs based on dba_snapshot_logs

select 'drop materialized view log on ' || log_owner || '.' || master || ';'
from dba_snapshot_logs;
