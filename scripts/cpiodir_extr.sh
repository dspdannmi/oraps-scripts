#!/bin/bash

#+++___________________________________________________________________________________
#
#
# Script name:                  cpiodir.sh
#
# Description:                  cpio directory and compress to file and optionally
#                                exclude files
#
# Parameters:                    1  =  dest directory
#                                2  =  cpio file [fully qualified]
#
# Environment:
#
# Return codes:
#
# Modification history:
#
#       26-Jan-2010     1.0     dannmi    Original version
#
#+++___________________________________________________________________________________

. /opt/dsp/env/dsp.env
. /opt/dsp/env/funcs.sh


if [ $# -ne 2 ]
then
    echo "usage: destdir cpiofile"
    exit 1
fi

DESTDIR=$1
CPIO_FILE=$2

if [ ! -d ${DESTDIR} ]
then
    echo "ERROR: ${DESTDIR} not a directory"
    exit 1
fi


cd ${DESTDIR}
status=$?

if [ $status -ne 0 ]
then
    echo "ERROR: could not change to directory"
    exit 1
fi

if [ ! -r ${CPIO_FILE} ]
then
    echo "ERROR: ${CPIO_FILE} does not exist"
    exit 1
fi

if expr "${CPIO_FILE}" : "/"
then
    :
else
    echo "ERROR: cpio file [${CPIO_FILE}] does not appear to be absolute / fully-qualified path - exiting"
    EXITCODE=1
    exit $EXITCODE
fi

start_time=$(date +%Y%m%d_%H:%M:%S)

echo
echo Extracting cpio archive...
echo

echo "Dest dir:    ${DESTDIR}"
echo "cpio file:   ${CPIO_FILE}"
echo
echo "Startime:    ${start_time}"
echo




gzip -d -c ${CPIO_FILE} | cpio -icdm
status=$?

if [ $status -ne 0 ]
then
    echo "ERROR: encountered error when un-cpioing"
    exit 1
fi
