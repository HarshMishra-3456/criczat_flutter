import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tempalteflutter/core/Utils/authutilities.dart';
import 'dart:convert';
import 'package:tempalteflutter/core/Utils/constants.dart';
import 'package:tempalteflutter/core/localstorage/localstorage.dart';
import 'package:tempalteflutter/modules/home/views/screens/tabScreen.dart';
import 'package:tempalteflutter/modules/login/otpValidationScreen.dart';


class Authentication{
  String otp = '';
  String userid = '';

  Future<void> LoginApi(String phoneno,BuildContext context,String refercode) async {

    const String apiUrl = '${BASEURL}api/v1/user/loginWithPhone';
    Uri uri = Uri.parse(apiUrl);

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> requestBody = {
      "phone": phoneno,
      "code": refercode
      // "code": "O7CGM2J2D"
    };

    try {
      final response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(requestBody),
      );

      print(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        dynamic data = jsonDecode(response.body);
        otp = data['data']['otp'];
        await Storage().setItem('userid', data['data']['id']);
        await Storage().setItem('phoneno', data['data']['phone']);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OtpValidationScreen(phone: phoneno),
          ),
        );
      } else {
        dynamic data = jsonDecode(response.body);
        constToast(data['message']);
      }
    } catch (error) {
      print(error);
      constToast(error);
    }
  }

  Future<void> OtpVerication(BuildContext context) async {

    final String apiUrl = '${BASEURL}api/v1/user/${await Storage().getItem('userid')}';
    print(apiUrl);

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> requestBody = {
      "otp": await Storage().getItem("otp"),
      "deviceToken": Authutilities.firebasetoken.trim()
    };

    print(requestBody);

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(requestBody),
      );
      print(response.body);

      if (response.statusCode == 200) {
        dynamic data = jsonDecode(response.body);
        constToast(data['message']);
        await Storage().setItem('userid', data['data']['userId']);
        await Storage().setItem('usertoken', data['data']['token']);
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => TabScreen(),
          ),
          (route) => false
        );
      } else {
        dynamic data = jsonDecode(response.body);
        constToast(data['message']);
      }
    } catch (error) {
      constToast(error);
    }
  }

  Future<void> ResendOtp() async {

    const String apiUrl = '${BASEURL}api/v1/user/loginWithPhone';

    Map<String, String> headers = {
      'Content-Type': 'application/json',
    };

    Map<String, dynamic> requestBody = {
      "phone": await Storage().getItem('phoneno'),
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
        // constToast(data['data']['otp']);
      } else {
        dynamic data = jsonDecode(response.body);
        constToast(data.toString());
      }
    } catch (error) {
      constToast(error);
    }
  }
}