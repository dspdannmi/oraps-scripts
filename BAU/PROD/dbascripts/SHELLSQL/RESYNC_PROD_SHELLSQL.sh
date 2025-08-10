#!/usr/bin/sh

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

. /opt/dsp/env/dsp.env
. /opt/dsp/env/funcs.sh

if [ ! -f PROD_RUNSQLSCRIPT.sh ]
then
    echo "ERROR: Could not locate runsqlscript.sh"
    echo "      Script appears to running from incorrect directory"
    exit 1
fi

FILES_TO_IGNORE="sort monitor kill uptime"

for file in ${CS_TOP}/PROD/sql/*.sql
do
   file2=$(basename $file | sed -e "s/.sql\$//")
   echo Linking sql to unix shell-script: $file2...
   ln -sf PROD_RUNSQLSCRIPT.sh $file2
done

#
# The following match Unix commands and should 
# not be linked as a script
#
for file in $FILES_TO_IGNORE
do
   rm -f ./$file
done
