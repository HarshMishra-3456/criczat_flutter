import 'package:flutter/material.dart';
import 'package:tempalteflutter/bloc/phoneVerificationBloc.dart';
import 'package:tempalteflutter/models/userData.dart';

var primaryColorString = Color(0xFFA50E0E);

var secondaryColorString = Color(0xFFE6ECF1);
var usertoken = '';
UserData? userdata;
PhoneVerificationBloc? phoneVerificationBloc;

List<String> colors = ['#4FBE9F', '#32a852', '#e6230e', '#760ee6', '#db0ee6', '#db164e'];
int colorsIndex = 0;

bool isHideTabBar = false;
