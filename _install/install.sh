#!/bin/bash

#+++___________________________________________________________________________________
#
#
# Script name:                  install.sh
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
#       15-Oct-2025     1.0     root    Original version
#
#+++___________________________________________________________________________________

DSP_TOP=/opt/dsp

USAGE_STRING=""

OS=$(uname)
user=$(whoami)

DSP_DIR=dsp

DEFAULT_INSTALL_DIR_ROOT=/opt/${DSP_DIR}
DEFAULT_INSTALL_DIR_NONROOT=$HOME/${DSP_DIR}
#INSTALL_DIR=${DEFAULT_INSTALL_DIR_ROOT}

DEFAULT_OWNER="oracle"
DEFAULT_GROUP="oinstall"

KEEP_TRYING="YES"

#
# Define local script variables
#

function install_root_default_dir_exists
    {
    echo "Yeeha!"
    }


function get_current_version
    {
    if [ -r ${VERSION_FILE} ]
    then
        CURRENT_VERSION=$(cat ${VERSION_FILE})
    else
        CURRENT_VERSION=""
    fi
    }



function set_install_vars
    {
    CONFIG_DIR=${INSTALL_DIR}/config/dsp

    VERSION_FILE=${CONFIG_DIR}/version.txt
    OWNER_FILE=${CONFIG_DIR}/owner.txt
    IDENTITY_FILE=${CONFIG_DIR}/identity.txt

    if [ -r ${OWNER_FILE} ]
    then
        INSTALL_OWNER=$(cat ${OWNER_FILE} | cut -d: -f1)
        INSTALL_GROUP=$(cat ${OWNER_FILE} | cut -d: -f2)
    else
        INSTALL_OWNER=""
        INSTALL_GROUP=""
    fi

    INSTALL_DIR_EXISTS=no	#failsafe approach - assume install dir does not exist
				#until determined otherwise later

    if [ -d ${INSTALL_DIR} ]
    then
        INSTALL_DIR_EXISTS=yes
    else
        INSTALL_DIR_EXISTS=no
    fi

    if [ -r ${INSTALL_DIR_VERSION_FILE} ]
    then
        INSTALL_DIR_VERSION_FILE_EXISTS=yes
    else
        INSTALL_DIR_VERSION_FILE_EXISTS=no
    fi
    
    if [ -r ${INSTALL_DIR_OWNER_FILE} ]
    then
        INSTALL_DIR_OWNER_FILE_EXISTS=yes
    else
        INSTALL_DIR_OWNER_FILE_EXISTS=no
    fi

    get_current_version
    }


function fresh_install_post_steps
    {
    echo "Wooohoo! Freshy! :)"
    }


function get_install_owner_and_group
    {
    if [ "${user}" = "root" ]
    then
      #
      # run as root so let us ask for preferred user and group
      #
      LOOP=yes
      while [ "${LOOP}" = "yes" ]
      do
        echo "User to own this installation: [${DEFAULT_OWNER}]"
        read userinput

        if [ "${userinput}" = "" ]
        then
            INSTALL_OWNER=${DEFAULT_OWNER}
        else
            INSTALL_OWNER=${userinput}
        fi

        if grep ${INSTALL_OWNER}: /etc/passwd 2>&1 > /dev/null
        then
            LOOP=no
        else
            echo "User [${INSTALL_OWNER}] not a valid user - try again"
        fi
      done

      LOOP=yes
      while [ "${LOOP}" = "yes" ]
      do
        echo "Group to own this installation: [${DEFAULT_GROUP}]"
        read userinput
    
        if [ "${userinput}" = "" ]
        then
            INSTALL_GROUP=${DEFAULT_GROUP}
        else
            INSTALL_GROUP=${userinput}
        fi

        if grep ${INSTALL_GROUP}: /etc/group 2>&1 > /dev/null
        then
            LOOP=no
        else
            echo "User [${INSTALL_GROUP}] not a valid user - try again"
        fi
      done
    else
      LOOP=yes
      while [ "${LOOP}" = "yes" ]
      do
        #
        # run as non-root so let us get user and group from current user
        #
        INSTALL_OWNER=${user}
        INSTALL_GROUP=$(id -ng)

        LOOP=no
       done
    fi
    }


function do_install
    {
    if [ "${INSTALL_OWNER}" = "" ] || [ "${INSTALL_GROUP}" = "" ]
    then
        get_install_owner_and_group
    fi

    if [ "${NEW_VERSION}" = "${CURRENT_VERSION}" ] 
    then
        version_suffix="<<< same as current <<<"
    fi
    
    echo
    echo "--------------------------------"
    echo "Installation:"
    echo "--------------------------------"
    echo
    echo "Install directory:    [${INSTALL_DIR}]"
    echo
    echo "New version:          [${NEW_VERSION}] ${version_suffix}"
    echo
    echo "Install owner:        [${INSTALL_OWNER}]"
    echo "Install group:        [${INSTALL_GROUP}]"
    echo
    
    if [ "${NEW_VERSION}" = "${CURRENT_VERSION}" ]
    then
        echo  "*************************************************"
        echo  "*  WARNING: version already installed           *"
        echo  "*************************************************"
    elif [[ "${NEW_VERSION}" < "${CURRENT_VERSION}" ]]
    then
        echo  "*************************************************"
        echo  "*  WARNING: installed version is later          *"
        echo  "*************************************************"
    fi

    echo -n "Do you wish to proceed with installation?  (<ENTER> to continue <ctrl-C> to abort)"
    echo
    read userinput

    #continuing with install

    if [ ! -w ${INSTALL_DIR} ] || [ ! -d ${INSTALL_DIR} ]
    then
         echo "ERROR: unexpected error at this stage - install directory [${INSTALL_DIR}] does not exist or is not writeable - exiting"
         exit 1
    fi

    if [ ! -r ${NEW_INSTALL_FILE} ]
    then
         echo "ERROR: unexpected error at this stage - install file [${NEW_INSTALL_FILE}] does not exist or is not writeable - exiting"
         exit 1
    fi

    CURRENT_VERSION_SAVE=${CURRENT_VERSION}

    echo "Extracting [${NEW_INSTALL_FILE}] into [${INSTALL_DIR}]..."

    # add a sleep otherwise the silent extract is quite quick it may feel to some
    # that nothing has happened - would prefer not to run tar with v (verbose) option
    # as that generates a lot of output
    sleep 2

    tar -C ${INSTALL_DIR} -zxvf ${NEW_INSTALL_FILE}
    status=$?
    
    if [ $status -eq 0 ]
    then
        KEEP_TRYING=no

        get_current_version

        echo
        echo "----------"
        echo "SUCCESS!!!"
        echo "----------"
        echo

        echo "Previous version:       [${CURRENT_VERSION_SAVE}]"
        echo "Current version:        [${CURRENT_VERSION}]"
        echo

        [ ! -f ${IDENTITY_FILE} ] && fresh_install_post_steps

    else
        echo "ERROR: an error occurred extracting - exiting"
        status=$?
    fi
    }

function existing_installation_found_prologue
    {
    echo
    echo "--------------------------------"
    echo "Pre-existing installation found:"
    echo "--------------------------------"
    echo
    echo "Directory:            [${INSTALL_DIR}]"
    echo
    echo "Version:              [${CURRENT_VERSION}]"
    echo
    echo "Configured owner:     [${INSTALL_OWNER}]"
    echo "Configured group:     [${INSTALL_GROUP}]"
    echo
    }

function confirm_run_as_nonroot
    {
    echo "You are running as non-root user [${user}]"
    echo "It is recommended to run this install script as [root] - press <ENTER> to continue or <ctrl-C> to abort"
    read userinput
    }


#
#---------------------------------------------------------------
# Script starts here
#---------------------------------------------------------------
#


#---------------------------------------------------------------
# initial checks
#---------------------------------------------------------------
#
if [ "${OS}" != "Linux" ]
then
    echo "ERROR: Expecting OS [Linux] but found [${OS}] - exiting"
    exit 1
fi


FRESH_INSTALL=yes	# assume fresh install until determined otherwise

NEW_INSTALL_VERSION_FILE=version.txt
BANNER_FILE=banner.txt

if [ ! -r ${NEW_INSTALL_FILE} ]
then
    echo "ERROR: install file [${NEW_INSTALL_FILE}] does not exist or is not readable in current directory - exiting"
    exit 1
fi

if [ -r ${NEW_INSTALL_VERSION_FILE} ]
then
    NEW_VERSION=$(cat ${NEW_INSTALL_VERSION_FILE})
else
    echo "ERROR: install file [${NEW_INSTALL_VERSION_FILE}] does not exist or is not readable in current directory - exiting"
    exit 1
fi

NEW_INSTALL_FILE=dsp-${NEW_VERSION}.tar.gz

if [ ! -r ${NEW_INSTALL_FILE} ]
then
    echo "ERROR: install file [${NEW_INSTALL_FILE}] does not exist or is not readable in current directory - exiting"
    exit 1
fi

#
#---------------------------------------------------------------
#set and check default location and associated files
#---------------------------------------------------------------
#


# if id=root + NO EXIST /opt/dsp then = suggest installilng /opt/dsp
# if id=root + /opt/dsp does not exist then install and create it (optionally ask for a different location)
# if id=root + /opt/dsp exists + version.txt file exists where expected then install there using owner.txt to change ownership
# if id != root + /opt/dsp exists + version.txt file exists where expected + id = owner.txt then install in /opt/dsp
# if id != root + $HOME/dsp exists + version.txt file exists where expected + id = owner.txt then install in $HOME/dsp
# all options exhausted

if [ -r ${BANNER_FILE} ]
then
    sed -e "s/%%VERSION%%/${NEW_VERSION}/" ${BANNER_FILE}
fi

INSTALL_DIR=${DEFAULT_INSTALL_DIR_ROOT}
set_install_vars

if [ "${user}" = "root" ]
then
    : # do nothing, INSTALL_DIR already set correctly
else
    if [ -w ${INSTALL_DIR} ]
    then
        : # looks like we have a default install already not under $HOME
          # so even though running as non-root we may still be able to install
          # it there
    else
echo X=$INSTALL_DIR
        INSTALL_DIR=${DEFAULT_INSTALL_DIR_NONROOT}
 
        echo $INSTALL_OWNER
        echo $INSTALL_GROUP
        echo $INSTALL_DIR_EXISTS
			

        echo $INSTALL_DIR_VERSION_FILE_EXISTS
        echo $INSTALL_DIR_OWNER_FILE_EXISTS

        echo EE ; exit
    fi
fi
set_install_vars

while [ "${KEEP_TRYING}" = "YES" ]
do
  #
  # installing as root
  #
  if [ "${user}" = "root" ]
  then
    if [ "${INSTALL_DIR_EXISTS}" = "yes" ]
    then
        if [ "${INSTALL_DIR_VERSION_FILE_EXISTS}" = "yes" ] && [ "${INSTALL_DIR_OWNER_FILE_EXISTS}" = "yes" ]
        then
            # install dir exists and expected files also
            INSTALL_DIR=${INSTALL_DIR}
            set_install_vars

            existing_installation_found_prologue

            count_of_files_not_owned_by_intended_owner=$(find ${INSTALL_DIR} ! -user ${INSTALL_OWNER} 2>/dev/null | wc -l)	#not interested in error output hence 2 redierct to /dev/null
            status=$?

	    do_install
        else
            : # install dir exists but expected files dont
        fi
    else
        # install dir does not exist - fresh install

	echo "Enter installation directory [${INSTALL_DIR}]: "
        read userinput

        if [ "${userinput}" != "" ]
        then
            INSTALL_DIR=${userinput}
        fi

        if [ ! -d ${INSTALL_DIR} ]
        then
            mkdir -p ${INSTALL_DIR}
            status=$?
        else
            : # hmmmm... unexpected, this should not happen
        fi

        set_install_vars

        echo Hello!
    fi
  else
    #
    # installing as non-root
    #
    if [ "${INSTALL_DIR_EXISTS}" = "yes" ]
    then
        if [ "${INSTALL_DIR_VERSION_FILE_EXISTS}" = "yes" ] && [ "${INSTALL_DIR_OWNER_FILE_EXISTS}" = "yes" ]
        then
            #set_install_vars

            if [ "${user}" = "${INSTALL_OWNER}" ]	# are we running as the user that the code has previously been installed as
            then
                if [ -w ${INSTALL_DIR} ]
                then
                    existing_installation_found_prologue

                    count_of_files_not_owned_by_intended_owner=$(find ${INSTALL_DIR} ! -user ${INSTALL_OWNER} 2>/dev/null | wc -l)	#not interested in error output hence 2 redierct to /dev/null
                    status=$?

                    if [ $status -eq 0 ] && [ "${count_of_files_not_owned_by_intended_owner}" = "0" ]	# find gave no error and number of unexpected owner files is zero then all good
                    then
			do_install
                    else
                         echo "ERROR:  there are files under ${INSTALL_DIR} that are not owned by [${INSTALL_OWNER}] - exiting"
                         exit 1
                    fi
                else
                    : # doh, not root, directory exists but is not writeable
                    echo "ERROR: the install dir [${INSTALL_DIR}] exists but is not writeable - exiting"
                    exit 1
                fi
            else
                echo "ERROR: current install owner [${INSTALL_OWNER}] does not match current user [${user}] - exiting"
                exit 1
            fi
        else
            : # uh-oh, install dir exists but perhaps does not contain an install as expected
            echo
            echo "ERROR: the install dir [${INSTALL_DIR}] exists but does not contain some/all expected files - exiting"
            exit 1
        fi
    else
        confirm_run_as_nonroot

        mkdir -p ${INSTALL_DIR}
        status=$?

        do_install
    fi
  fi
done	# while KEEP_TRYING = yes


exit $EXITCODE

