
--DESCRIBE: show Oracle APEX release

col version_no format a16
col api_compatibility format a18
col patch_applied format a18

select version_no, api_compatibility, patch_applied
from apex_release;
