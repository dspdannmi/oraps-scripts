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

. /opt/dsp/env/dsp.env
. /opt/dsp/env/funcs.sh


for file in *.sql
do
count=$(find CATEGORY -name $file | wc -l)
if [ $count -gt 1 ]
then
    echo $file
fi
done | sort | uniq -c
