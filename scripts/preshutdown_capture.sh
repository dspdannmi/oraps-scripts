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

USAGE_STRING="[-o]"

SHOW_OUTPUT=NO

#
# function header()
#     display a different message for each check depending on whether
#     output from the commands is chosen to be output or not. 
#     essentially gives a brief indication of the check if output is
#     not being displayed and a chunkier output with over-lines and 
#     underlines if output is being displayed
function header()
    {
    if [ "${SHOW_OUTPUT}" = "YES" ]
    then
         echo ""
         echo "======================================"
         echo "${*}"
         echo "======================================"
         echo ""
    else
         echo "capturing: ${*}"
    fi
    }


while getopts 'o' OPTION
do
    case "$OPTION" in
        o) SHOW_OUTPUT=YES ;;
        ?) usage ;;
    esac
done

#
# Determine if we are dumping output to the screen
#
if [ "${SHOW_OUTPUT}" = "YES" ]
then
    output_device=/dev/stdout
else
    output_device=/dev/null
fi




if [ "${thisuser}" != "root" ]
then
    echo "WARNING: It is beneficial for this script to run as root"
    echo ""
    echo "current user: [${thisuser}]"
    echo ""
    echo "Press <ENTER> to continue to <ctrl-C> to abort!!!"
    read userinput
fi


#
# pending:
# 	crontab entries
#	what filesystems are CIFS / NFS mounted
#	$ORACLE_HOME/network/admin/*.ora files
#	wallets(?)
#


echo
echo "----------------------------------------"
echo "Current system time: $(date)"
now=$(date +%Y%m%d_%H%M%S)
echo "----------------------------------------"
echo
#
# setup capture directory in current directory
#
DIR=${scriptname}.${now}

mkdir ${DIR}
status=$?

if [ $status -ne 0 ]
then
    echo "ERROR: could not create directory [${DIR}] in local directory - exiting"
    exit 1
fi

mkdir ${DIR}/files
status=$?

if [ $status -ne 0 ]
then
    echo "ERROR: could not create directory [${DIR}/files] in local directory - exiting"
    exit 1
fi

cd ${DIR}
status=$?

if [ $status -ne 0 ]
then
    echo "ERROR: could not change directory to [${DIR}] - exiting"
    exit 1
fi



#
# need human intervention in whether the time, date and timezone are
# correct or at least as expected
#
answer=""
while [ "${answer}" = "" ]
do
    echo "Does this match expected? (Y/N)"
    read userinput

    case "${userinput}" in
        [yY][eE][sS]|[yY])	answer="YES" ;;
        [nN][oO]|[nN])		answer="NO" ;;
        *)			answer="" ;;
    esac
done

if [ "${answer}" = "YES" ]
then
    echo "$(date): time is GOOD" | tee systemclockstatus.out > ${output_device}
else
    echo "Please make a note of the time/timezone discrepancy"
    echo "$(date): time is NOT GOOD" | tee systemclockstatus.out > ${output_device}
fi


echo 
echo "===================================================="
echo "OS capture $(date)"
echo "===================================================="



header hostname
#---------------------------------------------------------------
hostname 2>&1 | tee hostname.out > ${output_device}

#---------------------------------------------------------------
header hostname -I
hostname -I 2>&1 | tee hostname-I.out > ${output_device}

#---------------------------------------------------------------
header ip addresses
showipaddrs 2>&1 | tee ipaddrs.out > ${output_device}

#---------------------------------------------------------------
header mac addresses
showmacaddrs 2>&1 | tee macaddrs.out > ${output_device}

#---------------------------------------------------------------
header various files
cat /dev/null > files.out

for file in /etc/dnf/plugins/versionlock.conf \
            /etc/dnf/plugins/versionlock.list \
            /etc/yum/plugins/versionlock.conf \
            /etc/yum/plugins/versionlock.list \
            /etc/fstab \
            /etc/hosts \
	    /etc/passwd \
	    /etc/group \
	    /etc/sysctl.conf \
	    /etc/oratab \
	    /var/opt/oratab \
	    /etc/resolv.conf \
	    /etc/sudo.conf \
	    /etc/chrony.conf \
	    /etc/ntp.conf \
	    /etc/yum.conf \
	    /etc/dnf.conf \
	    /etc/sestatus.conf \
	    /proc/cpuinfo \
	    /proc/meminfo \
            /etc/sysconfig/network-scripts \
            /var/spool/cron
do

  dir=$(dirname ${file})

  if [ -d $file ]
  then
      mkdir -p files/${dir} && cp -rp ${file} files/${file}
      ls -ald ${file} >> files.out
  elif [ -f $file ]
  then
    if [ -r $file ]
    then
      echo "    file: ${file}"

      mkdir -p files/${dir} && cp -p ${file} files/${file}
      status=$?

      ls -ald ${file} >> files.out
    else
        echo "    file: ${file} <NOT READABLE - skipping>"
    fi
  else
    echo "    file: ${file} <does not exist - skipping>"
  fi
done


#---------------------------------------------------------------
header grubby
(
grubby --default-index
grubby --default-title
) | tee grubby.out > ${output_device}

#---------------------------------------------------------------
header needs-restarting -r
needs-restarting -r | tee needs-restarting-r.out > ${output_device}

#---------------------------------------------------------------
header needs-restarting -s
needs-restarting -s | tee needs-restarting-s.out > ${output_device}

#---------------------------------------------------------------
header last
last | tee last.out > ${output_device}

#---------------------------------------------------------------
header /boot
(
ls -al /boot
echo "-----------------------------------------------------"
find /boot | xargs ls -ald
) | tee _boot-contents.out > ${output_device}


#---------------------------------------------------------------
header netstat-an
netstat -an 2>&1 | tee netstat-an.out > ${output_device}

#---------------------------------------------------------------
header df-h
df -h 2>&1 | tee df-h.out > ${output_device}

#---------------------------------------------------------------
header ps-ef
ps -ef 2>&1 | tee ps-ef.out > ${output_device}

#---------------------------------------------------------------
header uptime
uptime 2>&1 | tee uptime.out > ${output_device}

#---------------------------------------------------------------
header uname-a
uname -a 2>&1 | tee uname-a.out > ${output_device}

#---------------------------------------------------------------
header uname
uname 2>&1 | tee uname.out > ${output_device}

#---------------------------------------------------------------
header getenforce
getenforce 2>&1 | tee getenforce.out > ${output_device}

#---------------------------------------------------------------
header sestatus
sestatus 2>&1 | tee sestatus.out > ${output_device}

#---------------------------------------------------------------
header ip a
ip a 2>&1 | tee ip-a.out > ${output_device}

#---------------------------------------------------------------
header mount
mount 2>&1 | tee mount.out > ${output_device}

#---------------------------------------------------------------
header netstat -ar
netstat -ar 2>&1 | tee netstat-ar.out > ${output_device}

#---------------------------------------------------------------
header netstat-tulpn
netstat -tulpn 2>&1 | tee netstat-tulpn.out > ${output_device}

#---------------------------------------------------------------
header ipcs
ipcs 2>&1 | tee ipcs.out > ${output_device}


#---------------------------------------------------------------
header service--status-all
service --status-all 2>&1 | tee service--status-all.out > ${output_device}

#---------------------------------------------------------------
header systemctl status
systemctl status 2>&1 | tee systemctl-status.out > ${output_device}

#---------------------------------------------------------------
header check-update
dnf check-update 2>&1 | tee dnf-check-update.out > ${output_device}

#---------------------------------------------------------------
header rpm-qa
rpm -qa | sort 2>&1 | tee rpm-qa.out > ${output_device}

#---------------------------------------------------------------
header rpm-qa--last
rpm -qa --last 2>&1 | tee rpm-qa--last.out > ${output_device}

#---------------------------------------------------------------
header "vgs (volume groups)"
vgs 2>&1 | tee vgs.out > ${output_device}

#---------------------------------------------------------------
header "lvs (logical volumes)"
lvs 2>&1 | tee lvs.out > ${output_device}

#---------------------------------------------------------------
header "pvs (physical volumes)"
pvs 2>&1 | tee pvs.out > ${output_device}

echo
echo "===================================================="
echo





