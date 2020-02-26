#!/bin/bash

#  Dr Kent G Lau
#  kenty@kenty.com

#  Hyperhack 2020

# teardown residual network
sudo docker-compose -f docker-compose.yml down -v

echo
echo "#################################################################"
echo "#######    Starting network:  ###################################"
echo "#################################################################"

# start network
sudo docker-compose -f docker-compose.yml up -d

echo
echo "#################################################################"
echo "#######    List of all network containers   #####################"
echo "#################################################################"

# list all containers
sudo docker ps -a


echo
echo "#################################################################"
echo "#######    Show network  ########################################"
echo "#################################################################"

# show network
sudo docker network ls

echo
echo "#################################################################"
echo "#######    Show volumes  ########################################"
echo "#################################################################"

# show network
sudo docker volume ls

echo
echo "#################################################################"
echo "#######    Show system usage  ########################################"
echo "#################################################################"

# show network
sudo docker system df



# wait for Hyperledger Fabric to start
# incase of errors when running later commands, issue export FABRIC_START_TIMEOUT=<larger number>
export FABRIC_START_TIMEOUT=10
#echo ${FABRIC_START_TIMEOUT}
sleep ${FABRIC_START_TIMEOUT}


echo
echo "#################################################################"
echo "#######    Creating itemchannel   ############################"
echo "#################################################################"

# Create itemchannel
sudo docker exec -e "CORE_PEER_LOCALMSPID=RegulatorMSP" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@regulator.com/msp/" peer0.regulator.com peer channel create -o orderer.regulator.com:7050 -c itemchannel -f /etc/hyperledger/configtx/itemchannel.tx


echo
echo "#################################################################"
echo "#######    Joining peer0.regulator.com to itemchannel   ########"
echo "#################################################################"

# Join peer0.regulator.com to itemchannel.
sudo docker exec -e "CORE_PEER_LOCALMSPID=RegulatorMSP" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@regulator.com/msp/" peer0.regulator.com peer channel join -b itemchannel.block

echo
echo "#################################################################"
echo "#######    List of all channels joined by peer0.regulator.com  ##"
echo "#################################################################"

# Peer channel list
sudo docker exec -e "CORE_PEER_LOCALMSPID=RegulatorMSP" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@regulator.com/msp/" peer0.regulator.com peer channel list
