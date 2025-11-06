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

DEBUG="NO"

DSP_TOP=/opt/dsp

USAGE_STRING=""

OS=$(uname)
user=$(id -un)
group=$(id -gn)

BANNER_FILE=banner.txt
NEW_INSTALL_VERSION_FILE=version.txt
DSP_DIR=dsp

DEFAULT_INSTALL_DIR_ROOT=/opt/${DSP_DIR}
DEFAULT_INSTALL_DIR_NONROOT=$HOME/${DSP_DIR}

DEFAULT_INSTALL_DIR=${DEFAULT_INSTALL_DIR_ROOT}

DEFAULT_OWNER="oracle"
DEFAULT_GROUP="oinstall"

keep_trying="YES"

install_dir_exists="NO"
install_dir_writeable="NO"
new_install_version_file=version.txt
owner_is_me="NO"

function echodebug
    {
    if [ "${DEBUG}" = "YES" ]
    then
        echo "debug: ${*}"
    fi
    }




function get_install_owner
    {
    echodebug "ask_for_install_owner: begin"

    tmp_owner="${install_owner}"
    tmp_group="${install_group}"

    if [ "${user}" != "root" ]
    then
        tmp_owner=${user}
        tmp_group=${group}
    fi

    #
    # when running as root then ask which owner:group should
    # own the installation
    #
    if [ "${user}" = "root" ]
    then
        OK="NO"
        while [ "${OK}" = "NO" ]
        do
            echo -n "Enter install owner: [${tmp_owner}] "
            read userinput
    
            if [ "${userinput}" = "" ]
            then
                if [ "${tmp_owner}" != "" ]
                then
                     install_owner=${tmp_owner}
                     OK="YES"
                else
                     :
                fi
            else
                install_owner=${userinput}
                OK="YES"
            fi
    
            if grep ^${install_owner}: /etc/passwd 2>&1 > /dev/null
            then
                :
            else
                echo "*********************************************"
                echo "ERROR: user [${install_owner}] does not exist"
                echo "*********************************************"
                OK="NO"
            fi
        done
    
        OK="NO"
        while [ "${OK}" = "NO" ]
        do
            echo -n "Enter install group: [${tmp_group}] "
            read userinput
    
            if [ "${userinput}" = "" ]
            then
                if [ "${tmp_group}" != "" ]
                then
                     install_group=${tmp_group}
                     OK="YES"
                else
                     :
                fi
            else
                install_group=${userinput}
                OK="YES"
            fi
    
            if grep ^${install_group}: /etc/group 2>&1 > /dev/null
            then
                :
            else
                echo "ERROR: group [${install_group}] does not exist"
                OK="NO"
            fi
        done
    else # user is root
         :
    fi

    echodebug "ask_for_install_owner: end"
    }


function do_install()
    {
    echo ""
    echo "--------------------"
    echo "Installation Summary"
    echo "--------------------"
    echo ""
    echo "   installation dir  : ${INSTALL_DIR}"
    echo "              owner  : ${install_owner}"
    echo "              group  : ${install_group}"
    echo ""
    echo "    current version  : ${current_version:-<new installation>}"
    echo "        new version  : ${NEW_VERSION}"
    echo ""

    if [ "${NEW_VERSION}" = "${current_version}" ]
    then
        echo "*******************************************************"
        echo "INFO: version [${NEW_VERSION}] already installed"
        echo "*******************************************************"
        echo ""
    fi
   

    if prompt_confirm "Do you wish to proceed?"
    then
        echo ""
        echo "Installing..."
        echo ""

        # pause for dramatic effect :)
        sleep 1
      

        if [ "${user}" = "root" ]
        then
            tar_owner_clause="--owner=${install_owner}"
            tar_group_clause="--group=${install_group}"
        else
            tar_owner_clause=""
            tar_group_clause=""
        fi

        if [ ! -d ${INSTALL_DIR} ]
        then
            echo "*********************************************"
            echo "ERROR: installation dir [${INSTALL_DIR}] does not exist - exiting"
            echo "*********************************************"
            EXITCODE=1
            exit ${EXITCODE}
        fi

        # choosing cpio as it gives better control around forcing ownership to be
        # specific owner:group for files that already exist.  A bit more versatile
        # and predictable compared to tar

        # add -v clause for verbose
        echodebug "gunzip -c ${NEW_INSTALL_FILE} | cpio -icdm --owner ${install_owner}:${install_group} -u -D ${INSTALL_DIR}"
        gunzip -c ${NEW_INSTALL_FILE} | cpio -icdm --owner ${install_owner}:${install_group} -u -D ${INSTALL_DIR}
        status=$?

        echodebug "status=$status"

        echo ""

        if [ $status -eq 0 ]
        then
            echo "SUCCESS!!!"
        else
            echo "*********************************************"
            echo "ERROR: an error occurred when extracting the files"
            echo "*********************************************"
            EXITCODE=1
            exit ${EXITCODE}
        fi


        echo "${install_owner}:${install_group}" > ${owner_file}
        status=$?

        keep_trying="NO"
    else
        :
    fi
    }


function check_already_installed()
    {
    echodebug "check_already_installed: begin"

    if [ "${existing_installation}" = "YES" ]
    then
        return 0
    else
        return 1
    fi

    echodebug "check_already_installed: end"
    }


function create_install_dir()
    {
    echodebug "create_install_dir: begin"

    if [ "${parent_dir_writeable}" = "YES" ]
    then
        mkdir -m 755 ${INSTALL_DIR}
        status=$?

        if [ $status -eq 0 ]
        then
            if [ "${user}" = "root" ]
            then
                chown ${install_owner}:${install_group} ${INSTALL_DIR}
                status=$?
            fi

            echo "Installation directory [${INSTALL_DIR}] successfully created"
            echo
        else
            :
        fi

    else
        echo ""
        echo "*********************************************"
        echo "ERROR: parent directory [${parent_dir}] not writeable"
        echo "       unable to create directory"
        echo "*********************************************"
        return 1
    fi

    echodebug "create_install_dir: end"
    }


function check_i_am_root_or_owner()
    {
    if [ "${user}" = "root" ] || [ "${user}" = "${install_owner}" ]
    then
        return 0
    else
        return 1
    fi
    }

function prompt_confirm() {
# acknowledge https://stackoverflow.com/questions/3231804/in-bash-how-to-add-are-you-sure-y-n-to-any-command-or-alias
  while true; do
    read -r -n 1 -p "${1:-Continue?} [y/n]: " REPLY
    case $REPLY in
      [yY]) echo ; return 0 ;;
      [nN]) echo ; return 1 ;;
      *) printf " \033[31m %s \n\033[0m" "invalid input"
    esac 
  done  
}



function set_install_dir()
    {
    echodebug "set_install_dir: begin"

    echo -n "Enter installation directory ["${INSTALL_DIR}"]: "
    read userinput

    if [ "${userinput}" = "" ]
    then
        : # do nothing as default is already set and accepted
    else
        INSTALL_DIR=${userinput}
    fi

    install_dir_exists="NO"
    install_dir_writeable="NO"
    parent_dir_exists="NO"
    parent_dir_writeable="NO"
    install_owner_is_me="NO"

    install_owner=""
    install_group=""

    if [ "$(grep ^oracle: /etc/passwd)" ]
    then
        install_owner="oracle"
    fi

    if [ "$(grep ^oinstall: /etc/group)" ]
    then
        install_group="oinstall"
    else
        if [ "$(grep ^dba: /etc/group)" ]
        then
            install_group="dba"
        fi
    fi

    if [ "${INSTALL_DIR}" = "" ]
    then
        INSTALL_DIR=${DEFAULT_INSTALL_DIR}
    fi

    config_dir=${INSTALL_DIR}/config/dsp
    owner_file=${config_dir}/owner.txt
    identity_file=${config_dir}/identity.txt
    version_file=${config_dir}/version.txt
    
    parent_dir=$(dirname ${INSTALL_DIR})

    if [ -d ${INSTALL_DIR} ]
    then
        install_dir_exists="YES"

        #install_owner is who should own the code
        #install_dir_owner is the actual owner of the install dir
        #
        install_owner=$(stat -c "%U" ${INSTALL_DIR})
        install_dir_owner=${install_owner}


        #install_group is who should own the code
        #install_dir_group is the actual group of the install dir
        #
        install_group=$(stat -c "%G" ${INSTALL_DIR})
        install_dir_group=${install_group}

        if [ "${install_owner}" = "${user}" ]
        then
             install_owner_is_me="YES"
        fi

        if [ "$(find ${INSTALL_DIR} | wc -l)" = "1" ]	# directory is empty
        then
            install_dir_empty="YES"
        else
            install_dir_empty="NO"
        fi

        echodebug "$(ls -ald ${owner_file} 2>&1)"
        echodebug "$(ls -ald ${identity_file} 2>&1)"
        echodebug "$(ls -ald ${version_file} 2>&1)"

        #
        # arbitrary check on a couple of files in the target
        # directory to check if the installation already exists
        # it is not a guarantee but a very strong indication
        # - dont check for identity file because on a fresh
        #   (or indeed any) install the identity file does not
        #   exist until serverstamp is run
        if [ -f ${owner_file} ]  && [ -f ${version_file} ]
        then
            existing_installation="YES" 

            install_owner=$(cut -d: -f1 ${owner_file})
            install_group=$(cut -d: -f2 ${owner_file})

            if [ "${install_owner}" != "${install_dir_owner}" ] || [ "${install_group}" != "${install_dir_group}" ]
            then
                echo "*********************************************"
                echo "ERROR: install owner:group [${install_owner}:${install_group}] from owner.txt file mismatch"
                echo "       with dir owner [${install_dir_owner}:${install_dir_group}]"
                echo "*********************************************"
                EXITCODE=1
                exit ${EXITCODE}
            fi
        else
            existing_installation="NO" 
        fi
    fi

    if [ -w ${INSTALL_DIR} ]
    then
        install_dir_writeable="YES"
    fi

    if [ -w ${parent_dir} ]
    then
        parent_dir_writeable="YES"
    fi 

    check_already_installed
    status=$?

    if [ $status -eq 0 ]
    then
        echo ""
        echo "INFO: existing installation found [${INSTALL_DIR}]"
        echo ""
    fi

    echodebug "install_dir_exists       : ${install_dir_exists}"
    echodebug "existing_installation    : ${existing_installation}"
    echodebug "install_dir_writeable    : ${install_dir_writeable}"
    echodebug "parent_dir_writeable     : ${parent_dir_writeable}"
    echodebug "install_dir_empty        : ${install_dir_empty}"
    echodebug "install_owner_is_me      : ${install_owner_is_me}"
    echodebug "install_owner        : ${install_owner}"
    echodebug "install_group        : ${install_group}"

    echodebug "set_install_dir: end"
    }


#
# Define local script variables
#

#
# Script starts here
#

if [ -r ${NEW_INSTALL_VERSION_FILE} ]
then
    NEW_VERSION=$(cat ${NEW_INSTALL_VERSION_FILE})
else
    echo "*********************************************"
    echo "ERROR: install file [${NEW_INSTALL_VERSION_FILE}] does not exist or is not readable in current directory - exiting"
    echo "*********************************************"
    exit 1
fi

NEW_INSTALL_FILE=dsp-${NEW_VERSION}.cpio.gz

if [ ! -r ${NEW_INSTALL_FILE} ]
then
    echo "*********************************************"
    echo "ERROR: install file [${NEW_INSTALL_FILE}] does not exist or is not readable in current directory - exiting"
    echo "*********************************************"
    exit 1
fi

if [ -r ${BANNER_FILE} ]
then
    sed -e "s/%%VERSION%%/${NEW_VERSION}/" ${BANNER_FILE}
fi

echo

#
# main loop
#
INSTALL_DIR=${DEFAULT_INSTALL_DIR}

while [ "${keep_trying}" = "YES" ]
do
    OK_TO_DO_INSTALL="YES"

    set_install_dir

    if [ "${install_dir_exists}" = "YES" ] 	# install directory exists
    then
        if [ "${install_dir_writeable}" = "YES" ] 	# install directory writeable
        then
            if [ "${install_dir_empty}" = "YES" ]	# directory is empty
            then
                get_install_owner
            else
                if check_already_installed 2>&1 > /dev/null
                then
                    if check_i_am_root_or_owner 2>&1 > /dev/null
                    then
                        #echo ""
                        #echo "INFO: existing installation found [${INSTALL_DIR}]"
                        #echo ""
                        current_version=$(cat ${version_file})
                    else
                        echo "*********************************************"
                        echo "ERROR: current user [${user}] does not match expected [${install_owner}]"
                        echo "*********************************************"

                        echo ""
                        echo "An existing installation found and owned by user [${install_owner}]"
                        echo "but installation being run by [${user}].  It is recommended to abort"
                        echo "this installation and re-run it as root or [${install_owner}]"
                        echo ""
                        if prompt_confirm "Do you wish to continue installing as this user?"
                        then
                            :
                        else
                            echo "Exiting..."
                            EXITCODE=1
                            exit ${EXITCODE}
                        fi

                        OK_TO_DO_INSTALL="NO"
                    fi
                else
                    echo "*********************************************"
                    echo "ERROR: installation directory [${INSTALL_DIR}] is not empty"
                    echo "       and does not appear to contain a previous installation"
                    echo "*********************************************"

                    OK_TO_DO_INSTALL="NO"
                fi
            fi
        else
            echo "*********************************************"
            echo "ERROR: installation directory [${INSTALL_DIR}] not writeable"
            echo "*********************************************"

            OK_TO_DO_INSTALL="NO"
        fi
    else
        echo ""
        echo "Installation directory [${INSTALL_DIR}] does not exist"
        echo ""

        if prompt_confirm "Do you wish to create [${INSTALL_DIR}]?"
        then
            get_install_owner
            
            create_install_dir
            status=$?

            if [ $status -ne 0 ]
            then
                OK_TO_DO_INSTALL="NO"
            fi
        else
            OK_TO_DO_INSTALL="NO"
            echo
        fi
    fi

    if [ "${OK_TO_DO_INSTALL}" = "YES" ]
    then
        do_install
    else
        echo ""
        echo "An error occurred (see above) - restarting installation procedure"
        echo ""
    fi

done

echo ""

# end of script


