
--DESCRIBE: show all info about database links including passwords (9i requires sysdba)

set verify off

clear breaks
clear columns
clear computes

break on "OWNER" skip 1

col "OWNER" format a15
col host format a20
col userid format a15
col password format a20
col name format a40


select decode(l.owner#, 1, 'PUBLIC', u.username) "OWNER",
       l.name,
       l.userid,
       l.password,
       l.host,
       l.ctime "CREATED"
from sys.link$ l, dba_users u
where l.owner# = u.user_id (+)
order by l.owner#, l.name
/

