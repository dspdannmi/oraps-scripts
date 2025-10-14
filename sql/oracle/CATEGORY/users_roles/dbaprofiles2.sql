
--DESCRIBE: list profiles from dba_profiles

set verify off

clear breaks

col profile format a30
col limit format a40

select profile, resource_name, limit
from dba_profiles
order by profile, resource_name;

undefine 1

