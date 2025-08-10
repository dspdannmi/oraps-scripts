
--DESCRIBE: turns on monitoring for a table


prompt Enter tablename to enable monitoring on
prompt

accept tablename char prompt "Enter tablename to monitor: "
prompt

alter table &tablename monitoring;

undefine tablename



