
--DESCRIBE: fast recovery area (fra) usage from v$recovery_area_usage

col file_type format a28
col percent_space_used format 99999 heading "PERCENT|USED"
col percent_space_reclaimable format 99999 heading "PERCENT|RECLAIMABLE"
col number_of_files format 999999 heading "NUM OF|FILES"

select * from v$recovery_area_usage
/
