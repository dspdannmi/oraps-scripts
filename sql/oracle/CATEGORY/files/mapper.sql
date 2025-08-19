
--DESCRIBE: shows mapping of objects/segments to tablespaces and datafiles

rem
rem     file:   mapper.sql
rem     
rem     paramter 1:     the tablespace being maped
rem
rem     From DBA HANDBOOK v7.3 (Oracle Press)
rem
rem             ie.     @mapper DEMOTSPACE
rem

set verify off

clear breaks
clear computes

col "BYTES(Kb)" format 99999999

select 'free space' owner,
       '   ' object,
       file_id,
       block_id,
       blocks,
       bytes/1024 "BYTES(Kb)"
from dba_free_space
where tablespace_name = upper('&&1')
union
select substr(owner, 1, 20),
       substr(segment_name, 1, 32),
       file_id,
       block_id,
       blocks,
       bytes/1024 "BYTES(Kb)"
from dba_extents
where tablespace_name = upper('&&1')
order by 3,4
/

undefine 1

