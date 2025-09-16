#!/bin/bash

. /export/home/oracle/dsp/FRSDOMAIN/setenv_FRSDOMAIN.sh

#Stop the webtier
echo Stopping OHS...
$DOMAIN_HOME/bin/stopComponent.sh ohs1

for SERVER in mid01p mid01t mid01d urs01p urs01t urs01d
do
    echo Stopping reports server: ${SERVER}...
    $DOMAIN_HOME/bin/stopComponent.sh ${SERVER}
done

#Stop the managed servers
echo Stopping WLS_FORMS...
$DOMAIN_HOME/bin/stopManagedWebLogic.sh WLS_FORMS

echo Stopping WLS_REPORTS_DC1...
$DOMAIN_HOME/bin/stopManagedWebLogic.sh WLS_REPORTS

#Stop WebLogic Domain
echo Stopping WebLogic Domain...
$DOMAIN_HOME/bin/stopWebLogic.sh

#Stop NodeManager
echo Stopping NodeManager...
$DOMAIN_HOME/bin/stopNodeManager.sh

