'use strict';
const { Contract} = require('fabric-contract-api');

class item extends Contract {



   async queryRecord(ctx,itemId) {

    let dataAsBytes = await ctx.stub.getState(itemId);
    // let dataAsBytes = await ctx.stub.getState(itemId,itemTag);
    if (!dataAsBytes || dataAsBytes.toString().length <= 0) {
      throw new Error('ITEM WITH THIS ID DOES NOT EXIST: ');
       }
      let data=JSON.parse(dataAsBytes.toString());

      return JSON.stringify(data);
     }

   async addRecord(ctx,itemId,data1,data2,data3,data4,data5,data6) {

    let data={
      '001-ITEM-ID:':itemId,
      '002-STATUS:':data1,
      '003-CONTENT:':data2,
      '004-WEIGHT:':data3,
      '005-HAZCHEM':data4,
      '006-PARENT-ID':data5,
      '007-REMARKS:':data6,
       };

    await ctx.stub.putState(itemId,Buffer.from(JSON.stringify(data)));

    console.log('ITEM RECORD ADDED TO THE LEDGER SUCCESSFULLY!');

  }


  //  async addTag(ctx,itemTag,message) {
  //
  //   let tag={
  //     'ITEM-TAG:':itemTag,
  //     'MESSAGE:':message,
  //      };
  //
  //   await ctx.stub.putState(itemId,Buffer.from(JSON.stringify(tag)));
  //
  //   console.log('TAG ADDED TO ITEM RECORD SUCCESSFULLY!');
  //
  // }


}

module.exports=item;
