
--DESCRIBE: show sql in v$sqlarea and rows processed

set verify off

clear breaks
clear columns
clear computes

col sql_text format a100 wrap

break on sql_text

select sql_text, rows_processed
from v$sqlarea
where upper(sql_text) like upper('%&&1%')
order by rows_processed
/

undefine 1
