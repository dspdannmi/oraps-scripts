#!/bin/bash

#+++___________________________________________________________________________________
#
#
# Script name:                  chk_control_file_dirs_exist.sh
#
# Description:			Check if controlfile directories exist
#
# Parameters:			1	(optional)	SID
#
# Environment:
#
# Return codes:
#
# Modification history:
#
#       14-Jan-2004     1.0     oracle    Original version
#
#+++___________________________________________________________________________________

CS_TOP=${CS_TOP:-/opt/dsp}
. ${CS_TOP}/env/dsp.env
. ${CS_TOP}/env/funcs.sh

USAGE_STRING="[-d SID]"



if [ $# -gt 2 ]
then
    usage
fi

if [ "$1" = "-d" ]
then
    export ORACLE_SID=$(echo ${2} | awk -F: '{print $1}')

    whichhost=$(echo ${2} | awk -F: '{print $2}' | tr "[:upper:]" "[:lower:]")

    if [ "${whichhost}" = "" ] || [ "${whichhost}" = "${thishost}" ]
    then
        whichhost=$thishost

        if chkoradbinoratab ${ORACLE_SID}
        then
            :
        else
            echo ERROR: $ORACLE_SID not in oratab
            exit 1
        fi

        . /usr/local/bin/oraenv 2>&1 > /dev/null
    fi

    shift
    shift
else
    whichhost=$thishost
fi


if [ $# -ne 0 ]
then
    usage
fi


if [ "$ORACLE_SID" = "" ]
then
    echo ERROR: ORACLE_SID not set
    exit 1
fi


if [ "$whichhost" = "$thishost" ]
then
    pfile=${ORACLE_HOME}/dbs/init${ORACLE_SID}.ora  
    spfile=${ORACLE_HOME}/dbs/spfile${ORACLE_SID}.ora  

    pfile_to_use=""

    if [ -f ${spfile} ]
    then
	pfile_to_use=$spfile
    elif [ -f ${pfile} ]
    then
	pfile_to_use=$pfile
    else
	echo "ERROR: pfile or spfile does not exist for $ORACLE_SID in $ORACLE_HOME"
	EXITCODE=1
	exit
    fi

    at_least_one_control_file_specified="no"
    for cfile in $(strings ${pfile_to_use} | grep -v ^# | grep control_files | awk -F= '{print $NF}' | sed -e 's/,/ /g' | sed -e "s/'//g")
    do 
	echo "checking: ${cfile}"
	if [ -d $(dirname ${cfile}) ]
	then
	    echo "ok"
            at_least_one_control_file_specified="yes"
	else
	    echo "ERROR: directory does not exist for control file ${cfile}"
	    EXITCODE=1
	    exit
	fi
    done

    if [ "${at_least_one_control_file_specified}" != "yes" ]
    then
	echo "ERROR: no control file specification found in pfile"
	EXITCODE=1
	exit
    fi
    
    


else
    runremotecmd ${whichhost} $(which ${scriptname}) -d ${ORACLE_SID} ${sequence_start} ${sequence_end}
    status=$?

      if [ $status -ne 0 ]
      then
          echo "ERROR: Encountered error running remote command"
          EXITCODE=1
      fi
fi

exit $EXITCODE

