
--DESCRIBE: generates script to recreate sequences

set verify off

clear breaks

col col0 format a79;
col col1 format a79;
col col2 format a79;
col col3 format a79;
col col4 format a79;
col col5 format a79;
col col6 format a79;
col col7 format a79;
col col8 format a79;
col col9 format a79;


select 'create sequence '||sequence_owner||'.'||sequence_name         col2,
       '       increment by '||increment_by                           col3,
       '       start with '||last_number                              col4,
       '       maxvalue '||max_value                                  col5,
       '       minvalue '||min_value                                  col6,
       decode(cycle_flag,'Y','       cycle',
                         'N','       nocycle','error')                col7,
       decode(order_flag,'Y','       order',
                         'N','       noorder','error')                col8,
       decode(cache_size,0,'       nocache',
                           '       cache '||cache_size)||';'          col9
from dba_sequences
where sequence_owner like UPPER('&user_name')
order by sequence_owner,sequence_name
/

