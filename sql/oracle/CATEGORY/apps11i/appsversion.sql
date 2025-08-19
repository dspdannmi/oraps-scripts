
--DESCRIBE: display Oracle Applications components and versions

set verify off

clear breaks
clear computes

rem -----------------------------------------------------------------------
rem Filename:   appsver.sql
rem Purpose:    Print Oracle Apps versions
rem Author:     Anonymous
rem -----------------------------------------------------------------------

SELECT substr(a.application_short_name, 1, 5) code,
       substr(t.application_name, 1, 50) application_name,
       p.product_version version
FROM   apps.fnd_application a,
       apps.fnd_application_tl t,
       apps.fnd_product_installations p
WHERE  a.application_id = p.application_id
AND    a.application_id = t.application_id
AND    t.language = USERENV('LANG')
/

