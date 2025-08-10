
--DESCRIBE: show contents of v$restore_point

col name format a20
col time format a40
col restore_point_time format a24

select * from v$restore_point;
