#!/bin/bash

#+++___________________________________________________________________________________
#
#
# Script name:                  runlater
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
#       09-Oct-2003     1.0     oracle    Original version
#
#+++___________________________________________________________________________________

CS_TOP=/opt/dsp
. ${CS_TOP}/env/dsp.env
. ${CS_TOP}/env/funcs.sh


RUNSQLSCRIPT_FILENAME="RUNSQLSCRIPT.sh"

if [ "${SQL}" = "" ] || [ ! -d "${SQL}" ]
then
   echo "ERROR: exit 1"
   exit 1
fi

if [ ! -x ${RUNSQLSCRIPT_FILENAME} ]
then
    echo "ERROR: Could not locate [${RUNSQLSCRIPT_FILENAME}]"
    echo "      Script appears to running from incorrect directory"
    EXITCODE=1
    exit $EXITCODE
fi

if [ ! -d scripts ]
then
    echo "ERROR: could not locate directory [scripts]"
    echo "       script appears to be running from incorrect directory"
    EXITCODE=1
    exit $EXITCODE
fi

FILES_TO_IGNORE="sort monitor kill uptime"

rm -f scripts/*
status=$?

cd scripts
status=$

if [ $status -ne 0 ]
then
    echo "ERROR: could not cd to directory [scripts]"
    EXITCODE=1
    exit $EXITCODE
fi

for file in ${SQL}/[a-z]*.sql
do
   #file2=$(basename $file | sed -e "s/.sql\$//")
   file2=$(basename $file .sql)
   echo Linking sql to unix shell-script: $file2...
   ln -sf ../${RUNSQLSCRIPT_FILENAME} $file2
   status=$?

   if [ $status -ne 0 ]
   then
       echo "WARNING: encountered error linking ${file2}"
       EXITCODE=1
   fi
done

#
# The following match Unix commands and should 
# not be linked as a script
#
if [ "${FILES_TO_IGNORE}" != "" ]
then
    for file in $FILES_TO_IGNORE
    do
       [ -f $file ] && rm -f ./$file
    done
fi

exit $EXITCODE
