import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:tempalteflutter/core/Utils/constants.dart';
import 'package:tempalteflutter/core/localstorage/localstorage.dart';
import 'package:tempalteflutter/modules/myProfile/views/provider/getalltrasactionprovider.dart';
import 'package:tempalteflutter/modules/myProfile/views/provider/getuserprovider.dart';

class UserWalletApis{

  Future<void> AddAmount(String amount,BuildContext context) async {

    const String apiUrl = '${BASEURL}api/v1/wallet/addWallet';

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await Storage().getItem('usertoken')}',
    };

    Map<String, dynamic> requestBody = {
      "balance": amount,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(requestBody),
      );

      print(response.body);

      if (response.statusCode == 200) {
        dynamic data = jsonDecode(response.body);
        Provider.of<GetUserDataProvider>(context, listen: false).getuser();
        Provider.of<GetUserAllTransactionProvider>(context, listen: false)
            .gettransaction();
        print(data);
      } else {
        dynamic data = jsonDecode(response.body);
        constToast(data.toString());
      }
    } catch (error) {
      constToast(error);
    }
  }

  Future<void> DeductAmount(String amount,BuildContext context) async {

    const String apiUrl = '${BASEURL}api/v1/wallet/removeWallet';

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await Storage().getItem('usertoken')}',
    };

    Map<String, dynamic> requestBody = {
      "balance": amount,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(requestBody),
      );

      print(response.body);

      if (response.statusCode == 200) {
        dynamic data = jsonDecode(response.body);
        Provider.of<GetUserDataProvider>(context, listen: false).getuser();
        print(data);
      } else {
        dynamic data = jsonDecode(response.body);
        constToast(data['message']);
      }
    } catch (error) {
      constToast(error);
    }
  }

}