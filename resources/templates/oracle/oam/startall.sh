#!/bin/bash

. /export/home/oracle/dsp/OAMDOMAIN/setenv_OAMDOMAIN.sh

#Start NodeManager
echo Starting NodeManager...
nohup $DOMAIN_HOME/bin/startNodeManager.sh 2>&1 >> startNodeManager.log &
sleep 30

#Start AdminServer
echo Starting AdminServer...
nohup $DOMAIN_HOME/bin/startWebLogic.sh 2>&1 >> startWebLogic.log &
sleep 120

echo Starting oam_server1...
nohup $DOMAIN_HOME/bin/startManagedWebLogic.sh oam_server1 2>&1 >> startoam_server1.log &

echo Starting oam_policy_mgr1...
nohup $DOMAIN_HOME/bin/startManagedWebLogic.sh oam_policy_mgr1 2>&1 >> startoam_policy_mgr1.log &

