#!/bin/bash

#  Dr Kent G Lau
#  kenty@kenty.com

#  Hyperhack 2020


echo
echo "#################################################################"
echo "#######    Query Record:  ITEM-ID 001   #########################"
echo "#######                   ITEM-ID 002   #########################"
echo "#######                   ITEM-ID 003   #########################"
echo "#################################################################"
sudo docker exec cli peer chaincode query -o orderer.regulator.com:7050 -C itemchannel -n itemcc -c '{"function":"queryRecord","Args":["001"]}' && \
sudo docker exec cli peer chaincode query -o orderer.regulator.com:7050 -C itemchannel -n itemcc -c '{"function":"queryRecord","Args":["002"]}' && \
sudo docker exec cli peer chaincode query -o orderer.regulator.com:7050 -C itemchannel -n itemcc -c '{"function":"queryRecord","Args":["003"]}'
