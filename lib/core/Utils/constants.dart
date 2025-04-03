import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'dart:math';

const String BASEURL = 'https://9gamefire.com/api/';
const String BASEURL2 = 'https://rest.entitysport.com/v2/';
// const String CricketToken = 'aff57c2abeac5f2d33b63c41a13c5ba4';

String generateRandomString(int length) {
  const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
  final random = Random();
  return String.fromCharCodes(
    Iterable.generate(length, (_) => chars.codeUnitAt(random.nextInt(chars.length))),
  );
}

String getTimeDifference({required String time}) {
  DateTime now = DateTime.now();
  DateTime futureDate = DateTime.parse(time);
  Duration difference = futureDate.difference(now);

  if (difference.inHours < 12) {
    return '${difference.inHours}h ${difference.inMinutes.remainder(60)}m';
  } else {
    DateFormat dateFormat = DateFormat('d MMMM h:mma');
    return dateFormat.format(futureDate);
  }
}


String formatNumber(int number) {
  if (number < 1000) {
    return number.toString();
  } else if (number < 100000) {
    return (number / 1000).toStringAsFixed(1) + 'K';
  } else if (number < 10000000) {
    return (number / 100000).toStringAsFixed(1) + 'L';
  } else if (number < 1000000000) {
    return (number / 10000000).toStringAsFixed(1) + 'Cr';
  } else if (number < 1000000000000) {
    return (number / 1000000000).toStringAsFixed(1) + 'B';
  } else {
    return (number / 1000000000000).toStringAsFixed(1) + 'T';
  }
}


String formatCurrentDateTime( ) {
  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm');
  String formatted = formatter.format(now);
  return formatted;
}

constToast(msg){
  return Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.white,
      textColor: Colors.black
  );
}

void showTopDialog(BuildContext context,String text) {
  showDialog(
    context: context,
    builder: (context) {
      return Container(
        alignment: Alignment.center,
        height: 100,
        width: 300,
        child: AlertDialog(
          title: Text(text),
        ),
      );
    },
  );
}

