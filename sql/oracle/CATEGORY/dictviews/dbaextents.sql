
--DESCRIBE: show contents about extents from dba_extents

set verify off

clear breaks
clear computes

col owner format a14
col segment_name format a35
col partition_name format a10
col tablespace_name format a18

col extent_id format 999999999
col file_id format 999999
col block_id format 999999
col blocks format 9999999
col bytes format 9999999

REM SQL> esc dba_extents
REM Name                                                                          Null?    Type
REM ----------------------------------------------------------------------------- -------- ----------------------------------------------------
REM OWNER                                                                                  VARCHAR2(30)
REM SEGMENT_NAME                                                                           VARCHAR2(81)
REM PARTITION_NAME                                                                         VARCHAR2(30)
REM SEGMENT_TYPE                                                                           VARCHAR2(18)
REM TABLESPACE_NAME                                                                        VARCHAR2(30)
REM EXTENT_ID                                                                              NUMBER
REM FILE_ID                                                                                NUMBER
REM BLOCK_ID                                                                               NUMBER
REM BYTES                                                                                  NUMBER
REM BLOCKS                                                                                 NUMBER
REM RELATIVE_FNO      

select * 
from dba_extents
where owner || '.' || segment_name like upper('%&&1%')
order by owner, segment_name
/
