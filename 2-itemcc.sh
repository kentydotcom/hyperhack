#!/bin/bash

#  Dr Kent G Lau
#  kenty@kenty.com

#  Hyperhack 2020


echo
echo "#################################################################"
echo "#######    List all INSTALLED chaincode   #######################"
echo "#################################################################"
sudo docker exec cli peer chaincode list --installed


echo
echo "#################################################################"
echo "#######    Package ITEMCC chaincode   ############################"
echo "#################################################################"
# sudo docker exec cli peer chaincode package ehrccpack.out -n ehrcc -v 1.0 -p /opt/gopath/src/github.com/EHR/nodejs -l node

sudo docker exec cli peer chaincode package itemccpack.out -n itemcc -v 1.0 -p /opt/gopath/src/github.com/item/nodejs -l node


echo
echo "#################################################################"
echo "#######    Install ITEMCC chaincode package   ####################"
echo "#################################################################"

# sudo docker exec cli peer chaincode install ehrccpack.out -n ehrcc -v 1.0 -l node

sudo docker exec cli peer chaincode install itemccpack.out -n itemcc -v 1.0 -l node
echo
echo "#################################################################"
echo "#######    List all INSTALLED chaincode   #######################"
echo "#################################################################"
sudo docker exec cli peer chaincode list --installed


# echo
# echo "#################################################################"
# echo "#######    List all INSTANTIATED chaincode   #######################"
# echo "#################################################################"
# sudo docker exec cli peer chaincode list --instantiated -C itemchannel


echo
echo "#################################################################"
echo "#######    Instantiate ITEMCC chaincode   ########################"
echo "#################################################################"
# sudo docker exec cli peer chaincode instantiate ehrccpack.out -n ehrcc -v 1.0 -l node -o orderer.regulator.com:7050 -C itemchannel -c '{"Args":[]}'

sudo docker exec cli peer chaincode instantiate itemccpack.out -n itemcc -v 1.0 -l node -o orderer.regulator.com:7050 -C itemchannel -c '{"Args":[]}'


echo
echo "#################################################################"
echo "#######    Chaincode instantiation complete!   ##################"
echo "#################################################################"
# sudo docker exec cli peer chaincode list --instantiated -C itemchannel
