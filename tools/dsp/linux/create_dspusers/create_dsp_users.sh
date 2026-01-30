#!/bin/bash

#+++___________________________________________________________________________________
#
#
# Script name:                  create_all_users.sh
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

if [ "${DSP_WHOAMI}" != "root" ]
then
    echo "ERROR: effective ID [${DSP_WHOAMI}] but needs to be [root] - exiting"
    EXITCODE=1
    exit ${EXITCODE}
fi

USAGE_STRING=""

#DSP_ADMIN_USER_GROUP=dspadmuser
#DSP_STD_USER_GROUP=dspuser
#DSP_USERNAME_PREFIX="dsp."
#DSP_USERS_RESOURCE_TOPDIR=${CS_TOP}/resources/dspusers
#DSP_USERS_FILE=${DSP_USERS_RESOURCE_TOPDIR}/dspusers.lst

if [ ! -d ${DSP_USERS_RESOURCE_TOPDIR} ]
then
    echo "ERROR: DSP_USERS resource topdir [${DSP_USERS_RESOURCE_TOPDIR}] does not exist - exiting"
    EXITCODE=1
    exit ${EXITCODE}
fi

if [ ! -f ${DSP_USERS_FILE} ]
then
    echo "ERROR: DSP_USERS_FILE [${DSP_USERS_FILE}] does not exist or not readable - exiting"
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

#
# validate DSP groups exists first
#
if ! grep ^dspadmuser: /etc/group 2>&1 > /dev/null
then
    echo "ERROR: DSP admin group [${DSP_ADMIN_USER_GROUP}] does not exist - exiting"
    EXITCODE=1
    exit ${EXITCODE}
fi

if ! grep ^${DSP_STD_USER_GROUP} /etc/group 2>&1 > /dev/null
then
    echo "ERROR: DSP standard user group [${DSP_STD_USER_GROUP}] does not exist - exiting"
    EXITCODE=1
    exit ${EXITCODE}
fi


#
# create DSP users if they do not already exist
#
grep -v ^# ${DSP_USERS_FILE} | while read LINE
do
    uid=$(echo ${LINE} | awk -F: '{print $1}')

    group=$(echo ${LINE} | awk -F: '{print $2}')

    user=$(echo ${LINE} | awk -F: '{print $3}')
    username=${DSP_USERNAME_PREFIX}${user}
    homedir=/home/${username}
    sshdir=${homedir}/.ssh
    authkeysfile=${sshdir}/authorized_keys
    pubkeyfile=${DSP_USERS_RESOURCE_TOPDIR}/keys/${username}.pub

    comment=$(echo ${LINE} | awk -F: '{print $4}')

    echo 
    echo "-------------------------------------------------------------"
    echo "username:    ${username}"
    echo "-------------------------------------------------------------"
    if grep ^${username}: /etc/passwd 2>&1 > /dev/null
    then
        echo "    already exists... skipping!"
    else
        echo "    ************"
        echo "    * CREATING *"
        echo "    ************"
        useradd -g ${group} -u ${uid} -c "${comment}" ${username}
        status=$?
    fi

    if [ -d ${homedir} ]
    then
        if [ ! -d ${sshdir} ]
        then
            mkdir -m 700 ${sshdir}
            status=$?

            if [ $status -eq 0 ]
            then
                chown ${username}:${group} ${sshdir}
                status=$?

                if [ $status -ne 0 ]
                then
                    echo "***WARNING: encountered error changing ownership [${username}:${group}]"
                    EXITCODE=1
                fi
            else
                echo "***WARNING: encountered error creating directory [${sshdir}]"
                EXITCODE=1
            fi
        fi #sshdir

        if [ ! -f ${authkeysfile} ]
        then
            touch ${authkeysfile} && chmod 600 ${authkeysfile} && chown ${username}:${group} ${authkeysfile}
            status=$?

            if [ $status -eq 0 ]
            then
                :
            else
                echo "***WARNING: home directory [${homedir}] does not exist as expected ***"
                EXITCODE=1
            fi
        fi

        #
        # check if public key is already in authorized_keys file
        #
        if ! grep -f ${DSP_USERS_RESOURCE_TOPDIR}/keys/${username}.pub ${authkeysfile} 2>&1 > /dev/null
        then
            echo "    adding public key"

            # backup
            bkupfile=${authkeysfile}.$(date +%Y%m%d)

            [ -f ${bkupfile} ] && bkupfile=${authkeysfile}.$(date +%Y%m%d_%H%M)
            [ -f ${bkupfile} ] && bkupfile=${authkeysfile}.$(date +%Y%m%d_%H%M%S)
            [ -f ${bkupfile} ] && bkupfile=${authkeysfile}.$(date +%Y%m%d_%H%M%S).${$}

            cp -p ${authkeysfile} ${bkupfile}
            status=$?

            if [ $status -eq 0 ]
            then
                cat ${pubkeyfile} >> ${authkeysfile}
                status=$?
            else
                echo "ERROR: could not backup [${authkeysfile}] to [${bkupfile}] - exiting"
                EXITCODE=1
                exit ${EXITCODE}
            fi

        else
            echo "    public key already in authorized keys... skipping!"
        fi
        status=$?
    else
        echo "***WARNING: home directory [${homedir}] does not exist as expected ***"
        EXITCODE=1
    fi
done

echo

exit $EXITCODE

