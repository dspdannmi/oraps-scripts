#!/bin/bash

# run before install new

ENV_FILE=/opt/dsp/setenv

if [ ! -r ${ENV_FILE} ]
then
    echo "ERROR: no ENV_FILE [${ENV_FILE}] - exiting"
    EXITCODE=1
    exit ${EXITCODE}
fi

. /opt/dsp/setenv

[ -f ${DSP_TOP}/scripts/checkmounts.sh ] && rm -f ${DSP_TOP}/scripts/checkmounts.sh 
