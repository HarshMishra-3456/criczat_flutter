// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:pinput/pinput.dart';
import 'package:tempalteflutter/constance/themes.dart';
import 'package:tempalteflutter/core/Utils/constants.dart';
import 'package:tempalteflutter/core/localstorage/localstorage.dart';
import 'package:tempalteflutter/modules/login/continuebutton.dart';
import 'package:tempalteflutter/modules/phoneauth/data/authapi.dart';
import 'package:telephony/telephony.dart';


class OtpValidationScreen extends StatefulWidget {
  final String phone;
  const OtpValidationScreen({Key? key, required this.phone}) : super(key: key);

  @override
  _OtpValidationScreenState createState() => _OtpValidationScreenState();
}

class _OtpValidationScreenState extends State<OtpValidationScreen> with TickerProviderStateMixin {
  var isLoginProsses = false;
  late AnimationController _animationController;
  var otpText = '';
  var istimeFinish = false;
  bool otppr = false;
  var otpTimerView = false;
  var otpController = TextEditingController();

  final Telephony telephony = Telephony.instance;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
    requestSmsPermission();
  }

  void requestSmsPermission() async {
    listenForSms();
    bool? permissionsGranted = await telephony.requestSmsPermissions;
    if (permissionsGranted == true) {
      listenForSms();
    } else {
      constToast('SMS permission is required to auto-fill OTP');
    }
  }

  void listenForSms() {
    telephony.listenIncomingSms(
      onNewMessage: (SmsMessage message) {

        if (message.body != null && message.body!.contains("Your OTP is:")) {
          String otpCode = message.body!.split("Your OTP is:")[1].trim().substring(0, 4);
          setState(() {
              otpController.text = otpCode;
          });
        }
      },
      listenInBackground: false,
    );
  }


  String extractOtpFromMessage(String message) {
    final RegExp otpRegex = RegExp(r'\d{4}');
    final match = otpRegex.firstMatch(message);
    if (match != null) {
      return match.group(0) ?? "";
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          color: AllCoustomTheme.getThemeData().colorScheme.background,
        ),
        SafeArea(
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: AllCoustomTheme.getThemeData().colorScheme.background,
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              ),
              title: Text(
                'Verify OTP',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                ),
              ),
            ),
            backgroundColor: Colors.transparent,
            body: ModalProgressHUD(
              inAsyncCall: isLoginProsses,
              child: Stack(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                    },
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(
                              height: 70,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  'Phone Verification',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 30,
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 24),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Verify Code',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'Please check your message and \n enter the verification code we just sent you \n (+91) ${widget.phone},',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 24,
                            ),
                            pinPut(context),
                            SizedBox(
                              height: 8,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 24, bottom: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    'OTP Not received?',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 18,
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      await Authentication().ResendOtp();
                                    },
                                    child: Text(
                                      ' Resend',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 14, left: 14),
                              child: ContinueButton(
                                name: "Next",
                                callBack: () async {
                                  FocusScope.of(context).requestFocus(FocusNode());
                                  setState(() {
                                    isLoginProsses = true;
                                  });
                                  await Authentication().OtpVerication(context);
                                  setState(() {
                                    isLoginProsses = false;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget pinPut(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Pinput(
          length: 4,
          controller: otpController,
          showCursor: true,
          defaultPinTheme: PinTheme(
            width: 70,
            height: 65,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.red),
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          onChanged: (value) async {
            Storage().setItem("otp", value);
          },
          onCompleted: (pin) => Storage().setItem("otp", pin),
        ),
        const SizedBox(
          height: 20,
        ),
      ],
    );
  }
}

