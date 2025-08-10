
PRIORITY:  HIGH
===============

- when I stamped EDW server selp2db01 it did not handle the double IP address well, prompted me with both on same line

- need to fix serverstamp so it reads config better and I have also renumbered categories so have introduced a bug

- not cleaning up tmpfiles ... important one

- make sure when interrogating/querying /etc/oratab that we only take entries that have characters/numbers in particular not *

PRIORITY:  MEDIUM
===============

- update end-of-life/support document and include a check for when it is deemed stale
- maybe include patch set numbers for main quarterly patches
- have a script to modify wget.sh from Oracle so it actcually works

- do i need to worry that /etc/machine-id I think was only available from Oracle Linux 7 / RHEL 7 onwards

- need a better way to source functions for scripts and interactive without them being hardcoded

- add -p switch to sql, runsql etc. such that if -d is not used then use existing ORACLE_SID and then set pdb based on -p to pdb

- do I need to track which users are associated as owners of each database

- if I run setenv -u dannmi, how can I clear that?

- review PROD_HOSTS, FPATH etc settings buried in setenv, probably shouldn't be there if required at all

- create documentation
	- building
	- installing
	- using
		different OS's
			Linux
			Windows
	- dbascripts
	- scripts

- seems to be an issue when you run setenv -u dannmi it sets the profile but then run it again it almost seems to reverse stuff out such as profile specific dirs in PATH

- add to oracle health check to check when dba_sequences > 95% and set with nocycle

- need more asm queries

- bug in servercheckstamp

- don't think dbversion is working correctly

- do some stuff with base64

- server info output

- funky validate /etc/oratab... are DBs in there that are not running?  Are there DBs running not in /etc/oratab?  Do all $O_H dirs exist and is there a $OH/bin/oracle executable

PRIORITY:  LOW
==============

- latest datasafe_privileges.sql

V$ASM_ACFSAUTORESIZE
V$ASM_ACFSREPL
V$ASM_ACFSREPLTAG
V$ASM_ACFSSNAPSHOTS
V$ASM_ACFSTAG
V$ASM_ACFSVOLUMES
V$ASM_ACFS_ENCRYPTION_INFO
V$ASM_ACFS_SECURITY_INFO
V$ASM_ACFS_SEC_ADMIN
V$ASM_ACFS_SEC_CMDRULE
V$ASM_ACFS_SEC_REALM
V$ASM_ACFS_SEC_REALM_FILTER
V$ASM_ACFS_SEC_REALM_GROUP
V$ASM_ACFS_SEC_REALM_USER
V$ASM_ACFS_SEC_RULE
V$ASM_ACFS_SEC_RULESET
V$ASM_ACFS_SEC_RULESET_RULE
V$ASM_ALIAS
V$ASM_ATTRIBUTE
V$ASM_AUDIT_CLEANUP_JOBS
V$ASM_AUDIT_CLEAN_EVENTS
V$ASM_AUDIT_CONFIG_PARAMS
V$ASM_AUDIT_LAST_ARCH_TS
V$ASM_AUDIT_LOAD_JOBS
V$ASM_CACHE_EVENTS
V$ASM_CLIENT
V$ASM_DBCLONE_INFO
V$ASM_DISK
V$ASM_DISKGROUP
V$ASM_DISKGROUP_SPARSE
V$ASM_DISKGROUP_STAT
V$ASM_DISK_IOSTAT
V$ASM_DISK_IOSTAT_SPARSE
V$ASM_DISK_SPARSE
V$ASM_DISK_SPARSE_STAT
V$ASM_DISK_STAT
V$ASM_ESTIMATE
V$ASM_FILE
V$ASM_FILEGROUP
V$ASM_FILEGROUP_FILE
V$ASM_FILEGROUP_PROPERTY
V$ASM_FILESYSTEM
V$ASM_OPERATION
V$ASM_QUOTAGROUP
V$ASM_TEMPLATE
V$ASM_USER
V$ASM_USERGROUP
V$ASM_USERGROUP_MEMBER
V$ASM_VOLUME
V$ASM_VOLUME_STAT



