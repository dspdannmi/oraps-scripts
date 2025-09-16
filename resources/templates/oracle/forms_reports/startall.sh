#!/bin/bash

scriptdir=$(dirname $0)

. ${scriptdir}/setenv_FRSDOMAIN.sh

#Start NodeManager
echo Starting NodeManager...
nohup $DOMAIN_HOME/bin/startNodeManager.sh 2>&1 >> startNodeManager.log &

echo Sleeping 10 seconds...
sleep 10

#Start AdminServer
echo Starting AdminServer...
nohup $DOMAIN_HOME/bin/startWebLogic.sh 2>&1 >> startWebLogic.log &

echo Sleeping 120 seconds...
sleep 120

#Start the managed servers
echo Starting WLS_FORMS...
nohup $DOMAIN_HOME/bin/startManagedWebLogic.sh WLS_FORMS 2>&1 >> startWLS_FORMS.log &

echo Starting WLS_REPORTS...
nohup $DOMAIN_HOME/bin/startManagedWebLogic.sh WLS_REPORTS 2>&1 >> startWLS_REPORTS.log &

#Start the webtier
echo Starting OHS1...
nohup $DOMAIN_HOME/bin/startComponent.sh ohs1 2>&1 >> startOHS1.log &

echo Sleeping 30 seconds...
sleep 30

for SERVER in rep_server_list	# change this to names of standalone report servers
do
    echo Starting reports server: ${SERVER}...
    nohup $DOMAIN_HOME/bin/startComponent.sh ${SERVER} 2>&1 >> start${SERVER}.log &
done

