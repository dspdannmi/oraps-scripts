
=================================================================
operating system (Thu 21 Aug 23:45:47 BST 2025)
=================================================================

time              : 20250821_234547_BST

hostname          : orarac01.prod.dannmi.com
dspserverid:      : 7a9b5106-7cd5-4f58-8485-89033ab5bb8c

machine-id        : fc306125bc16464bb56ec80200900b68
hostid            : 020a9700

server type       : Virtual Machine (on-prem)(OLVM / KVM hypervisor)
db hosting        : Oracle database(s)

environments      : PRODUCTION + development + test

kernel_name       : Linux
nodename          : orarac01.prod.dannmi.com
kernel_release    : 5.15.0-311.185.9.el8uek.x86_64
kernel_version    : #2 SMP Wed Jul 30 05:22:09 PDT 2025
machine           : x86_64
processor         : x86_64
hardware_platform : x86_64
operating_system  : GNU/Linux

virtualisation    : YES (KVM)

cpu count         : 4
memory            : 445Mi (free) /  1.6Gi (total)
swap              : 8Gi

uptime            : 1 days, 02h 21m 07s
last boot         : 2025-08-20 21:06:55
load avgs         : 0.00 (1 min) 0.00 (5 mins) 0.00 (15 mins)
ip addrs          : 10.2.0.151
                    10.2.0.152
mac addrs         : 56:6f:7c:c0:00:08
		    56:6f:7c:c0:00:1c


Filesystems       :
        Filesystem           Size  Used Avail Use% Mounted on
        devtmpfs             818M     0  818M   0% /dev
        tmpfs                839M     0  839M   0% /dev/shm
        tmpfs                839M  8.7M  830M   2% /run
        tmpfs                839M     0  839M   0% /sys/fs/cgroup
        /dev/mapper/ol-root   26G  3.8G   23G  15% /
        /dev/mapper/ol-home   10G  104M  9.9G   2% /home
        /dev/sdc1             40G  9.0G   31G  23% /u01
        /dev/mapper/ol-tmp    10G  104M  9.9G   2% /tmp
        /dev/sda1           1014M  499M  516M  50% /boot
        tmpfs                168M     0  168M   0% /run/user/0



=================================================================
UIM monitoring
=================================================================

/opt/nimbus exists:	NO
nimbus service running: YES



=================================================================
ORACLE DATABASE
=================================================================

-------------------
grid infrastructure
-------------------

installed:		YES
grid home:		/u01/app/19.0.0
grid base:		/u01/app/grid


-----------------------
oracle database home(s)
-----------------------

/u01/app/oracle/product/19.0.0/dbhome_1
    owner:     oracle
    version:   19.3
    edition:   standard edition

/u01/app/oracle/product/12.1.0.2/dbhome_1
    owner: 	oracle
    version:    12.1.0.2
    edition:    enterprise edition



------------------
oracle listener(s)
------------------

LISTENER:
	oracle_home:	/u01/app/oracle/product/19c/dbhome_1
	owner:		oracle
	version:	19.3


------------------
oracle database(s)
------------------

DSP19C:
	oracle_home:    /u01/app/oracle/product/19.0.0/dbhome_1
        version:        19.3
        edition:        standard edition
	db_unique_name: DSP19C_PRIMARY
	open mode:	OPEN (READ-WRITE)
	RAC:		NO
	data guard:	YES [PRIMARY]
        log_mode:       ARCHIVELOG
        flashback_on:   YES
        forced_logging: YES
        arch. lag tgt:  900

MIKE12C:
	oracle_home:	/u01/app/oracle/product/12.1.0.2/dbhome_1
        version:        19.3
        edition:        standard edition
	db_unique_name: MIKE19C
	open mode:	MOUNTED
	RAC:		NO
	data guard:	YES [STANDBY]
        log_mode:       ARCHIVELOG
        flashback_on:   YES
        forced_logging: YES
        arch. lag tgt:  900

GEORGE19C:
	oracle_home:	/u01/app/oracle/product/19.0.0/dbhome_1
        version:        19.3
        edition:        standard edition
	db_unique_name: GEORGE19C_DC1
	open mode:	MOUNTED
	RAC:		NO
	data guard:	YES [STANDBY]
        log_mode:       ARCHIVELOG
        flashback_on:   YES
        forced_logging: YES
        arch. lag tgt:  900



