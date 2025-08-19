
--DESCRIBE: show freespace within datafiles and tablespaces

set verify off

clear breaks

col tablespace_name format a18
col file_id format 99999
col file_name format a50
col chunks format 999999
col totalbytesfree heading "TOTFREE(Mb)" format 999990.00
col maxbytesfree heading "MAXCHUNK(Mb)" format 999990.00
col totalbytes heading "FILESIZE(Mb)" format 999990.00
col pct_free heading "PCT FREE" format 990.00

break on report
break on tablespace_name

-- compute sum label "" of totalbytesfree on tablespace_name
-- compute sum of maxbytesfree on tablespace_name
-- compute sum of totalbytes on tablespace_name

select df.tablespace_name,
       df.file_id,
       df.file_name,
       count(fs.blocks) chunks,
       nvl(sum(fs.bytes)/(1024*1024),0) totalbytesfree,
       nvl(max(fs.bytes)/(1024*1024),0) maxbytesfree,
       100 * nvl(sum(fs.bytes)/(1024*1024),0) / (sum(df.bytes)/(1024*1024)) pct_free
from dba_data_files df, dba_free_space fs
where df.file_id = fs.file_id (+)
  and df.tablespace_name like upper('%&&1%')
group by df.tablespace_name, df.file_id, df.file_name
order by 1,2,3
/

prompt

break on tablespace_name 

select tablespace_name,
       count(*) chunks,
       sum(bytes)/(1024*1024) totalbytesfree,
       max(bytes)/(1024*1024) maxbytesfree
from dba_free_space
where tablespace_name like upper('%&&1%')
group by tablespace_name
order by tablespace_name
/

prompt 

undefine 1

