
--DESCRIBE: list hidden/underscore initialisation parameters for a particular session

set verify off

clear breaks

col ksppinm format a40
col ksppstvl format a20
col ksppdesc format a75


SELECT x.ksppinm "Parameter",
       Y.ksppstvl "Session Value",
       Z.ksppstvl "Instance Value"
FROM   x$ksppi X,
       x$ksppcv Y,
       x$ksppsv Z
WHERE  x.indx = Y.indx
AND    x.indx = z.indx
AND    x.ksppinm LIKE '/_%' escape '/'
and x.ksppinm like '%&&1%'
order by x.ksppinm
/

undefine 1

