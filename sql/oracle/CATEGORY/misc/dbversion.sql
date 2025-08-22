
--DESCRIBE: select version

set verify off

clear breaks
clear computes

select version 
from PRODUCT_COMPONENT_VERSION
where lower(product) like 'oracle database%'
/

undefine 1
