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

cd ${CS_TOP}/sql/oracle

if [ ! -d CATEGORY ]
then
    echo "ERROR: Could not find directory CATEGORY"
    echo "       Script not being run from correct location"
    exit 1
else
    NOSYMLINK_FILES_FOUND=NO

    for file in [a-z]*.sql
    do
        if [ ! -h ${file} ]
        then
            echo "ERROR: file [${file}] is not a symbolc link"
            NOSYMLINK_FILES_FOUND=YES
        fi
    done

    if [ "${NOSYMLINK_FILES_FOUND}" = "YES" ]
    then
       echo "ERROR: One or more .sql files here that are not symbolic links - exiting"
       EXITCODE=1
       exit $EXITCODE
    else
        # we have checked all [a-z]*.sql files are symbolic links
	# so we can now remove
        rm -f [a-z]*.sql
    fi
fi

INDEXFILE=INDEX.txt
cat /dev/null > ${INDEXFILE}

if [ $# -eq 0 ]
then
    rm -f [a-z]*.sql

    for catdir in CATEGORY/*
    do
     if [ -d $catdir ]
     then
       echo "Syncing component $catdir..."
    
       for file2 in $catdir/*.sql
       do
	 if [ -f $file2 ]
	 then
           echo "   linking $(basename $file2)"
           ln -sf $file2 .

	   description_line=$(grep ^--DESCRIBE: ${file2} | sed -e's/\*//' | head -1 | cut -d: -f2- | sed -e's/^ *//g')
	   echo $(basename ${file2}) $(echo ${file2} | awk -F\/ '{print $2}') "[${description_line}]" >> ${INDEXFILE}
	 else
	   echo "   ...ignoring $(basename $file2)"
	 fi
       done
      fi
    done
else
  for catdir in $*
  do
    if [ ! -f $file1 ]
    then
	echo ERROR: $file1 does not exist
	exit 1
    fi

    ln -sf $file1 .
  done
fi

