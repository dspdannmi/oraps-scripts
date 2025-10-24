
PACKAGING
========

* build process encrypts files:
	openssl
	gpg
		export GNUPGHOME=/tmp/oragpg
                gpg --import /tmp/dsp-gpg.pub
                gpg --list-public-keys
                cat > /tmp/testfile
                gpg --encrypt --recipient support@dsp.co.uk /tmp/testfile
                ls -ald /tmp/testfile*
                file /tmp/testfile.gpg
                view /tmp/testfile.gpg


.tar file for Linux/Solaris/UNIX

.zip file for Windows

Scenarios:
* no root access

* no root access but client can run on our behalf
        install
		/opt/dsp	
		c:\dsp

* root access
	install
		/opt/dsp
		c:\dsp


* Direct or indirect connectivity to server
	* copy install files on to server

* No direct/indirect connectivity to server

INSTALL
=======

- when running serverstamp if there isn't already a serveridentity.txt file then dont give option of KEEP EXISTING id

- when not installing in to /opt/dsp we need to update lots of files for CS_TOP / DSP_TOP

- install.sh script looping when filesystem full


PRIORITY:  HIGH
===============

- add to HCs and miniHCs and getinfos to check for guaranteed restore points

- when modifying getinfo-ohome I found that scriptdir was not being set so set it again in funcs.sh ---> check this
- and also when modifying getinfo-chown I had to force ${scriptdir}/sql rather than just sql to avoid the $ORACLE_HOME/bin/sql being run

- create "dspmaint" script to:
	- set a self-removing flag for maintenance
	- prompt to ensure comms have been sent
	- prompt to ensure blackouts have been set
	- capture "before" state of server etc.

- pre-checks on server should inform if versionolock is installed

- DSP server checks:
	- following packages installed
		screen
		tmux
		rsync
		nc

- have a changelog for servers

- capture formsweb.cfg
- capture webutil.cfg

- if server = productin then put warning on db shutdown etc. commands
	- have a way to record config as to which databases are prod etc.
		- if server = prod then DB assumed prod unless config says otherwise


- $ORACLE_HOHE/bin/sql ---> SQLcl tool, which can interfere with our "sql" when $ORACLE_HOME/bin is earlier in the path

- using local /etc/oratab not as easy as it sounds
	- firstly, it is set in dsp.env therefore if it is updated hardcoded in there it will
	- get overwritten with new release of scripts
	- maybe need to check [ -f $CS_TOP/local/config/oratab ----> then use this]
	- also setting ORATAB in dsp.env is done twice... once at top and once when we check the OS (ie. solaris is in /var/opt/oratab)

- harbour energy had whitespace at beginning of /etc/oratab lines ... yuk

- create iscdb.sql script

- if i use setpdb at command line at prompt, when going in to SQL it lands me there but prompt doesn't initially show me

- I see Oracle cloud VMs SQL output using "|" as seperator (eg.  DSP19C|PHYSICAL STANDBY

- oratabxref should do a check that we are running as the correct user (eg. when running as root should give error that should run as oracle or whatever is deemed as correct user)
- oratabxref for each entry that it cant connect to the database based on entry should check if the sid is running.  Maybe means it is being started correctly just outside using $ORATAB file
- oratabxref check if there are any SIDs that are identical just different case (eg. mike vs MIKE)

XX_DONE_20251024_XX - dbscripts/oracle/chkoradbopen needs renaming as it just checks that the instance is running.  select user form dual returns SYS even if instance is mounted
XX_DONE_20251024_XX - which is fine as long as we know that when we are using it to check.  Rename to chkorainstanceup perhaps

- had a really good example whereby login.sql sets a whole heap of columns but then call script1 and it sets columns for itself and then I call script2 and columns are screwy
- was for column defined as "USED (%)" and was inappropriate as script1 used was in fact a percentage so set heading to "USED(%)" but in script2 used was an actual amount
- so because I didn't specifically set USED column in script two it was displayed as "USED(%)" which is misleading.  Moral is make sure individual SQL scripts set column
- headers themselves.  Dont assume anything other than the column may be poorly defined - or alternatively reset column headers for every sql script

- fix LISTSQL.sql so it works from sql*plus

- when I stamped EDW server selp2db01 it did not handle the double IP address well, prompted me with both on same line

- need to fix serverstamp so it reads config better and I have also renumbered categories so have introduced a bug

- not cleaning up tmpfiles ... important one

- make sure when interrogating/querying /etc/oratab that we only take entries that have characters/numbers in particular not *

- runalldbs could do somem better error checking and checking whether a database is in $ORATAB before setting the environment

- needing to export ALERTLOG.  Maybe don't export it and change tailalert etc. to be functions not scripts

- make it clear that on stamping the server to make sure to choose the most appropriate IP address, not any old one, make sure it's the pprimary IP address of the node and not floating ip address for exmaple

- serverstamp does not work properly on Oracle Linux 5

PRIORITY:  MEDIUM
===============

- make sure all func/* scripts have actually called the function name correctly as there have been occurrences where I have copied a function to a new file but didn't change function name

- change serverstamp to give an UKNOWN option and save that and then have ability to update unknown or indeed any config later:  serverstamp -update

- dbdown etc. might not be dispalying output of echoing commands to screen

- check worklog_202508 entry 20250812 - does not deal well with UofLeeds environment where no user $HOME set, including but not limited to every command gives error as can't write $HOME

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
- and need to consider forcing an "unsetenv" script to reverse things set

- add to oracle health check to check when dba_sequences > 95% and set with nocycle

- need more asm queries

- bug in servercheckstamp

- don't think dbversion is working correctly

- do some stuff with base64

- server info output

- funky validate /etc/oratab... are DBs in there that are not running?  Are there DBs running not in /etc/oratab?  Do all $O_H dirs exist and is there a $OH/bin/oracle executable

- add to capturer server identity.txt file a timestamp etc. to chuck in any ip addresses / mac addresses etc.  These might be useful if we do have a conflict/mistmatch at some point -
	maybe simply we remove a NIC but the VM is the same.  It would be useful to have _all_ of the ips and macs available as at stamping point so we can crosscheck

- add in templates for starting servers for oracle database and dbvisit

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



