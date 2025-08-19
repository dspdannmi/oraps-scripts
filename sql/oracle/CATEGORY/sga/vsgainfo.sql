
--DESCRIBE: show info including current size of SGA components and freespace

set verify off

clear breaks
clear computes

column name format a40
col "Mb" format 99999999
col kept format a4


select name ,
       bytes/1024/1024 "Mb",
       resizeable
from v$sgainfo
/

