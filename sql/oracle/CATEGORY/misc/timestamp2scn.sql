
--DESCRIBE: convert timestamp to SCN 

col scn format 9999999999999999999999999

prompt DD/MM/YYYY HH24:MI:SS
select timestamp_to_scn(to_timestamp('&timestamp', 'DD/MM/YYYY HH24:MI:SS')) scn from dual;
