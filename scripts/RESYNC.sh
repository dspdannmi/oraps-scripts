#!/bin/bash

#+++___________________________________________________________________________________
#
#
# Script name:                  RESYNC.sh
#
# Description:			Re-synchronise database shell scripts for SQL scripts
#
# Parameters:
#
# Environment:
#
# Return codes:
#
# Modification history:
#
#       29-Mar-2004     1.0     oracle    Original version
#
#+++___________________________________________________________________________________


CS_TOP=${CS_TOP:-/opt/dsp}
. ${CS_TOP}/env/dsp.env
. ${CS_TOP}/env/funcs.sh

USAGE_STRING=""

#
# Script starts here
#
#
set_error_trap

cd $CS_TOP/sql
./RESYNC_SQL.sh

cd $CS_TOP/dbscripts/oracle/SHELLSQL
./RESYNC_SHELLSQL.sh

exit $EXITCODE

