
--DESCRIBE: archive current log and places specified tablespace in backup mode X=maybe different name

alter system archive log current;

alter tablespace &&1 begin backup;

undefine 1
