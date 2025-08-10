#!/bin/bash

#+++___________________________________________________________________________________
#
#
# Script name:                  validatedb.sh
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
#       29-Mar-2004     1.0     oracle    Original version
#
#+++___________________________________________________________________________________


. /opt/dsp/env/dsp.env
. ${CS_TOP}/env/funcs.sh

USAGE_STRING=""

#
# Script starts here
#
#
#set_error_trap

if [ $# -ne 0 ]
then
    export ORACLE_SID=$1
    export ORAENV_ASK=NO
    . /usr/local/bin/oraenv
fi

echo =============================================
echo GLOBAL NAME
echo =============================================
echo
globalname

echo
echo

echo =============================================
echo TEMP FILES
echo =============================================
dbatempfiles


echo
echo


echo =============================================
echo MISSING FILES 
echo =============================================
missing

echo =============================================
echo DB LINKS
echo =============================================
dbadblinks

echo
echo


echo =============================================
echo CHECK DB LINKS
echo =============================================
genchecklinks > /tmp/checklinks.$$.sql

export SQL_EXIT_ON_ERROR=NO
runsql /tmp/checklinks.$$.sql


