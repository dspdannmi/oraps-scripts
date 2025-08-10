
--DESCRIBE: show data guard lag to standby (alternate script)

REM
REM Run on primary
REM 

select dest_id, thread#,
  max_primary_log,
  max(shipped_log) max_shipped_log,
  max(applied_log) max_applied_log
  from (
  SELECT dest_id, thread#, standby_dest,
  max (sequence#) over (partition by thread#) max_primary_log, 
  DECODE( standby_dest, 'YES', sequence#, 0 ) shipped_log, 
  DECODE( applied, 'YES', sequence#, 0 ) applied_log 
  FROM v$archived_log
  where resetlogs_change# = 
  (select max(resetlogs_change#) 
  from v$archived_log)
  ) where standby_dest='YES'
  GROUP BY thread#,dest_id, max_primary_log ; 
  
select SCN_TO_TIMESTAMP(d.current_scn) - SCN_TO_TIMESTAMP(a.applied_scn)
from v$database d, v$archive_dest a;

declare
    v_current_scn	timestamp;
	v_applied_scn	timestamp;
	v_difference		number;
begin
    select scn_to_timestamp(current_scn)
	into v_current_scn
	from v$database;
	
	select scn_to_timestamp(applied_scn)
	into v_applied_scn
	from v$archive_dest
	where dest_name = 'LOG_ARCHIVE_DEST_2';
	
	select extract(seconds from diff) seconds from (select v_current_scn-v_applied_scn diff from dual);
	
	
end;

