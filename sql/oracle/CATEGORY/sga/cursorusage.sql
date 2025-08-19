
--DESCRIBE: show cursor usage information

set verify off

clear breaks
clear computes

rem -----------------------------------------------------------------------
rem Filename:   cursors.sql
rem Purpose:    Track database cursor usage
rem Date:       29-Nov-2002
rem Author:     Frank Naude, Oracle FAQ
rem -----------------------------------------------------------------------

prompt Open Cursor Limit
col value format a30 head "Open Cursors Parameter Value"

select value
from   sys.v_$parameter
where  name = 'open_cursors';

prompt Summary of Current Curor Usage
col name format a25

select min(value) min, max(value) max, avg(value) avg
from   sys.v_$sesstat
where  statistic# = (select statistic#
                       from sys.v_$statname
                      where name like 'opened cursors current');

prompt Top 10 Users With Most Open Cursors
col program  format a15 trunc
col osuser   format a15 trunc
col username format a15 trunc

select * from (
  select s.sid, s.username, s.osuser, s.program, v.value "Open Cursors"
  from   sys.v_$sesstat v,  sys.v_$session s
  where  v.sid        = s.sid
    and  v.statistic# = (select statistic#
                         from sys.v_$statname
                         where name like 'opened cursors current')
  order by v.value desc
)
where rownum < 11;

