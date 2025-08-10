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


< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-32};echo;

openssl rand -base64 32

