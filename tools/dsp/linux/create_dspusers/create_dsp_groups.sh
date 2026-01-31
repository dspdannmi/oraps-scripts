#!/bin/bash

#+++___________________________________________________________________________________
#
#
# Script name:                  create_dsp_groups.sh
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
#       30-Jan-2026     1.0     root    Original version
#
#+++___________________________________________________________________________________

CS_TOP=/opt/dsp
. ${CS_TOP}/env/dsp.env
. ${CS_TOP}/env/funcs.sh

USAGE_STRING=""

if [ "${DSP_WHOAMI}" != "root" ]
then
    echo "ERROR: effective ID [${DSP_WHOAMI}] but needs to be [root] - exiting"
    EXITCODE=1
    exit ${EXITCODE}
fi



#
# Define local script variables
#

#
# Script starts here
#
#
set_error_trap

# create groups
#
echo
echo "--------------------------------"
echo "Creating groups"
echo "--------------------------------"

echo
echo "group: ${DSP_ADMIN_USER_GROUP}"
if grep ^${DSP_ADMIN_USER_GROUP}: /etc/group 2>&1 > /dev/null
then
    echo "ignoring [${DSP_ADMIN_USER_GROUP}]... already exists!"
else
    groupadd -g ${DSP_ADMIN_USER_GROUP_UID} ${DSP_ADMIN_USER_GROUP}
    status=$?
fi

echo
echo "group: ${DSP_STD_USER_GROUP}"
if grep ^${DSP_STD_USER_GROUP}: /etc/group 2>&1 > /dev/null
then
    echo "ignoring [${DSP_STD_USER_GROUP}]... already exists!"
else
    groupadd -g ${DSP_STD_USER_GROUP_UID} ${DSP_STD_USER_GROUP}
    status=$?
fi

echo
echo "group: ${DSP_AUDIT_USER_GROUP}"
if grep ^${DSP_AUDIT_USER_GROUP}: /etc/group 2>&1 > /dev/null
then
    echo "ignoring [${DSP_AUDIT_USER_GROUP}]... already exists!"
else
    groupadd -g ${DSP_AUDIT_USER_GROUP_UID} ${DSP_AUDIT_USER_GROUP}
    status=$?
fi


#
# update sudoers file
#
echo
echo "--------------------------------"
echo "Configuring sudo"
echo "--------------------------------"

sudoers_file=/etc/sudoers
if [ -f ${sudoers_file} ]
then
    if ! grep "^%${DSP_ADMIN_USER_GROUP} ALL" ${sudoers_file} 2>&1 > /dev/null
    then
        echo "adding ${DSP_ADMIN_USER_GROUP} to [${sudoers_file}]"
        bkupfile=${sudoers_file}.$(date +%Y%m%d)

        [ -f ${bkupfile} ] && bkupfile=${sudoers_file}.$(date +%Y%m%d_%H%M)
        [ -f ${bkupfile} ] && bkupfile=${sudoers_file}.$(date +%Y%m%d_%H%M%S)
        [ -f ${bkupfile} ] && bkupfile=${sudoers_file}.$(date +%Y%m%d_%H%M%S).${$}

        cp -p ${sudoers_file} ${bkupfile}
        status=$?

        if [ $status -eq 0 ]
        then
            echo "%dspadmuser ALL = (ALL) NOPASSWD:ALL" >> ${sudoers_file}
            status=$?
        else
            echo "ERROR: could not backup [${sudoers_file}] to [${bkupfile}] - exiting"
            EXITCODE=1
            exit ${EXITCODE}
        fi

    else
        echo "nothing to do - configuration exists!"
    fi
else
    echo "ERROR: suders file does not exist - dont know what to do - exiting"
    EXITCODE=1
    exit ${EXITCODE}
fi

echo
echo "--------------------------------"
echo "Configuring SSH"
echo "--------------------------------"

sshd_config_file=/etc/ssh/sshd_config
if [ -f ${sshd_config_file} ]
then
    if ! grep "^Match group dsp\*" ${sshd_config_file} 2>&1 > /dev/null
    then
        echo "adding DSP user groups to [${sshd_config_file}]"
        bkupfile=${sshd_config_file}.$(date +%Y%m%d)

        [ -f ${bkupfile} ] && bkupfile=${sshd_config_file}.$(date +%Y%m%d_%H%M)
        [ -f ${bkupfile} ] && bkupfile=${sshd_config_file}.$(date +%Y%m%d_%H%M%S)
        [ -f ${bkupfile} ] && bkupfile=${sshd_config_file}.$(date +%Y%m%d_%H%M%S).${$}

        echo ""                  >> ${sshd_config_file}
        echo "#allow DSP groups" >> ${sshd_config_file}
        echo "Match group dsp*"  >> ${sshd_config_file}
        echo "    AllowUsers *"  >> ${sshd_config_file}
        echo ""                  >> ${sshd_config_file}
        status=$?

        echo
        echo "========================================="
        echo "IMPORTANT:  restart SSHD daemon"
        echo "========================================="
        echo ""

    else
        echo "nothing to do - configuration exists!"
    fi
else
    echo "ERROR: suders file does not exist - dont know what to do - exiting"
    EXITCODE=1
    exit ${EXITCODE}
fi

echo

exit $EXITCODE

