#!/bin/bash

#. . exported "OPSSOM36"."WT0510_202001"                  15.17 MB  282753 rows
#. . exported "OPSSOM36"."WT0510_202002"                  15.13 MB  281965 rows



awk '/ exported.*rows/ { printf $4 ":" $(NF-1) "\n"} ' $* | sed -e 's/"//g' -e 's/\./:/' | sort


