
--DESCRIBE: list analyzed tables with un-analyzed indexes

/* ************************************************************* */
/* List analyzed tables with un-analyzed indexes                 */
/*                                                               */
/* Sometimes indexes are re-build for performance and            */
/* maintenance reasons but the assosiated table/index is not     */
/* re-ANALYZED. This can cause servere performance problems.     */
/* This script will catch out tables with indexes that is not    */
/* analyzed.                                                     */
/*                                                               */
/* ************************************************************* */

-- select distinct 'analyze table '||i.table_name||
--                ' estimate statistics sample 25 percent;'
select 'Index '||i.index_name||' not analyzed but table '||
       i.table_name||' is.'
  from user_tables t, user_indexes i
 where t.table_name    =      i.table_name
   and t.num_rows      is not null
   and i.distinct_keys is     null
/

