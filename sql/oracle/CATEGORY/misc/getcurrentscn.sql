
--DESCRIBE: get current database system change number (SCN)

col current_scn format 9999999999999999999999999

select to_char(sysdate, 'DD-MON-YYYY HH24:MI:SS') || '(approx)' "SYSDATE", max(sequence#), current_scn
from v$database, v$log
group by to_char(sysdate, 'DD-MON-YYYY HH24:MI:SS'), current_scn;

