import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:tempalteflutter/core/Utils/constants.dart';
import 'package:tempalteflutter/core/localstorage/localstorage.dart';
import 'package:tempalteflutter/modules/contests/views/provider/getcontestbymatchprovider.dart';
import 'package:tempalteflutter/modules/contests/views/provider/getjoinedcontestprovider.dart';

class ContestApi {

  Future<void> JoinContest({required String contestid,required BuildContext context}) async {

    const String apiUrl = '${BASEURL}api/v1/contest/join';

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await Storage().getItem('usertoken')}',
    };

    Map<String, dynamic> requestBody = {
      "contestId": contestid
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
        constToast(data['message']);
        Provider.of<GetJoinedContestProvider>(context, listen: false)
            .getcontest();
        Provider.of<GetContestByMatchProvider>(context, listen: false)
            .getcontest();
      } else {
        dynamic data = jsonDecode(response.body);
        constToast(data['message']);
      }
    } catch (error) {
      constToast(error);
    }
  }

  Future<void> CreateContest({required String entryfee,required String contestsize,required String winningamount,required BuildContext context,}) async {

    const String apiUrl = '${BASEURL}api/v1/contests/create';

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await Storage().getItem('usertoken')}',
    };

    Map<String, dynamic> requestBody = {
      "match": await Storage().getItem('matchid'),
      "name": "Fantasy Cricket League",
      "entryFee": entryfee,
      "prizePool": winningamount,
      "startTime": DateTime.now().toString(),
      "endTime": DateTime.now().toString(),
      "maxParticipants": contestsize,
      "status": "pending", ///                enum: ['pending', 'active', 'completed', 'cancelled'],
      "type": "all",  ///  enum: ['private', 'all'],
      "rules": "Some rules for the contest"
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(requestBody),
      );

      print(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        dynamic data = jsonDecode(response.body);
        constToast(data['message']);
        Provider.of<GetContestByMatchProvider>(context, listen: false)
            .getcontest();
      } else {
        dynamic data = jsonDecode(response.body);
        constToast(data['message']);
      }
    } catch (error) {
      print(error);
      constToast(error.toString());
    }
  }
}