
--DESCRIBE: select all from user_db_links

set verify off

clear breaks
clear computes

col owner format a18
col db_link format a40
col host format a20
col userid format a18


select *
from user_db_links
order by db_link
/

