#!/bin/bash

#. . imported "OPSSOM36"."IT1271"                         19.30 MB  431213 rows
#. . imported "OPSSOM36"."IT2680"                         17.10 MB  304501 rows


awk '/ imported.*rows/ { printf $4 ":" $(NF-1) "\n"} ' $*  | sed -e 's/"//g' -e 's/\./:/' | sort

