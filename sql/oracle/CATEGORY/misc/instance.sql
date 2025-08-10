
--DESCRIBE: show start date and time of current instance

rem INSTANCE.SQL
rem
rem Displays the start date and time of the current instance.
rem
rem Must be executed by SYS username.
rem
rem Created 08/12/96 by Brian Lomasky
rem
COL ISD FORMAT A17 HEADING 'Instance Startup|Date and Time'
SELECT TO_CHAR(TO_DATE(A.STARTUP_TIME, 'J'), 'MM/DD/YY') || ' ' ||
	LTRIM(TO_CHAR(B.STARTUP_TIME / 3600, '00')) || ':' ||
	LTRIM(TO_CHAR((B.STARTUP_TIME - 3600 * FLOOR(B.STARTUP_TIME / 3600)) / 60, '00')) ||
	':' || LTRIM(TO_CHAR((B.STARTUP_TIME - 60 * FLOOR(B.STARTUP_TIME / 60)), '00')) ISD
FROM V$INSTANCE A, V$INSTANCE B
/
