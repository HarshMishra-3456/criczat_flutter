import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tempalteflutter/core/Utils/constants.dart';
import 'package:tempalteflutter/core/localstorage/localstorage.dart';
import 'package:tempalteflutter/modules/home/views/screens/tabScreen.dart';

class MatchTeam {
  Future<void> CreateTeam(
      {required List<int> pid,
      required int capid,
      required int vccapid,
      required BuildContext context}) async {
    const String apiUrl = '${BASEURL}api/v1/teams/user';

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await Storage().getItem('usertoken')}',
    };

    Map<String, dynamic> requestBody = {
      "name": "TeamCricket11",
      "match": await Storage().getItem('matchid'),
      "players": pid,
      "captain": capid,
      "viceCaptain": vccapid
    };
    print(requestBody);

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(requestBody),
      );

      print(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        dynamic data = jsonDecode(response.body);
        print('iiiiiiiiiiiiiiiii');
        constToast(data['message']);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => TabScreen(),
            ),
            (route) => false);
      } else {
        dynamic data = jsonDecode(response.body);
        constToast(data['message']);
      }
    } catch (error) {
      constToast(error);
    }
  }

  Future<void> UpdateTeam(
      {required List<int> pid,
      required int capid,
      required int vccapid,
      required BuildContext context}) async {
    final String apiUrl =
        '${BASEURL}api/v1/teams/${await Storage().getItem('teamid')}';

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${await Storage().getItem('usertoken')}',
    };

    Map<String, dynamic> requestBody = {
      "name": "TeamCricket11",
      "match": await Storage().getItem('matchid'),
      "players": pid,
      "captain": capid,
      "viceCaptain": vccapid
    };

    print(requestBody);
    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: headers,
        body: jsonEncode(requestBody),
      );

      print(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        dynamic data = jsonDecode(response.body);
        constToast(data['message']);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => TabScreen(),
            ),
            (route) => false);
      } else {
        dynamic data = jsonDecode(response.body);
        constToast(data['message']);
      }
    } catch (error) {
      constToast(error);
    }
  }
}
