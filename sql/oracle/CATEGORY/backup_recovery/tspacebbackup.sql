
--DESCRIBE: place tablespace in backup mode

define tspace_name='&1'

rem
rem Decision has been taken not to explicitly archive the current
rem log after ending a tablespace backup due to the large number
rem of possible tablespaces in a given database
rem The script bbackup and ebackup that place all tablespaces in
rem and out of backup mode at the same time do archive the current
rem log
rem

alter tablespace &tspace_name begin backup;
