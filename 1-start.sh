#!/bin/bash

#  Dr Kent G Lau
#  kenty@kenty.com

#  Hyperhack 2020

sudo docker-compose -f docker-compose.yml down

echo
echo "#################################################################"
echo "#######    Starting network:  ###################################"
echo "#################################################################"

sudo docker-compose -f docker-compose.yml up -d # ca.regulator.com orderer.regulator.com peer0.regulator.com couchdb

echo
echo "#################################################################"
echo "#######    List of all network containers   #####################"
echo "#################################################################"

sudo docker ps -a

# wait for Hyperledger Fabric to start
# incase of errors when running later commands, issue export FABRIC_START_TIMEOUT=<larger number>
export FABRIC_START_TIMEOUT=10
#echo ${FABRIC_START_TIMEOUT}
sleep ${FABRIC_START_TIMEOUT}


echo
echo "#################################################################"
echo "#######    Creating itemchannel  ### ############################"
echo "#################################################################"

### Create the channel - peer0.regulator.com
# sudo docker exec -e "CORE_PEER_LOCALMSPID=RegulatorMSP" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@regulator.com/msp" peer0.regulator.com peer channel create -o orderer.regulator.com:7050 -c itemchannel -f /etc/hyperledger/configtx/itemchannel.tx

### Create the channel - CLI for peer0.regulator.com
sudo docker exec -e "CORE_PEER_LOCALMSPID=RegulatorMSP" -e "CORE_PEER_ADDRESS=peer0.regulator.com:7051" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/regulator.com/users/Admin@regulator.com/msp/" cli peer channel create -o orderer.regulator.com:7050 -c itemchannel -f /etc/hyperledger/configtx/itemchannel.tx


sudo docker exec -e "CORE_PEER_LOCALMSPID=RegulatorMSP" -e "CORE_PEER_ADDRESS=peer0.regulator.com:7051" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/regulator.com/users/Admin@regulator.com/msp/" cli peer channel create -o orderer.regulator.com:7050 -c medicalchannel -f /etc/hyperledger/configtx/medicalchannel.tx



# sudo docker exec -e "CORE_PEER_LOCALMSPID=PatientMSP" -e "CORE_PEER_ADDRESS=peer0.patient.com:7051" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/patient.com/users/Admin@patient.com/msp/" cli peer channel create -o orderer.regulator.com:7050 -c patientchannel -f /etc/hyperledger/configtx/patientchannel.tx


echo
echo "#################################################################"
echo "#######    Joining peer0.regulator.com to channels   ############"
echo "#################################################################"

### Join peer0.regulator.com to the channel.
# sudo docker exec -e "CORE_PEER_LOCALMSPID=RegulatorMSP" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@regulator.com/msp" peer0.regulator.com peer channel join -b itemchannel.block

### CLI join peer0.regulator.com to the channel.
sudo docker exec -e "CORE_PEER_LOCALMSPID=RegulatorMSP" -e "CORE_PEER_ADDRESS=peer0.regulator.com:7051" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/regulator.com/users/Admin@regulator.com/msp/" cli peer channel join -b itemchannel.block


sudo docker exec -e "CORE_PEER_LOCALMSPID=RegulatorMSP" -e "CORE_PEER_ADDRESS=peer0.regulator.com:7051" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/regulator.com/users/Admin@regulator.com/msp/" cli peer channel join -b medicalchannel.block

### Test to show that Regulator cannot join patientchannel
# sudo docker exec -e "CORE_PEER_LOCALMSPID=RegulatorMSP" -e "CORE_PEER_ADDRESS=peer0.regulator.com:7051" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/regulator.com/users/Admin@regulator.com/msp/" cli peer channel join -b patientchannel.block


echo
echo "#################################################################"
echo "#######    Joining peer0.manufacturer.com to channels   #########"
echo "#################################################################"

### CLI join peer0.regulator.com to the channel.
sudo docker exec -e "CORE_PEER_LOCALMSPID=ManufacturerMSP" -e "CORE_PEER_ADDRESS=peer0.manufacturer.com:7051" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/manufacturer.com/users/Admin@manufacturer.com/msp/" cli peer channel join -b itemchannel.block


sudo docker exec -e "CORE_PEER_LOCALMSPID=ManufacturerMSP" -e "CORE_PEER_ADDRESS=peer0.manufacturer.com:7051" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/manufacturer.com/users/Admin@manufacturer.com/msp/" cli peer channel join -b medicalchannel.block


# sudo docker exec -e "CORE_PEER_LOCALMSPID=ManufacturerMSP" -e "CORE_PEER_ADDRESS=peer0.manufacturer.com:7051" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/manufacturer.com/users/Admin@manufacturer.com/msp/" cli peer channel join -b patientchannel.block


echo
echo "#################################################################"
echo "#######    Joining peer0.distributor.com to channels   ##########"
echo "#################################################################"

### CLI join peer0.regulator.com to the channel.
sudo docker exec -e "CORE_PEER_LOCALMSPID=DistributorMSP" -e "CORE_PEER_ADDRESS=peer0.distributor.com:7051" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/distributor.com/users/Admin@distributor.com/msp/" cli peer channel join -b itemchannel.block


sudo docker exec -e "CORE_PEER_LOCALMSPID=DistributorMSP" -e "CORE_PEER_ADDRESS=peer0.distributor.com:7051" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/distributor.com/users/Admin@distributor.com/msp/" cli peer channel join -b medicalchannel.block


# sudo docker exec -e "CORE_PEER_LOCALMSPID=DistributorMSP" -e "CORE_PEER_ADDRESS=peer0.distributor.com:7051" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/distributor.com/users/Admin@distributor.com/msp/" cli peer channel join -b patientchannel.block



echo
echo "#################################################################"
echo "#######    Joining peer0.shippingagent.com to channels   ########"
echo "#################################################################"

### CLI join peer0.regulator.com to the channel.
sudo docker exec -e "CORE_PEER_LOCALMSPID=ShippingAgentMSP" -e "CORE_PEER_ADDRESS=peer0.shippingagent.com:7051" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/shippingagent.com/users/Admin@shippingagent.com/msp/" cli peer channel join -b itemchannel.block


sudo docker exec -e "CORE_PEER_LOCALMSPID=ShippingAgentMSP" -e "CORE_PEER_ADDRESS=peer0.shippingagent.com:7051" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/shippingagent.com/users/Admin@shippingagent.com/msp/" cli peer channel join -b medicalchannel.block


# sudo docker exec -e "CORE_PEER_LOCALMSPID=ShippingAgentMSP" -e "CORE_PEER_ADDRESS=peer0.shippingagent.com:7051" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/shippingagent.com/users/Admin@shippingagent.com/msp/" cli peer channel join -b patientchannel.block


echo
echo "#################################################################"
echo "#######    Joining peer0.pharmacy.com to channels   #############"
echo "#################################################################"

### CLI join peer0.regulator.com to the channel.
sudo docker exec -e "CORE_PEER_LOCALMSPID=PharmacyMSP" -e "CORE_PEER_ADDRESS=peer0.pharmacy.com:7051" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/pharmacy.com/users/Admin@pharmacy.com/msp/" cli peer channel join -b itemchannel.block



sudo docker exec -e "CORE_PEER_LOCALMSPID=PharmacyMSP" -e "CORE_PEER_ADDRESS=peer0.pharmacy.com:7051" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/pharmacy.com/users/Admin@pharmacy.com/msp/" cli peer channel join -b medicalchannel.block


# sudo docker exec -e "CORE_PEER_LOCALMSPID=PharmacyMSP" -e "CORE_PEER_ADDRESS=peer0.pharmacy.com:7051" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/pharmacy.com/users/Admin@pharmacy.com/msp/" cli peer channel join -b patientchannel.block


echo
echo "#################################################################"
echo "#######    Joining peer0.doctor.com to channel   ################"
echo "#################################################################"

### CLI join peer0.regulator.com to the channel.
sudo docker exec -e "CORE_PEER_LOCALMSPID=DoctorMSP" -e "CORE_PEER_ADDRESS=peer0.doctor.com:7051" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/doctor.com/users/Admin@doctor.com/msp/" cli peer channel join -b itemchannel.block


sudo docker exec -e "CORE_PEER_LOCALMSPID=DoctorMSP" -e "CORE_PEER_ADDRESS=peer0.doctor.com:7051" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/doctor.com/users/Admin@doctor.com/msp/" cli peer channel join -b medicalchannel.block


# sudo docker exec -e "CORE_PEER_LOCALMSPID=DoctorMSP" -e "CORE_PEER_ADDRESS=peer0.doctor.com:7051" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/doctor.com/users/Admin@doctor.com/msp/" cli peer channel join -b patientchannel.block


echo
echo "#################################################################"
echo "#######    Joining peer0.patient.com to channels   ##############"
echo "#################################################################"

### CLI join peer0.regulator.com to the channel.
sudo docker exec -e "CORE_PEER_LOCALMSPID=PatientMSP" -e "CORE_PEER_ADDRESS=peer0.patient.com:7051" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/patient.com/users/Admin@patient.com/msp/" cli peer channel join -b itemchannel.block



sudo docker exec -e "CORE_PEER_LOCALMSPID=PatientMSP" -e "CORE_PEER_ADDRESS=peer0.patient.com:7051" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/patient.com/users/Admin@patient.com/msp/" cli peer channel join -b medicalchannel.block


# sudo docker exec -e "CORE_PEER_LOCALMSPID=PatientMSP" -e "CORE_PEER_ADDRESS=peer0.patient.com:7051" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/patient.com/users/Admin@patient.com/msp/" cli peer channel join -b patientchannel.block


echo
echo "#################################################################"
echo "#######    List of all channels joined by peer0.regulator.com  ##"
echo "#################################################################"

### Peer channel list
# sudo docker exec -e "CORE_PEER_LOCALMSPID=RegulatorMSP" -e "CORE_PEER_MSPCONFIGPATH=/etc/hyperledger/msp/users/Admin@regulator.com/msp" peer0.regulator.com peer channel list

### Peer channel list - Regulator

sudo docker exec -e "CORE_PEER_LOCALMSPID=RegulatorMSP" -e "CORE_PEER_ADDRESS=peer0.regulator.com:7051" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/regulator.com/users/Admin@regulator.com/msp/" cli peer channel list


###  Peer channel list - Manufacturer
# sudo docker exec -e "CORE_PEER_LOCALMSPID=ManufacturerMSP" -e "CORE_PEER_ADDRESS=peer0.manufacturer.com:7051" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/manufacturer.com/users/Admin@manufacturer.com/msp/" cli peer channel list
#
# echo
# echo "#################################################################"
# echo "#######    Starting network:  cli   #############################"
# echo "#################################################################"
#
# #Creating CLI Container
# sudo docker-compose -f ./docker-compose.yml up -d cli
