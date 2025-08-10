
--DESCRIBE: show info for a specific concurrent request id

--   FILE:    fndrqmap.sql
--
--   DESCRIPTION:
--            This script will map concurrent request information about
--            a specific request id.
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
ACCEPT reqid CHAR PROMPT 'Enter Request ID --> ';
--
COLUMN concreq    HEADING  'Conc Req ID'                FORMAT A12;
COLUMN clproc     HEADING  'Client|Process'             FORMAT A11;
COLUMN opid       HEADING  'ORACLE PID'                 FORMAT A10;
COLUMN reqph      HEADING  'Req Phase'                  FORMAT A10;
COLUMN reqst      HEADING  'Req Status'                 FORMAT A10;
COLUMN dbuser     HEADING  'DB User'                    FORMAT A10;
COLUMN svrproc    HEADING  'Server|Process'             FORMAT A10;
SELECT SUBSTR(LTRIM(req.request_id),1,15) concreq,
       SUBSTR(proc.os_process_id,1,15) clproc,
       SUBSTR(LTRIM(proc.oracle_process_id),1,15) opid,
       SUBSTR(look.meaning,1,10) reqph,
       SUBSTR(look1.meaning,1,10) reqst,
       SUBSTR(vsess.username,1,10) dbuser,
       SUBSTR(vproc.spid,1,10) svrproc
  FROM fnd_concurrent_requests req,
       fnd_concurrent_processes proc,
       fnd_lookups look,
       fnd_lookups look1,
       v$process vproc,
       v$session vsess
 WHERE req.controlling_manager = proc.concurrent_process_id(+)
   AND req.status_code = look.lookup_code
   AND look.lookup_type = 'CP_STATUS_CODE'
   AND req.phase_code = look1.lookup_code
   AND look1.lookup_type = 'CP_PHASE_CODE'
   AND req.request_id = &&reqid
   AND proc.oracle_process_id = vproc.pid(+)
   AND vproc.addr = vsess.paddr(+)
/

