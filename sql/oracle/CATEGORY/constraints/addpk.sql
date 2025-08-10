
--DESCRIBE: add primary key table columns as prompted X=needs updating

set verify off

clear breaks
clear columns
clear computes

alter table &owner..&table_name add constraint doobey_pk primary key (&columns)
/

undefine owner
undefine table_name
undefine columns
