#!/bin/bash

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


. /opt/dsp/env/dsp.env
. /opt/dsp/env/funcs.sh

USAGE_STRING="[-d DB[:pdb] [-h host] [-z]"

EXITCODE=0
ERRMSG=""

PARAMS=""
while getopts 'd:h:p:z' OPTION
do
    case "$OPTION" in
        d) PARAMS="-d $OPTARG ${PARAMS}" ;;
        h) PARAMS="-h $OPTARG ${PARAMS}" ;;
        p) PARAMS="-p $OPTARG ${PARAMS}" ;;
        z) PARAMS="-z ${PARAMS}" ;;
        ?) usage ;;
    esac
done
shift $((OPTIND-1))


runsql ${PARAMS} ${scriptname} ${*}
status=$?

if [ $status -ne 0 ]
then
    EXITCODE=1
fi


exit $EXITCODE

