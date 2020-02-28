#!/bin/bash

#  Dr Kent G Lau
#  kenty@kenty.com

#  Hyperhack 2020


echo
echo "#################################################################"
echo "#######    Add Record:  ITEM-ID 001   ###########################"
echo "#######                 ITEM-ID 002   ###########################"
echo "#######                 ITEM-ID 003   ###########################"
echo "#################################################################"
sudo docker exec cli peer chaincode invoke -o orderer.regulator.com:7050 -C itemchannel -n itemcc -c '{"function":"addRecord","Args":["001","manufacturer","paracetamol","10kg","GRAS","N",""]}' &&
sudo docker exec cli peer chaincode invoke -o orderer.regulator.com:7050 -C itemchannel -n itemcc -c '{"function":"addRecord","Args":["002","distributor","aspirin","10kg","GRAS","004","N"]}' &&
sudo docker exec cli peer chaincode invoke -o orderer.regulator.com:7050 -C itemchannel -n itemcc -c '{"function":"addRecord","Args":["003","shippingagent","fluorouracil","1kg","cytotoxic","N",""]}'



# async addRecord(ctx,itemId,data1,data2,data3,data4,data5,data6) {
#
#  let data={
#    'ITEM-ID:':itemId,
#    'STATUS:':data1,
#    'CONTENT:':data2,
#    'WEIGHT:':data3,
#    'HAZCHEM':data4,
#    'PARENT-ID':data5,
#    'REMARKS:':data6,
#     };
