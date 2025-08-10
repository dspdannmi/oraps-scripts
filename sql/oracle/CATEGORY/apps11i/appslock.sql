
--DESCRIBE: display all current database locks for Oracle Applications users

--  FILE:   fndlock.sql
--
--  AUTHOR: Andy Rivenes, arivenes@appsdba.com, www.appsdba.com
--  DATE:   09/13/99
--
--  DESCRIPTION:
--          Query to display all current database locks for Oracle
--          Applications users.
--
--          NOTE:  Like the monitor users screen, this script requires that 
--                 Sign-On Auditing has been enabled at the User level or
--                 higher.
--
--          The map between FND_LOGINS and V$PROCESS and V$SESSION is not 100%
--          accurate. The problem is end_time may not get populated.  The query 
--          now gets a unique pid from fnd_logins by using the MAX(start_time),pid
--          combination.
--          
--  REQUIREMENTS:
--          Must be Version 7.3 or greater.
--
--  MODIFICATIONS:
--          A. Rivenes, 10/06/99, Changed the UNION to a UNION ALL, fixed the RULE mode,
--                                the optimizer ignores hints for queries with a UNION so
--                                an alter session command is now used.
--
--
--
COLUMN username    HEADING 'ORACLE|User'     FORMAT A7      TRUNCATE;
COLUMN oanam       HEADING 'OA User'         FORMAT A10     WORD_WRAPPED;
COLUMN sid         HEADING 'SID'    	     FORMAT 9999;
COLUMN command     HEADING 'SQL|Command'     FORMAT A10     WORD_WRAPPED;
COLUMN ltype       HEADING 'Lock|Type'       FORMAT A11     WORD_WRAPPED;
COLUMN lmode       HEADING 'Mode|Held'       FORMAT A10     WORD_WRAPPED;
COLUMN request     HEADING 'Mode|Request'    FORMAT A10     WORD_WRAPPED;
COLUMN ctime       HEADING 'Last|Cnvrt|Time' FORMAT 999999;
COLUMN blkothr     HEADING 'Blocking'        FORMAT A8;
COLUMN owner       HEADING 'Owner'           FORMAT A7      WORD_WRAPPED;
COLUMN image       HEADING 'Object'          FORMAT A30     WORD_WRAPPED;
--
ALTER SESSION SET OPTIMIZER_GOAL = RULE;
--
SELECT se.username,
       fndu.user_name oanam,
       se.sid,
       DECODE( se.command,
               0, 'No command',
               1, 'CREATE TABLE',
               2, 'INSERT',
               3, 'SELECT',
               4, 'CREATE CLUSTER',
               5, 'ALTER CLUSTER',
               6, 'UPDATE',
               7, 'DELETE',
               8, 'DROP CLUSTER',
               9, 'CREATE INDEX',
               10, 'DROP INDEX',
               11, 'ALTER INDEX',
               12, 'DROP TABLE',
               13, 'CREATE SEQUENCE',
               14, 'ALTER SEQUENCE',
               15, 'ALTER TABLE',
               16, 'DROP SEQUENCE',
               17, 'GRANT',
               18, 'REVOKE',
               19, 'CREATE SYNONYM',
               20, 'DROP SYNONYM',
               21, 'CREATE VIEW',
               22, 'DROP VIEW',
               23, 'VALIDATE INDEX',
               24, 'CREATE PROCEDURE',
               25, 'ALTER PROCEDURE',
               26, 'LOCK TABLE',
               27, 'NO OPERATION',
               28, 'RENAME',
               29, 'COMMENT',
               30, 'AUDIT',
               31, 'NOAUDIT',
               32, 'CREATE DATABASE LINK',
               33, 'DROP DATABASE LINK',
               34, 'CREATE DATABASE',
               35, 'ALTER DATABASE',
               36, 'CREATE ROLLBACK SEGMENT',
               37, 'ALTER ROLLBACK SEGMENT',
               38, 'DROP ROLLBACK SEGMENT',
               39, 'CREATE TABLESPACE',
               40, 'ALTER TABLESPACE',
               41, 'DROP TABLESPACE',
               42, 'ALTER SESSION',
               43, 'ALTER USER',
               44, 'COMMIT',
               45, 'ROLLBACK',
               46, 'SAVEPOINT',
               47, 'PL/SQL EXECUTE',
               48, 'SET TRANSACTION', 
               49, 'ALTER SYSTEM SWITCH LOG',
               50, 'EXPLAIN',
               51, 'CREATE USER',
               52, 'CREATE ROLE',
               53, 'DROP USER',
               54, 'DROP ROLE',
               55, 'SET ROLE',
               56, 'CREATE SCHEMA',
               57, 'CREATE CONTROL FILE',
               58, 'ALTER TRACING',
               59, 'CREATE TRIGGER',
               60, 'ALTER TRIGGER',
               61, 'DROP TRIGGER',
               62, 'ANALYZE TABLE',
               63, 'ANALYZE INDEX',
               64, 'ANALYZE CLUSTER',
               65, 'CREATE PROFILE',
               67, 'DROP PROFILE',
               68, 'ALTER PROFILE',
               69, 'DROP PROCEDURE',
               70, 'ALTER RESOURCE COST',
               71, 'CREATE SNAPSHOT LOG',
               72, 'ALTER SNAPSHOT LOG',
               73, 'DROP SNAPSHOT LOG',
               74, 'CREATE SNAPSHOT',
               75, 'ALTER SNAPSHOT',
               76, 'DROP SNAPSHOT',
               79, 'ALTER ROLE',
               85, 'TRUNCATE TABLE',
               86, 'TRUNCATE CLUSTER',
               88, 'ALTER VIEW',
               91, 'CREATE FUNCTION',
               92, 'ALTER FUNCTION',
               93, 'DROP FUNCTION',
               94, 'CREATE PACKAGE',
               95, 'ALTER PACKAGE',
               96, 'DROP PACKAGE',
               97, 'CREATE PACKAGE BODY',
               98, 'ALTER PACKAGE BODY',
               99, 'DROP PACKAGE BODY',
         TO_CHAR(se.command) ) command,
       DECODE(lo.type,
         'MR', 'Media Recovery',
         'RT', 'Redo Thread',
         'UN', 'User Name',
         'TX', 'Transaction',
         'TM', 'DML',
         'UL', 'PL/SQL User Lock',
         'DX', 'Distributed Xaction',
         'CF', 'Control File',
         'IS', 'Instance State',
         'FS', 'File Set',
         'IR', 'Instance Recovery',
         'ST', 'Disk Space Transaction',
         'TS', 'Temp Segment',
         'IV', 'Library Cache Invalidation',
         'LS', 'Log Start or Switch',
         'RW', 'Row Wait',
         'SQ', 'Sequence Number',
         'TE', 'Extend Table',
         'TT', 'Temp Table',
         'JQ', 'Job Queue',
         lo.type) ltype,
       DECODE( lo.lmode, 
         0, 'NONE',           /* Mon Lock equivalent */
         1, 'Null',           /* N */
         2, 'Row-S (SS)',     /* L */
         3, 'Row-X (SX)',     /* R */
         4, 'Share (S)',      /* S */
         5, 'S/Row-X (SSX)',  /* C */
         6, 'Excl (X)',       /* X */
         TO_CHAR(lo.lmode)) lmode,
       DECODE( lo.request, 
         0, 'NONE',           /* Mon Lock equivalent */
         1, 'Null',           /* N */
         2, 'Row-S (SS)',     /* L */
         3, 'Row-X (SX)',     /* R */
         4, 'Share (S)',      /* S */
         5, 'S/Row-X (SSX)',  /* C */
         6, 'Excl (X)',       /* X */
         TO_CHAR(lo.request)) request,
       lo.ctime ctime,
       DECODE(lo.block,
         0, 'No Block',
         1, 'Blocking',
         2, 'Global',
         TO_CHAR(lo.block)) blkothr,
       us.name owner,
       ob.name image
  FROM v$lock lo,
       v$resource re,
       v$session se,
       sys.obj$ ob,
       sys.user$ us,
       ( SELECT usr.user_name, 
                vsess.sid
           FROM applsys.fnd_logins l,
                applsys.fnd_user usr,
                v$process vproc,
                v$session vsess
          WHERE l.pid = vproc.pid
            AND l.user_id = usr.user_id
            AND vproc.addr = vsess.paddr
            AND l.spid = vsess.process
            AND ( l.pid, l.start_time ) IN ( SELECT pid, MAX(start_time)
                                               FROM fnd_logins
                                              WHERE end_time IS NULL
                                              GROUP BY pid ) ) fndu
 WHERE se.sid = lo.sid
   AND lo.id1 = re.id1
   AND re.id1 = ob.obj#
   AND ob.owner# = us.user#
   AND se.type != 'BACKGROUND'
   AND lo.id2 = 0
   AND se.sid = fndu.sid(+)
 UNION ALL
SELECT se.username,
       NULL,
       se.sid,
       DECODE( se.command,
               0, 'No command',
               1, 'CREATE TABLE',
               2, 'INSERT',
               3, 'SELECT',
               4, 'CREATE CLUSTER',
               5, 'ALTER CLUSTER',
               6, 'UPDATE',
               7, 'DELETE',
               8, 'DROP CLUSTER',
               9, 'CREATE INDEX',
               10, 'DROP INDEX',
               11, 'ALTER INDEX',
               12, 'DROP TABLE',
               13, 'CREATE SEQUENCE',
               14, 'ALTER SEQUENCE',
               15, 'ALTER TABLE',
               16, 'DROP SEQUENCE',
               17, 'GRANT',
               18, 'REVOKE',
               19, 'CREATE SYNONYM',
               20, 'DROP SYNONYM',
               21, 'CREATE VIEW',
               22, 'DROP VIEW',
               23, 'VALIDATE INDEX',
               24, 'CREATE PROCEDURE',
               25, 'ALTER PROCEDURE',
               26, 'LOCK TABLE',
               27, 'NO OPERATION',
               28, 'RENAME',
               29, 'COMMENT',
               30, 'AUDIT',
               31, 'NOAUDIT',
               32, 'CREATE DATABASE LINK',
               33, 'DROP DATABASE LINK',
               34, 'CREATE DATABASE',
               35, 'ALTER DATABASE',
               36, 'CREATE ROLLBACK SEGMENT',
               37, 'ALTER ROLLBACK SEGMENT',
               38, 'DROP ROLLBACK SEGMENT',
               39, 'CREATE TABLESPACE',
               40, 'ALTER TABLESPACE',
               41, 'DROP TABLESPACE',
               42, 'ALTER SESSION',
               43, 'ALTER USER',
               44, 'COMMIT',
               45, 'ROLLBACK',
               46, 'SAVEPOINT',
               47, 'PL/SQL EXECUTE',
               48, 'SET TRANSACTION', 
               49, 'ALTER SYSTEM SWITCH LOG',
               50, 'EXPLAIN',
               51, 'CREATE USER',
               52, 'CREATE ROLE',
               53, 'DROP USER',
               54, 'DROP ROLE',
               55, 'SET ROLE',
               56, 'CREATE SCHEMA',
               57, 'CREATE CONTROL FILE',
               58, 'ALTER TRACING',
               59, 'CREATE TRIGGER',
               60, 'ALTER TRIGGER',
               61, 'DROP TRIGGER',
               62, 'ANALYZE TABLE',
               63, 'ANALYZE INDEX',
               64, 'ANALYZE CLUSTER',
               65, 'CREATE PROFILE',
               67, 'DROP PROFILE',
               68, 'ALTER PROFILE',
               69, 'DROP PROCEDURE',
               70, 'ALTER RESOURCE COST',
               71, 'CREATE SNAPSHOT LOG',
               72, 'ALTER SNAPSHOT LOG',
               73, 'DROP SNAPSHOT LOG',
               74, 'CREATE SNAPSHOT',
               75, 'ALTER SNAPSHOT',
               76, 'DROP SNAPSHOT',
               79, 'ALTER ROLE',
               85, 'TRUNCATE TABLE',
               86, 'TRUNCATE CLUSTER',
               88, 'ALTER VIEW',
               91, 'CREATE FUNCTION',
               92, 'ALTER FUNCTION',
               93, 'DROP FUNCTION',
               94, 'CREATE PACKAGE',
               95, 'ALTER PACKAGE',
               96, 'DROP PACKAGE',
               97, 'CREATE PACKAGE BODY',
               98, 'ALTER PACKAGE BODY',
               99, 'DROP PACKAGE BODY',
         TO_CHAR(se.command) ) command,
       DECODE(lo.type,
         'MR', 'Media Recovery',
         'RT', 'Redo Thread',
         'UN', 'User Name',
         'TX', 'Transaction',
         'TM', 'DML',
         'UL', 'PL/SQL User Lock',
         'DX', 'Distributed Xaction',
         'CF', 'Control File',
         'IS', 'Instance State',
         'FS', 'File Set',
         'IR', 'Instance Recovery',
         'ST', 'Disk Space Transaction',
         'TS', 'Temp Segment',
         'IV', 'Library Cache Invalidation',
         'LS', 'Log Start or Switch',
         'RW', 'Row Wait',
         'SQ', 'Sequence Number',
         'TE', 'Extend Table',
         'TT', 'Temp Table',
         'JQ', 'Job Queue',
         lo.type) ltype,
       DECODE( lo.lmode, 
         0, 'NONE',           /* Mon Lock equivalent */
         1, 'Null Mode',      /* N */
         2, 'Row-S (SS)',     /* L */
         3, 'Row-X (SX)',     /* R */
         4, 'Share (S)',      /* S */
         5, 'S/Row-X (SSX)',  /* C */
         6, 'Excl (X)',       /* X */
         lo.lmode) lmode,
       DECODE( lo.request, 
         0, 'NONE',           /* Mon Lock equivalent */
         1, 'Null',           /* N */
         2, 'Row-S (SS)',     /* L */
         3, 'Row-X (SX)',     /* R */
         4, 'Share (S)',      /* S */
         5, 'S/Row-X (SSX)',  /* C */
         6, 'Excl (X)',       /* X */
         TO_CHAR(lo.request)) request,
       lo.ctime ctime,
       DECODE(lo.block,
         0, 'No Block',
         1, 'Blocking',
         2, 'Global',
         TO_CHAR(lo.block)) blkothr,
       'SYS' owner,
       ro.name image
  FROM v$lock lo,
       v$session se,
       v$transaction tr,
       v$rollname ro
 WHERE se.taddr IS NOT NULL
   AND se.sid = lo.sid
   AND lo.id2 != 0
   AND se.taddr = tr.addr(+)
   AND tr.xidusn = ro.usn(+)
 ORDER BY sid 
/
