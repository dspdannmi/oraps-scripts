#!/bin/bash

# Script name:		parse_legacy_import.sh

#. importing TSMSYS's objects into TSMSYS
#. . importing table                         "SRS$"          0 rows imported
#. importing OPSSOM19's objects into OPSSOM19
#. . importing table


awk ' BEGIN { prev=";" }
/ importing.*objects into / { username=$6; }
/ importing table / { printf username "." $5 ":" $6 "\n"}
' $* | sed -e 's/\"//g' -e 's/\./:/' | sort

