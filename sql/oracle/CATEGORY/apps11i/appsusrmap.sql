
--DESCRIBE: show apps users currently logged on to the system

--   FILE:    fndusrmap.sql
--
--   DESCRIPTION:
--            This script will map Oracle Application users currently logged on
--            to the system.
--
--            NOTE:  Like the monitor users screen, this script requires that 
--                   Sign-On Auditing has been enabled at the User level or
--                   higher.
--
--            The join between FND_LOGINS, V$PROCESS, and V$SESSION is:
--               FND_LOGIN.pid  = V$PROCESS.pid
--               FND_LOGIN.spid = V$SESSION.process
--               V$PROCESS.addr = V$SESSION.paddr
--
--   AUTHOR:  Andy Rivenes, arivenes@appsdba.com, www.appsdba.com
--
--   DATE:    11/06/98
--
--   REQUIREMENTS:
--
--   MODIFICATIONS:
--            A. Rivenes, 06/08/1999, Added comment about Sign-on Auditing.
--            A. Rivenes, 09/13/1999, Fixed mapping between FND_LOGINS and
--               V$PROCESS.
--            A. Rivenes, 09/17/1999, Added a new attempt to map FND_LOGINS
--               better.  The problem is end_time may not get populated.  The
--               query now gets a unique pid from fnd_logins by using the 
--               MAX(start_time),pid combination.  The original query depended
--               FND_LOGINS.login_name matching V$SESSION.osuser and didn't
--               filter concurrent manager logins. This version, of course, runs
--               longer.
--
SET VERIFY off;
--
COLUMN uname      HEADING  'User Name'               FORMAT A12;
COLUMN shrtnam    HEADING  'Application'             FORMAT A11;
COLUMN respnam    HEADING  'Responsibility'          FORMAT A14;
COLUMN frmnam     HEADING  'Form'                    FORMAT A10;
COLUMN pid        HEADING  'Oracle|PID'              FORMAT 999999;
COLUMN sid        HEADING  'Oracle|SID'              FORMAT 999999;
COLUMN spid       HEADING  'Server|Process'          FORMAT 9999999;
COLUMN suser      HEADING  'Client|OS User'          FORMAT A8;
COLUMN process    HEADING  'Client|Process'          FORMAT A8;
COLUMN smach      HEADING  'Client|Machine'          FORMAT A8;
COLUMN sprog      HEADING  'Program'                 FORMAT A15   WORD_WRAPPED;
-- COLUMN cli        HEADING  'Client|Info'             FORMAT A15   WORD_WRAPPED;
SELECT usr.user_name uname,
       app.application_short_name shrtnam,
       resp.responsibility_name respnam,
       form_name frmnam,
       vproc.pid pid,
       vsess.sid sid,
       vproc.spid spid,
       vsess.osuser suser,
       vsess.process process,
       vsess.machine smach,
       vsess.program sprog --,
--       vsess.client_info cli
FROM   applsys.fnd_logins l,
       applsys.fnd_application app,
       applsys.fnd_login_responsibilities lresp,
       applsys.fnd_login_resp_forms lform,
       applsys.fnd_responsibility resp,
       applsys.fnd_form frm,
       applsys.fnd_user usr,
       v$process vproc,
       v$session vsess
 WHERE l.login_id = lresp.login_id (+)
   AND l.login_id = lform.login_id (+)
   AND app.application_id (+) = resp.application_id
   AND l.user_id = usr.user_id
   AND lresp.responsibility_id = resp.responsibility_id (+)
   AND lresp.resp_appl_id = resp.application_id (+)
   AND lform.form_id = frm.form_id (+)
   AND lform.form_appl_id = frm.application_id (+)
   AND lresp.end_time IS NULL
   AND lform.end_time IS NULL 
   AND vproc.addr = vsess.paddr
   AND l.spid = vsess.process
-- These lines are from the original fndusrmap.sql
--   AND l.login_name = vsess.osuser
--   AND vproc.addr = vsess.paddr (+)
-- These lines are new
   AND l.pid = vproc.pid
   -- This is "fuzzy", the session may not be active (e.g. end_time may not
   -- have been populated), but this attempts to get a unique combination.
   AND ( l.pid, l.start_time ) IN ( SELECT pid, MAX(start_time)
                                      FROM fnd_logins
                                     WHERE end_time IS NULL
                                       AND terminal_id != 'Concurrent'
                                     GROUP BY pid )
 ORDER BY vproc.pid
/

