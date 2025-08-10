
--DESCRIBE: list of users and properties from dba_users and last logon

set pages 80 
set lines 132


select u.username, u.user_id, u.account_status, u.lock_date, u.expiry_date, u.created, u.profile, max(a.timestamp) "LAST_LOGON"
from dba_users u, dba_audit_session a 
where u.username = a.username (+)
  and a.action_name = 'LOGON'
group by u.username, u.user_id, u.account_status, u.lock_date, u.expiry_date, u.created, u.profile
order by 1;
