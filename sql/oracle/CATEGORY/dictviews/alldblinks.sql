
--DESCRIBE: select all from all_db_links X=check dba_ and cdb_ equivalent

set verify off

clear breaks
clear columns
clear computes

col db_link format a40
col host    format a20

select *
from all_db_links
order by owner, db_link
/

