#!/bin/bash

# Script name:			create_large_file.sh

# Description:	Show command to create large (empty) file


echo run this: dd if=/dev/zero of=myfile.dat bs=1024k count=1k

