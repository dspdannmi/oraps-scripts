
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
  
prompt

select a.dest_id,
       a.dest_name,
       a.target, a.status,
       d.current_scn,a.applied_scn,
       decode(nvl(a.applied_scn, 0), 0, null, to_char(cast(SCN_TO_TIMESTAMP(a.applied_scn) as date), 'YYYY-MM-DD HH24:MI:SS')) applied_date,
       decode(nvl(a.applied_scn, 0), 0, null, trunc(24*60*(sysdate - cast(SCN_TO_TIMESTAMP(a.applied_scn) as date)))) minutes
from v$database d, v$archive_dest a
where a.target != 'PRIMARY'
order by a.dest_id;

prompt

select a.dest_id, a.dest_name, a.target, a.status, SCN_TO_TIMESTAMP(d.current_scn) - SCN_TO_TIMESTAMP(a.applied_scn) lag
from v$database d, v$archive_dest a
where a.target != 'PRIMARY'
  and a.status = 'VALID'
  and a.applied_scn is not null;

