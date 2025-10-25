#!/bin/bash

for file in $(find . -type f)
do
    X=/opt/dsp/${file}
    if [ -f ${X} ]
    then
        if diff ${file} ${X} 2>&1 > /dev/null
        then
 :
        else
echo =================== $file
diff ${file} ${X}
echo
        fi
    fi
done

echo 
echo
echo "================================================"
echo "SWAPPING"
echo "================================================"
echo
echo

GIT_DIR=$PWD

cd /opt/dsp

for file in $(find . -type f)
do
    X=${GIT_DIR}/${file}
    if [ -f ${X} ]
    then
        if diff ${file} ${X} 2>&1 > /dev/null
        then
 :
        else
echo =================== $file
diff ${file} ${X}
echo
        fi
    fi
done

