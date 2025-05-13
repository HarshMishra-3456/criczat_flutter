import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../api/apiProvider.dart';
import '../../constance/themes.dart';
import '../../core/Utils/constants.dart';
import '../myProfile/views/provider/getuserprovider.dart';
import 'package:provider/provider.dart';


class Withdrawlrequestscreen extends StatefulWidget {
  const Withdrawlrequestscreen({super.key});

  @override
  State<Withdrawlrequestscreen> createState() => _WithdrawlrequestscreenState();
}

class _WithdrawlrequestscreenState extends State<Withdrawlrequestscreen> {


  List<dynamic>  mapList=[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
       ApiProvider().getProfile();
      getData();
    });


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white
        ),
        title: Text("Withdrawal Detail",style: TextStyle(color: Colors.white),),
        backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
      ),
      body:ListView.builder(
        itemCount: mapList.length,
        padding: EdgeInsets.symmetric(horizontal: 0,vertical: 20),
        itemBuilder: (BuildContext context, int index) {
          Map<String,dynamic> data=mapList[index];
          return  Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AllCoustomTheme.getThemeData().primaryColor,width: 2),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,spreadRadius: 1,blurRadius: 3
                )
              ]
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Name: ${data['name']}", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                Divider(thickness: 1,),
                Text("Account Number: ${data['account_number']}"),
                Text("IFSC: ${data['ifsc']}"),
                Text("Bank Name: ${data['bank_name']}"),
                Text("UPI ID: ${data['upi_id']}"),
                Text("Amount: ₹${data['amount']}"),
                Divider(thickness: 1,),
                Text("Phone: ${data['phone_number']}"),
                Text("Created At: ${data['created_at']}"),
              ],
            ),
          );
        },) ,
    );
  }


  getData()async{
    print(">>>>>>>>>123>>>>>>>>>");
         final provider = Provider.of<GetUserDataProvider>(context, listen: false);

         final phone = provider.cricketdata?.data.phone ?? '';
         print('$phone >>>$provider>>>>>>>>>>>>>>>>');

         if (phone.isNotEmpty) {
            fetchData(phone);
         } else {
           print("Phone number is empty");
         }
  }


  fetchData(String phone)async{
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('GET', Uri.parse(
        'https://grextech.org/criczat/fetch_payment.php?phone_number=$phone'));

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    var responceJsonString = await response.stream.bytesToString();

    var responceMap = jsonDecode(responceJsonString);
    print(responceJsonString);
    if (response.statusCode == 200) {
      if (responceMap["status"] == "success") {
        constToast("Success: Data Fetched");
        mapList = responceMap["data"];
        setState(() {});
      } else {
        constToast("Error :${responceMap["message"]}");
      }
    }
    else {
      constToast("Something went wrong");
    }
  }
}
