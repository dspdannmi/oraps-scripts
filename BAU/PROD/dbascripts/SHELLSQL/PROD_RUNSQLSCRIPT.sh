#!/usr/bin/sh

. /home/oracle/cs.env

#+++___________________________________________________________________________________
#
#
# Script name:                  runsqlscript
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
#       26-Mar-2004     1.0     oracle    Original version
#
#+++___________________________________________________________________________________



EXITCODE=0
ERRMSG=""

scriptname=$(basename ${0})
scriptdir=$(dirname ${0})
today=$(date +%Y%m%d)
todayfull=$(date +%Y%m%d_%H%M)
tmpfile=/tmp/$scriptname.$$
thishost=$(hostname)
thisuser=$(whoami)

#---------------------------------------------------------------------------------------
#
# function error_encountered
#	Function called when shell detects command returned a non-zero exit code
#
#---------------------------------------------------------------------------------------

function error_encountered
    {
    status=$?
    if [ $status -ne 0 ]
    then
	EXITCODE=$status
    else
        EXITCODE=1
    fi

    echo "ERROR:  The previous command returned an error: status: $EXITCODE"
    echo "        ( ${ERRMSG} )"
    }


#---------------------------------------------------------------------------------------
#
# function set_error_trap
#	Set trap to run error_encountered function if command returns non-zero exit code
#
#---------------------------------------------------------------------------------------


function set_error_trap
    {
    trap "error_encountered" ERR
    }


#---------------------------------------------------------------------------------------
#
# function clear_error_trap
#	Turn off automatic non-zero exit code returns checking by shell
#
#---------------------------------------------------------------------------------------

function clear_error_trap
    {
    trap "" ERR
    }


#---------------------------------------------------------------------------------------
#
# function graceful_exit
#	Exit script gracefully whether normal termination or abnormal interrupt
#
#---------------------------------------------------------------------------------------

function graceful_exit
    {
    if [ "$1" = "terminated" ]
    then
	echo "Abornal termination... received terminate signal"

	if [ "$EXITCODE" = "0" ]
	then
	    EXITCODE=1	# abnormal termination should return non-zero
	fi
    else
        if [ "$EXITCODE" != "0" ]
        then
	    echo "WARNING:"
	    echo "WARNING: $scriptname returned encountered error during execution"
	    echo "WARNING:"
        fi
    fi


    rm -f ${tmpfile}*
    exit $EXITCODE
    }



DB=""
CMDLINE=""
if [ $# -eq 0 ]
then
    CMDLINE="%"
elif [ $1 = "-d" ]
then
    DB=${2}
    shift ; shift

    CMDLINE="-d ${DB}"
fi

if [ -x $(which $scriptname)_v7 ]
then
    V7_CMDLINE=""
    if [ "$DB" != "" ]
    then
	V7_CMDLINE="-d ${DB}"
    fi

    DBVERSION=$(dbversion | cut -d. -f1)

    if [ "$DBVERSION" = "7" ]
    then
	scriptname=${scriptname}_v7
    fi
fi

CMDLINE="${scriptname}"
if [ "$DB" != "" ]
then
    CMDLINE="-d ${DB} ${CMDLINE}"
fi

if [ $# -eq 0 ]
then
    CMDLINE="${CMDLINE} %"
fi

runsql ${CMDLINE} ${*}
status=$?

if [ $status -ne 0 ]
then
    echo ERROR: Encountered error when running SQL
    EXITCODE=$status
fi


exit $EXITCODE

