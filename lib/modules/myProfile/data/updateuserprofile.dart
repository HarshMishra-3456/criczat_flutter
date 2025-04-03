import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:tempalteflutter/core/Utils/constants.dart';
import 'package:http/http.dart' as http;
import 'package:tempalteflutter/core/localstorage/localstorage.dart';
import 'package:tempalteflutter/modules/myProfile/views/provider/getuserprovider.dart';

Future<void> updateuserprofile({
  required String name,
  required String email,
  required String dob,
  required String gender,
  required BuildContext context,
  required String city,
  required String state,
  required File? pic,
}) async {
  var request = http.MultipartRequest(
    "PUT",
    Uri.parse('${BASEURL}api/v1/user/updateProfile'),
  );

  var headers = {
    'Content-Type': 'multipart/form-data',
    'Authorization': 'Bearer ${await Storage().getItem('usertoken')}',
  };

  request.fields['fullName'] = name;
  request.fields['phone'] = await Storage().getItem('phoneno');
  request.fields['email'] = email;
  request.fields['dob'] = dob;
  request.fields['gender'] = gender;
  request.fields['state'] = state;
  request.fields['city'] = city;
  if (pic != null) {
    request.files.add(await http.MultipartFile.fromPath(
      'image',
      pic.path,
    ));
  }
  request.headers.addAll(headers);

  try {
    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    constToast('Update profile successfully.');
    Provider.of<GetUserDataProvider>(context, listen: false).getuser();
    Navigator.pop(context);
  } catch (e) {
    constToast(e.toString());
    rethrow;
  }
}
