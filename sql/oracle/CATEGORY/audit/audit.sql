
--DESCRIBE: auditing info from various dictionary audit views and tables

rem -----------------------------------------------------------------------
rem Filename:   audit.sql
rem Purpose:    Database auditing information (only if auditing is enabled)
rem Date:       04-Nov-2001
rem Author:     Frank Naude, Oracle FAQ
rem -----------------------------------------------------------------------

clear breaks
clear columns
clear computes

ttitle "Auditing Initialisation Parameters:"
select name || '=' || value PARAMETER
from   sys.v_$parameter where name like '%audit%'
/

ttitle "Statement Audits Enabled on this Database"
column user_name format a10
column audit_option format a40
select *
from   sys.dba_stmt_audit_opts
/

ttitle "Privilege Audits Enabled on this Database"
select * from dba_priv_audit_opts
/

ttitle "Object Audits Enabled on this Database"
select (owner ||'.'|| object_name) object_name,
       alt, aud, com, del, gra, ind, ins, loc, ren, sel, upd, ref, exe
from   dba_obj_audit_opts
where  alt != '-/-' or aud != '-/-'
   or  com != '-/-' or del != '-/-'
   or  gra != '-/-' or ind != '-/-'
   or  ins != '-/-' or loc != '-/-'
   or  ren != '-/-' or sel != '-/-'
   or  upd != '-/-' or ref != '-/-'
   or  exe != '-/-'
/

ttitle "Default Audits Enabled on this Database"
select * from all_def_audit_opts
/

ttitle off
