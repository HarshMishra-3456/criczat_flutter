import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tempalteflutter/bloc/phoneEnteryBloc.dart';
import 'package:tempalteflutter/bloc/phoneVerificationBloc.dart';
import 'package:tempalteflutter/constance/themes.dart';
import 'package:tempalteflutter/core/Utils/constants.dart';
import 'package:tempalteflutter/modules/login/continuebutton.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:tempalteflutter/constance/global.dart' as globals;
import 'package:tempalteflutter/modules/phoneauth/data/authapi.dart';
import 'package:tempalteflutter/modules/setting/views/screens/termsandcondtion.dart';

var selectedCountryCode = '91';

class PhoneValidationScreen extends StatefulWidget {
  @override
  _PhoneValidationScreenState createState() => _PhoneValidationScreenState();
}

class _PhoneValidationScreenState extends State<PhoneValidationScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  final phoneEntryBloc = PhoneEntryBloc(PhoneEntryBlocState.initial());

  TextEditingController phoneno = TextEditingController();
  TextEditingController phonenumber = TextEditingController();
  TextEditingController refercode = TextEditingController();

  String countryCode = "91";

  var phonNumberContorller = new TextEditingController();
  var phoneFocusNode = FocusNode();
  var phonNumber = '';

  var isLoginProsses = false;
  bool isaccept = false;

  @override
  void initState() {
    globals.phoneVerificationBloc =
        PhoneVerificationBloc(PhoneVerificationBlocState.initial());
    _animationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 400));
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   requestLocationPermission(context);
    // });
    super.initState();
  }

  @override
  void dispose() {
    phoneFocusNode.dispose();
    phonNumberContorller.dispose();
    super.dispose();
  }

  bool isChecked = false;
  bool iscode = false;

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
                  // Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              title: Text(
                'CRICZAT',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.black,
                ),
              ),
            ),
            backgroundColor: Colors.transparent,
            body: ModalProgressHUD(
              inAsyncCall: isLoginProsses,
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(new FocusNode());
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _row1(),
                    Container(
                      height: 50,
                      margin: EdgeInsets.only(left: 20, right: 20),
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          border: Border.all(
                              color:
                                  AllCoustomTheme.getThemeData().primaryColor,
                              width: 2)),
                      child: Row(
                        children: [
                          Text(
                            '+91',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 18),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                              height: 30,
                              width: 2,
                              color:
                                  AllCoustomTheme.getThemeData().primaryColor),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 6),
                              child: SizedBox(
                                height: 50,
                                child: TextField(
                                  controller: phonenumber,
                                  maxLength: 10,
                                  keyboardType:
                                      TextInputType.numberWithOptions(),
                                  decoration: InputDecoration(
                                    counterText: '',
                                    hintText: 'Enter mobile number',
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    iscode
                        ? Container(
                            height: 50,
                            margin: EdgeInsets.only(left: 20, right: 20),
                            padding: EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                                border: Border.all(
                                    color: AllCoustomTheme.getThemeData()
                                        .primaryColor,
                                    width: 2)),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 6),
                                    child: SizedBox(
                                      height: 50,
                                      child: TextField(
                                        controller: refercode,
                                        maxLength: 10,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          counterText: '',
                                          hintText: 'Enter refer code',
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : SizedBox(),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          iscode = !iscode;
                        });
                      },
                      child: Text(
                        'Have a refer code?',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'By Clicking, I accept the',
                      style: TextStyle(color: Colors.grey, fontSize: 18),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value!;
                            });
                          },
                          activeColor:
                              AllCoustomTheme.getThemeData().primaryColor,
                        ),
                        SizedBox(width: 5),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TermsAndCondtions(),
                                ));
                          },
                          child: Text(
                              'Terms of Services  &  Privacy \n and Policy',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: AllCoustomTheme.getThemeData()
                                      .primaryColor)),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 14, left: 14),
                      child: ContinueButton(
                          name: "Next",
                          callBack: () async {
                            await requestLocationPermission(context);

                            Position position =
                                await Geolocator.getCurrentPosition(
                                    desiredAccuracy: LocationAccuracy.high);

                            await checkStateAndBanUser(position, context);

                            if (phonenumber.text.isNotEmpty) {
                              if (validatePhoneNumber(phonenumber.text)) {
                                if (isChecked == true) {
                                  FocusScope.of(context)
                                      .requestFocus(new FocusNode());
                                  setState(() {
                                    isLoginProsses = true;
                                  });
                                  await Authentication().LoginApi(
                                      phonenumber.text,
                                      context,
                                      refercode.text);
                                  setState(() {
                                    isLoginProsses = false;
                                  });
                                } else {
                                  constToast('Accept Terms and Conditions');
                                }
                              } else {
                                constToast('Invalid phone number');
                              }
                            } else {
                              constToast('Enter Phone Number');
                            }
                          }),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  bool validatePhoneNumber(String phoneNumber) {
    final phoneRegex = RegExp(r'^[0-9]{10}$');

    if (phoneNumber.isEmpty) {
      return false;
    } else if (!phoneRegex.hasMatch(phoneNumber)) {
      return false;
    }
    return true;
  }

  Widget _row1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Enter Your 10-digit \n Mobile Number',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Poppins',
              color: AllCoustomTheme.getThemeData().primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ),
      ],
    );
  }
}

Future<void> requestLocationPermission(BuildContext context) async {
  PermissionStatus status = await Permission.location.status;

  if (status.isDenied) {
    PermissionStatus result = await Permission.location.request();

    if (result.isDenied) {
      constToast('Location permission is required to use this feature.');
      await openAppSettings();
    } else if (result.isPermanentlyDenied) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Location Permission Required'),
            content: Text(
                'Please enable location permission in app settings to use this feature.'),
            actions: [
              TextButton(
                onPressed: () async {
                  await openAppSettings();
                },
                child: Text('Open Settings'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Cancel'),
              ),
            ],
          );
        },
      );
    }
  } else if (status.isGranted) {
  }
}

Future<void> checkStateAndBanUser(
    Position position, BuildContext context) async {
  List<Placemark> placemarks =
      await placemarkFromCoordinates(position.latitude, position.longitude);

  if (placemarks.isNotEmpty) {
    String? state = placemarks.first.administrativeArea;
    List<String> bannedStates = [
      'Andhra Pradesh',
      'Assam',
      'Nagaland',
      'Sikkim',
      'Telangana'
    ];

    if (bannedStates.contains(state)) {
      _showBanMessage(context, state!);
    }
  }
}

void _showBanMessage(BuildContext context, String state) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        title: Text(
          'App Banned',
          style: TextStyle(fontFamily: 'Poppins'),
        ),
        content: Text(
          'The app is banned in your state $state',
          style: TextStyle(fontFamily: 'Poppins', fontSize: 18),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(''),
            onPressed: () {
              // Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
    barrierDismissible: false,
  );
}
