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


for file in *.sql
do
count=$(find CATEGORY -name $file | wc -l)
if [ $count -gt 1 ]
then
    echo $file
fi
done | sort | uniq -c
