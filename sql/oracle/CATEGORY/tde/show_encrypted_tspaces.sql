
--DESCRIBE: show encrypted tablespaces

set verify off

clear breaks

col profile format a30
col limit format a40


REM
REM credit Oracle Database Product Management
REM    YouTube video 2022 https://www.youtube.com/watch?v=HsnOtef87mM
REM

REM interestingly does not seem to give results correctly on standby
REM unless apply is ON

select c.name as PDB_NAME,
       t.name as TBS_NAME,
       e.encryptionalg as ALG,
       e.status
from v$tablespace t, v$encrypted_tablespaces e, v$containers c
where e.ts# = t.ts#
  and e.con_id = t.con_id
  and e.con_id = c.con_id
order by e.con_id, t.name;

