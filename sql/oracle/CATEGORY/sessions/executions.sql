
--DESCRIBE: shows info about all sql regarding executions, rows_processed etc


set verify off

clear breaks
clear computes

col sid format 99999
col sorts format 999999
col executions format 999999999
col disk_reads format 999999999999
col buffer_gets format 9999999999999

col "USER" format a25
col "SQL_TEXT" format a40
col "ROWS_PROCESSED" format 99999999 heading "ROWS"
col "USERS_EXECUTING" format 9999 heading "EXECNOW"

select sid, 
       username || '(os=' ||  osuser || ')' "USER", 
       substr(sql_text,1,40) "SQL_TEXT", 
       sorts, 
       executions, 
       users_executing, 
       rows_processed, 
       disk_reads, 
       buffer_gets
from v$session a, v$sql b
where a.sql_address (+) = b.address
  and a.sql_hash_value (+) = b.hash_value
  and (sid like '%&&1%' or osuser like '%&&1%' or username like '%&&1%' or lower(sql_text) like lower('%&&1%'))
order by sid
/

undefine 1

