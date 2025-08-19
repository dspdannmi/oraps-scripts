
--DESCRIBE: show basic information from v$sort_usage

set verify off

clear breaks
clear computes

col sortsize heading "SIZE(Mb)"

select value db_block_size from v$parameter where name = 'db_block_size'
/

select username, user, tablespace, contents, blocks*&&db_block_size/(1024*1024) sortsize
from v$sort_usage
order by 1
/

undefine 1
undefine db_block_size

--SQL> desc v$sort_usage
-- Name                                                                          Null?    Type
-- ----------------------------------------------------------------------------- -------- ----------------------------------------------------
-- USERNAME                                                                               VARCHAR2(30)
-- USER                                                                                   VARCHAR2(30)
-- SESSION_ADDR                                                                           RAW(8)
-- SESSION_NUM                                                                            NUMBER
-- SQLADDR                                                                                RAW(8)
-- SQLHASH                                                                                NUMBER
-- TABLESPACE                                                                             VARCHAR2(31)
-- CONTENTS                                                                               VARCHAR2(9)
-- SEGTYPE                                                                                VARCHAR2(9)
-- SEGFILE#                                                                               NUMBER
-- SEGBLK#                                                                                NUMBER
-- EXTENTS                                                                                NUMBER
-- BLOCKS                                                                                 NUMBER
-- SEGRFNO#                                                                               NUMBER
--
--
