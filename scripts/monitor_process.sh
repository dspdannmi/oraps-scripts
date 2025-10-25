#!/bin/bash

#+++___________________________________________________________________________________
#
#
# Script name:                  monitor_process.sh
#
# Description:			Monitor a process and alert when not running
#
# Parameters:
#
# Environment:
#
# Return codes:
#
# Modification history:
#
#       03-Oct-2005     1.0     oracle    Original version
#
#+++___________________________________________________________________________________

CS_TOP=${CS_TOP:-/opt/dsp}
. ${CS_TOP}/env/dsp.env
. ${CS_TOP}/env/funcs.sh

USAGE_STRING="email_addy process1 [process2 ... process_n]"


#
# Define local script variables
#

#
# Script starts here
#
#
set_error_trap

if [ $# -lt 2 ]
then
    usage
fi

emailaddress=${1} ; shift 1

while true
do
  for PROC in ${*}
  do
    echo Checking ${PROC}

    if ps -ef | grep ${PROC} | grep -v ${$} | grep -v grep 2>&1 > /dev/null
    then
	:
    else
	echo ${PROC} not running
	sleep 300
    fi
  done
  sleep 30
done


exit $EXITCODE

