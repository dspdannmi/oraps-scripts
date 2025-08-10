
--DESCRIBE: show concurrent manager process info

--   FILE:    fndcmmap.sql
--
--   DESCRIPTION:
--            This script will map concurrent manager process information about
--            current concurrent managers.
--
--   AUTHOR:  Andy Rivenes, arivenes@appsdba.com, www.appsdba.com
--
--   DATE:    10/24/97
--
--   REQUIREMENTS:
--
--   MODIFICATIONS:
--
--
SET VERIFY off;
--
COLUMN concproc   HEADING  'Conc|Proc ID'               FORMAT 9999999;
COLUMN clproc     HEADING  'Client|Process'             FORMAT A8;
COLUMN opid       HEADING  'ORACLE|PID'                 FORMAT A6;
COLUMN svrproc    HEADING  'Server|Process'             FORMAT A8;
COLUMN cstat      HEADING  'Status'                     FORMAT A7;
COLUMN qnam       HEADING  'Queue Name'                 FORMAT A30;
--COLUMN lnam       HEADING  'Log File|Name'              FORMAT A20;
COLUMN nnam       HEADING  'Node Name'                  FORMAT A10;
COLUMN dbnam      HEADING  'DB Name'                    FORMAT A8;
COLUMN dbinst     HEADING  'Instance|Name'              FORMAT A8;
COLUMN dbuser     HEADING  'DB User'                    FORMAT A10;
SELECT proc.concurrent_process_id concproc,
       SUBSTR(proc.os_process_id,1,6) clproc,
       SUBSTR(LTRIM(proc.oracle_process_id),1,15) opid,
       SUBSTR(vproc.spid,1,10) svrproc,
       DECODE(proc.process_status_code,'A','Active',
              proc.process_status_code) cstat,
       SUBSTR(concq.concurrent_queue_name,1,30) qnam,
--       SUBSTR(proc.logfile_name,1,20) lnam,
       SUBSTR(proc.node_name,1,10) nnam,
       SUBSTR(proc.db_name,1,8) dbnam,
       SUBSTR(proc.db_instance,1,8) dbinst,
       SUBSTR(vsess.username,1,10) dbuser
  FROM fnd_concurrent_processes proc,
       fnd_concurrent_queues concq,
       v$process vproc,
       v$session vsess
 WHERE proc.process_status_code = 'A'
   AND proc.queue_application_id = concq.application_id
   AND proc.concurrent_queue_id = concq.concurrent_queue_id
   AND proc.oracle_process_id = vproc.pid(+)
   AND vproc.addr = vsess.paddr(+)
 ORDER BY proc.queue_application_id, 
       proc.concurrent_queue_id
/

