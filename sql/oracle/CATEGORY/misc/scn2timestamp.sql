
--DESCRIBE: convert database system change number (SCN) to timestamp

col current_scn format 9999999999999999999999999

select scn_to_timestamp(&scn) as timestamp from dual;

