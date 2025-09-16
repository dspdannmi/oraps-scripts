#!/bin/bash

. /export/home/oracle/dsp/OAMDOMAIN/setenv_OAMDOMAIN.sh

$DOMAIN_HOME/bin/stopManagedWebLogic.sh oam_server1
$DOMAIN_HOME/bin/stopManagedWebLogic.sh oam_policy_mgr1

#Stop WebLogic Domain
echo Stopping WebLogic Domain...
$DOMAIN_HOME/bin/stopWebLogic.sh

#Stop NodeManager
echo Stopping NodeManager...
$DOMAIN_HOME/bin/stopNodeManager.sh

