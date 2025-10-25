#!/bin/bash

#+++___________________________________________________________________________________
#
#
# Script name:                  check_db_start_nomount.sh
#
# Description:			Check if instance can start nomount and then shutdown
#
# Parameters:
#
# Environment:
#
# Return codes:
#
# Modification history:
#
#       10-Sep-2009     1.0     oracle    Original version
#
#+++___________________________________________________________________________________

CS_TOP=${CS_TOP:-/opt/dsp}
. ${CS_TOP}/env/dsp.env
. ${CS_TOP}/env/funcs.sh

USAGE_STRING="[SID]"


#
# Define local script variables
#

#
# Script starts here
#
#
set_error_trap

if [ $# -ne 1 ]
then
    usage
fi

DB=${1}

if chkorainstsysdba ${DB} 2>&1 > /dev/null
then
    echo "ERROR: database is already UP"
    EXITCODE=1
    exit
fi

if ps -ef | grep ora_lgwr_${DB}\$ 2>&1 > /dev/null
then
   echo "ERROR: ora_lgwr process already running for database"
   EXITCODE=1
   exit 1
fi

export ORACLE_SID=${DB}
export ORAENV_ASK=NO
export PATH=$PATH:/usr/local/bin
. /usr/local/bin/oraenv

sqlplus /nolog << *EOF*
whenever sqlerror exit 4
connect / as sysdba
startup nomount
shutdown abort
*EOF*
status=$?

echo status=$status



exit $EXITCODE

