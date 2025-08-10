
--DESCRIBE: show main contents about database links from dba_db_links

set verify off

clear breaks
clear columns
clear computes

break on "OWNER" skip 1

col owner format a18
col db_link format a40
col host format a20
col userid format a18

select owner,
       db_link,
       username,
       host,
       created
from dba_db_links
order by owner, db_link
/

