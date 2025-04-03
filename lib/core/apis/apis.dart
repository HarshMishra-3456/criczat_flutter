import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:tempalteflutter/core/Utils/constants.dart';
import 'package:tempalteflutter/core/errors%20copy/failures.dart';
import 'package:tempalteflutter/core/localstorage/localstorage.dart';

class Apis {
  static Future<dynamic> get(String url, {String? key}) async {
    final headers = {
      'Authorization': 'Bearer ${await Storage().getItem('usertoken')}',
    };
    try {
      var response = await http.get(
        Uri.parse('$BASEURL$url'),
        headers: headers,
      );
      print(await Storage().getItem('usertoken'));

      // print(response.request);
      print(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        var decodedResponse = jsonDecode(response.body);
        return decodedResponse;
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        return AuthorizationFailure();
      } else if (response.statusCode == 400 || response.statusCode == 404) {
        return BadRequestFailue();
      } else if (response.statusCode == 500) {
        return ServerFailure();
      } else {
        print('noting');
        return OtherFailure();
      }
    } on SocketException {
      return NetworkFailue;
    } catch (e) {
      return OtherFailure();
    }
  }

  static Future<dynamic> get2(String url, {String? key}) async {

    // final headers = {
    //   'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY1NWRhY2NiMTY4NjIxNjA3M2FiMGQ2OSIsImlhdCI6MTcwMTYxNTQwMiwiZXhwIjoxNzAxODc0NjAyfQ.HmAqN6hvT8DefzB2kHpixrJ3HCpZbBSecd36w5z-1CA',
    // };

    try {
      var response = await http.get(
        Uri.parse('$BASEURL2$url'),
      );
      print(response.request);
      print(response.body);

      var decodedResponse = jsonDecode(response.body);

      print(response.statusCode);
      if (response.statusCode == 200) {
        return decodedResponse;
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        return AuthorizationFailure();
      } else if (response.statusCode == 400) {
        return BadRequestFailue();
      } else if (response.statusCode == 500) {
        return ServerFailure();
      } else {
        return OtherFailure();
      }
    } on SocketException {
      return NetworkFailue;
    } catch (e) {
      return OtherFailure();
    }
  }

  Future<dynamic> postRequest({required apiUrl, data, token}) async {
    final BuildContext context;
    var res =
        await http.post(body: data, Uri.parse('$BASEURL$apiUrl'), headers: {
      'Content-Type': 'application/json',
      // 'Authorization': '$token',
    });
    // print(res.body);
    // print(res.statusCode);
    if (res.statusCode == 200 || res.statusCode == 201) {
      return jsonDecode(res.body);
    } else if (res.statusCode == 401 ||
        res.statusCode == 400 ||
        res.statusCode == 409) {
      return jsonDecode(res.body);
    } else if (res.statusCode == 404) {
      return jsonDecode(res.body);
    } else if (res.statusCode == 500) {
      return Future.error(res.body);
    } else {
      return Future.error('Network Problem');
    }
  }
}
