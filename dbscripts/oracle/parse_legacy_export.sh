#!/bin/bash

#. about to export SYSTEM's tables via Direct Path ...
#Table DEF$_AQCALL will be exported in conventional path.
#. . exporting table                    DEF$_AQCALL          0 rows exported
#Table DEF$_AQERROR will be exported in conventional path.
#. . exporting table                   DEF$_AQERROR          0 rows exported
#. . exporting table                  DEF$_CALLDEST          0 rows exported
#. . exporting table               DEF$_DEFAULTDEST          0 rows exported
#. . exporting table               DEF$_DESTINATION          0 rows exported


awk ' BEGIN { prev=";" }
/ about to export / { username=$5; }
/ exporting table / { printf username "." $5 ":" $6 "\n"}
' $* | sed -e "s/'s//g" -e 's/\./:/' | sort

