
--DESCRIBE: show detail info about rollback segments and active transactions

set verify off

clear breaks
clear computes

column rr heading 'SEGMENT' format a16
column us heading 'USERNAME' format a18
column sid format 99999
column os heading 'OSUSER' format a12
column te heading 'TERMINAL' format a14

column "RBSeg" format a15
column "Initial" format 999999999
column "Next" format 999999999
column "MinExtents" format 9999
column "MaxExtents" format 9999

col "BYTES(Mb)" format 999999999
col "MIN/MAX" format a14
col "PCTI"    format 999
col "INIT(Kb)" format 99999999
col "NEXT(Kb)" format 99999999

col extents format 99999999
col tablespace_name format a18
col segment_name format a16
col file_id format 999999

select r.name rr,
       s.sid,
       nvl(s.username, 'no transaction') us,
       s.osuser os,
       s.terminal te
from v$lock l, v$session s, v$rollname r
  where l.sid = s.sid (+)
  and trunc(l.id1(+)/65536)=r.usn
  and l.type(+) = 'TX'
  and l.lmode(+) = 6
order by r.name
/

prompt

select r.tablespace_name,
       r.owner,
       r.segment_name,
       r.file_id,
       r.block_id,
       r.initial_extent/1024 "INIT(Kb)",
       r.next_extent/1024 "NEXT(Kb)",
       r.min_extents || '/' || r.max_extents "MIN/MAX",
       r.pct_increase "PCTI",
       s.extents,
       s.bytes/(1024*1024) "BYTES(Mb)"
from dba_rollback_segs r, dba_segments s
where r.owner = s.owner
  and r.segment_name = s.segment_name
  and s.segment_type = 'ROLLBACK'
/

prompt

col extents format 999999
col name heading "SEGMENT" format a16
col xacts format 9999
col gets format 9999
col waits format 9999
col shrinks format 999999
col wraps format 99999
col extends format 99999
col writes format 999999999999
col optsize format 99999999
col aveshrink format 9999999
col aveactive format 9999999
col stats1 heading "XACTS/GETS/WAITS" format a25
col stats2 heading "SRNKS/WRS/XTEND/AVESRNK/AVEACTIV" format a30
col optsize heading "OPT(Kb)" format 999999
col hwmsize heading "HWM(Kb)" format 999999
col status format a9
col curext heading "CUR EXT/BLK" format a12
col sizing heading "SIZE/OPT/HWM (Mb)" format a18

select n.name,
       s.extents,
       trunc(s.rssize/(1024*1024)) || '/' || trunc(s.optsize/(1024*1024)) || '/' || trunc(s.hwmsize/(1024*1024)) sizing,
       s.writes,
       s.xacts || '/' || s.gets || '/' || s.waits stats1,
       s.shrinks || '/' || s.wraps || '/' ||  s.extends || '/' || trunc(s.aveshrink/1024) || 'k/' || s.aveactive stats2,
       s.status,
       s.curext || '/' || s.curblk curext
from v$rollname n, v$rollstat s
where n.usn = s.usn
/

undefine 1

