#!/bin/bash

#+++___________________________________________________________________________________
#
#
# Script name:                  cpiodir.sh
#
# Description:                  cpio directory and compress to file and optionally
#                               exclude files
#
# Parameters:                   1  =  source directory
#                               2  =  destination file
#                               3  =  list of files to be excluded [optional]
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
. ${CS_TOP}/env/funcs.sh

SOURCE_DIR=${1}
DEST_FILE=${2}
EXCEPTION_FILE=${3}

STAGE_FILE=${DEST_FILE}.stage.gz
TARGET_FILE=${DEST_FILE}.gz

#
# check command line for required number of parameters
#
if [ $# -lt 2 ] || [ $# -gt 3 ]
then
    echo "usage: sourcedir destfile exceptionfile"
    exit 1
fi


#
# if no exceptions file given then default
# to /dev/null as exceptions file
#
if [ "${EXCEPTION_FILE}" = "" ]
then
    EXCEPTION_FILE=/dev/null
else
    if [ ! -f ${EXCEPTION_FILE} ]
    then
        echo "ERROR: could not find file $EXCEPTIONS_FILE"
        EXITCODE=1
        exit $EXITCODE
    fi
fi



#
# check source directory exists and is a directory
#
if [ ! -d ${SOURCE_DIR} ]
then
    echo "ERROR: $SOURCE_DIR is not a directory"
    EXITCODE=1
    exit $EXITCODE
fi

if expr "${DEST_FILE}" : "/" 2>&1 > /dev/null
then
    :
else
    echo "ERROR: cpio file [${DEST_FILE}] does not appear to be absolute / fully-qualified - exiting"
    EXITCODE=1
    exit $EXITCODE
fi





#
# create stage file first to determine if the destination
# directory has write permissions
#
touch ${STAGE_FILE}
status=$?

if [ $status -ne 0 ]
then
    echo "ERROR: encountered error when trying to create ${STAGE_FILE}"
    EXITCODE=1
    exit $EXITCODE
fi



start_time=$(date +%Y%m%d_%H:%M:%S)

echo
echo Creating cpio archive...
echo

echo "Source dir:  ${SOURCE_DIR}"
echo "Dest file:   ${TARGET_FILE}"
echo "Exceptions:  ${EXCEPTION_FILE}"
echo
echo "Startime:    ${start_time}"
echo

#
# change directory to source directory and run two seperate
# find commands.  First one to get all directories regardless
# of matches against the exceptions file.  The a second find
# to find files excluding the ones that match the regular
# expressions in the exceptions file.  Then pipe list of files
# to cpio and then pipe to compress to compress on-the-fly
# to destination file
#
(
cd ${SOURCE_DIR}
  (
  find . -type d ;
  find . | grep -v -f ${EXCEPTION_FILE}
  ) | cpio -ocB | gzip -c > ${STAGE_FILE}
  status=$?
)
echo



#
# if target file exists then move it to old.Z extension and then
#
if [ -f ${TARGET_FILE} ]
then
    mv ${TARGET_FILE} ${TARGET_FILE}.$(date +%Y%m%d_%H%M%S).old 
    status=$?

    if [ $status -ne 0 ]
    then
        echo "ERROR: file exists and error encountered when renaming"
        exit 1
    fi
fi


#
# rename stage file to target file
#
mv ${STAGE_FILE} ${TARGET_FILE}
status=$?

end_time=$(date +%Y%m%d_%H:%M:%S)

echo "Endtime:     ${end_time}"
echo
