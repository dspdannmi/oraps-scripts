
--DESCRIBE: NO LONGER REQD

drop table ar.stats_26112002;

exec dbms_stats.create_stat_table('AR','STATS_26112002');

exec dbms_stats.export_table_stats('AR','AR_STATEMENT_HEADERS',NULL,-
		'STATS_26112002','TRUE');

exec dbms_stats.export_table_stats('AR','AR_STATEMENT_LINE_CLUSTERS',NULL,-
		'STATS_26112002','TRUE');

exec dbms_stats.export_table_stats('AR','AR_ADJUSTMENTS',NULL,-
		'STATS_26112002','TRUE');
