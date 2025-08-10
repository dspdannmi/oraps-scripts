
--DESCRIBE: show current system statistics from aux_stats$

col pval2 format a40

select * from aux_stats$
order by 1;
