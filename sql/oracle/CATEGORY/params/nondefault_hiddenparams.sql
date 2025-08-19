
--DESCRIBE: list hidden/underscore initialisation parameters

REM
REM This has been coded so it mostly works but does do a conversion on the ksppstdvl rield
REM because this can be with format K, M, G whereas actual value in ksppstvl is in full numeric value
REM
REM Luckily most non-default params - and therefore satisfied by the where clause - will be numeric values ending in K, M, G
REM however if there are other parameters that are non-default (ie. have changed) and they are not numeric and are string and so
REM happen to end with last character of K, M or G you will get an invalid number ORA-01722: invalid number in which case
REM remove the fancy translation of the human readable K, M and G values in the select to just the straight text (ie. 10K instead of 10240)

set verify off

clear breaks
clear computes

col ksppinm format a40
col ksppstvl format a20
col ksppstdvl format a20
col ksppdesc format a75

SELECT  ksppinm,
        ksppstvl,
        decode(upper(substr(ksppstdvl,length(ksppstdvl),1)), 'K', to_char(to_number(substr(ksppstdvl,1,length(ksppstdvl)-1))*1024),
                                                             'M', to_char(to_number(substr(ksppstdvl,1,length(ksppstdvl)-1))*1024*1024),
                                                             'G', to_char(to_number(substr(ksppstdvl,1,length(ksppstdvl)-1))*1024*1024*1024), ksppstdvl) ksppstdvl,
        ksppdesc
FROM    x$ksppi x, x$ksppcv y
WHERE   x.indx = y.indx
  AND   translate(ksppinm,'_','#') like '#%'
  and   ksppinm like '%&&1%'
  and   (ksppstvl is not null and ksppstvl != ksppstdvl)
ORDER BY 1
/


undefine 1

