
--DESCRIBE: list hidden/underscore initialisation parameters

set verify off

clear breaks
clear columns
clear computes

col ksppinm format a40
col ksppstvl format a20
col ksppstdvl format a20
col ksppdesc format a75

SELECT  ksppinm, 
	ksppstvl, 
	ksppstdvl, 
	ksppdesc
FROM    x$ksppi x, x$ksppcv y
WHERE   x.indx = y.indx 
  AND   translate(ksppinm,'_','#') like '#%'
  and   ksppinm like '%&&1%'
ORDER BY 1
/

undefine 1

