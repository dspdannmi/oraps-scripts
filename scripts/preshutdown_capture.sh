#!/bin/bash

#+++___________________________________________________________________________________
#
#
# Script name:                  runlater
#
# Description:
#
# Parameters:
#
# Environment:
#
# Return codes:
#
# Modification history:
#
#       09-Oct-2003     1.0     oracle    Original version
#
#+++___________________________________________________________________________________

. /opt/dsp/env/dsp.env
. /opt/dsp/env/funcs.sh


#
# pending:
# 	crontab entries
#	what filesystems are CIFS / NFS mounted
#	$ORACLE_HOME/network/admin/*.ora files
#	wallets(?)
#


now=$(date +%Y%m%d_%H%M%S)

netstat -an 2>&1 | tee netstat-an.out.${now}
df -h 2>&1 | tee df-h.out.${now}
ps -ef 2>&1 | tee ps-ef.out.${now}
uname -a 2>&1 | tee uname-a.out.${now}
uname 2>&1 | tee uname.out.${now}
getenforce 2>&1 | tee getenforce.out.${now}
sestatus 2>&1 | tee sestatus.out.${now}
ip a 2>&1 | tee ip-a.out.${now}
mount 2>&1 | tee mount.out.${now}
netstat -ar 2>&1 | tee netstat-ar.out.${now}
netstat -tulpn 2>&1 | tee netstat-tulpn.out.${now}
ipcs 2>&1 | tee ipcs.out.${now}
service --status-all 2>&1 | tee service--status-all.out.${now}
systemctl status 2>&1 | tee systemctl-status.out.${now}
rpm -qa | sort 2>&1 | tee rpm-qa.out.${now}
rpm -qa --last 2>&1 | tee rpm-qa--last.out.${now}

vgs 2>&1 | tee vgs.out.${now}
lvs 2>&1 | tee lvs.out.${now}
pvs 2>&1 | tee pvs.out.${now}

cat /proc/cpuinfo > cpuinfo.out.${now}
cat /proc/meminfo > meminfo.out.${now}


