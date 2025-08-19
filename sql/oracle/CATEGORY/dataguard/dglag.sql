
--DESCRIBE: show data guard lag to standby

SELECT
        l.dest_id,
	s.db_unique_name,
        l.thread#,
        MAX( l.sequence# ) max_primary_log,
        MAX( DECODE( l.standby_dest, 'YES', l.sequence#, 0 ) ) max_shipped_log,
        MAX( DECODE( l.applied, 'YES', l.sequence#, 0 ) ) max_applied_log
FROM
        v$archived_log l, V$archive_dest_status s
WHERE
        l.resetlogs_change# = (
                                SELECT max(resetlogs_change#)
                                FROM v$archived_log)
        AND l.standby_dest='YES'
                AND l.thread# IN (select thread# from v$thread where status='OPEN')
                AND l.dest_id=s.dest_id
                AND s.status='VALID'
                AND s.type='PHYSICAL'
GROUP BY
        l.thread#,
	s.db_unique_name,
        l.dest_id
ORDER BY l.dest_id;
