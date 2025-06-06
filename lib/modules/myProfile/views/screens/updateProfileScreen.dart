import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tempalteflutter/constance/constance.dart';
import 'package:tempalteflutter/constance/themes.dart';
import 'package:tempalteflutter/core/Utils/constants.dart';
import 'package:tempalteflutter/models/cityResponseData.dart';
import 'package:tempalteflutter/models/countryResponseData.dart';
import 'package:tempalteflutter/models/stateResponseData.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:tempalteflutter/models/userData.dart';
import 'package:tempalteflutter/modules/myProfile/data/updateuserprofile.dart';
import 'package:tempalteflutter/validator/validator.dart';

class UpdateProfileScreen extends StatefulWidget {
  final UserData? loginUserData;

  const UpdateProfileScreen({Key? key, this.loginUserData}) : super(key: key);
  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  UserData loginUserData = new UserData();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isProsses = false;
  var countryList = <CountryList>[];
  var stateList = <StateList>[];
  var cityList = <CityList>[];

  var imageUrl = '';
  var userNameController = new TextEditingController();
  var cityController = new TextEditingController();
  var stateController = new TextEditingController();
  var emailController = new TextEditingController();
  var referCodeController = new TextEditingController();
  var phoneController = new TextEditingController();

  var userNameFocusNode = FocusNode();
  var emailFocusNode = FocusNode();
  var dobFocusNode = FocusNode();
  var stateFocusNode = FocusNode();
  var cityFocusNode = FocusNode();
  var referFocusNode = FocusNode();
  var date = DateTime.now();
  var isLoginProsses = false;
  CountryList selectedCountry = new CountryList();
  StateList slectedState = new StateList();
  var _selectedStateIndex = 0;

  CityList slectedCity = new CityList();
  var _selectedCityIndex = 0;

  String countryCode = '';
  File? _image;

  var genderList = ['male', 'female', 'other'];
  var selectedGender = 'male';
  var genderListIndex = 0;

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    referCodeController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AllCoustomTheme.getThemeData().primaryColor,
            AllCoustomTheme.getThemeData().primaryColor,
            Colors.white,
            Colors.white,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: AllCoustomTheme.getThemeData().colorScheme.background,
          body: ModalProgressHUD(
            inAsyncCall: isLoginProsses,
            color: Colors.transparent,
            progressIndicator: CircularProgressIndicator(
              strokeWidth: 2.0,
            ),
            child: Column(
              children: <Widget>[
                Container(
                  color: AllCoustomTheme.getThemeData().primaryColor,
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: AppBar().preferredSize.height,
                        child: Row(
                          children: <Widget>[
                            Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  width: AppBar().preferredSize.height,
                                  height: AppBar().preferredSize.height,
                                  child: Icon(
                                    Icons.arrow_back,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Center(
                                child: Text(
                                  'Update Profile',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                    color: AllCoustomTheme.getThemeData().colorScheme.background,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: AppBar().preferredSize.height,
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(top: 16, bottom: 60),
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Stack(
                          children: <Widget>[
                            InkWell(
                              onTap: () {
                                userprofile();
                              },
                              child: Container(
                                height: 100,
                                width: 96,
                                decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color: Colors.black45,
                                        offset: Offset(1.1, 1.1),
                                        blurRadius: 3.0),
                                  ],
                                ),
                                child: new ClipRRect(
                                  borderRadius: new BorderRadius.circular(48.0),
                                  child: Container(
                                    decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: Container(
                                      decoration: new BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: CircleAvatar(
                                        radius: 48,
                                        child: selectimage == null
                                            ? Container(
                                                height: 100,
                                                width: 100,
                                                decoration: BoxDecoration(
                                                    color: Colors.grey,
                                                    shape: BoxShape.circle),
                                              )
                                            : SizedBox(
                                                height: 100,
                                                width: 100,
                                                child: new Image.file(
                                                  selectimage!,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                        backgroundColor: Colors.transparent,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            new Positioned(
                              left: 70.0,
                              top: 70.0,
                              child: Container(
                                decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.transparent,
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                        color: Colors.black54,
                                        offset: Offset(1.1, 1.1),
                                        blurRadius: 2.0),
                                  ],
                                ),
                                height: 24,
                                width: 24,
                                child: GestureDetector(
                                  child: new CircleAvatar(
                                    backgroundColor:
                                        AllCoustomTheme.getThemeData()
                                            .colorScheme.background,
                                    child: Icon(
                                      Icons.edit,
                                      size: 18,
                                      color: AllCoustomTheme.getThemeData()
                                          .primaryColor,
                                    ),
                                  ),
                                  onTap: () {},
                                ),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: <Widget>[
                                new Container(
                                  padding: EdgeInsets.only(right: 16),
                                  child: Column(
                                    children: <Widget>[
                                      new Container(
                                        padding: const EdgeInsets.only(top: 16),
                                        child: new TextFormField(
                                          controller: userNameController,
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize:
                                                ConstanceData.SIZE_TITLE16,
                                            color: AllCoustomTheme
                                                .getBlackAndWhiteThemeColors(),
                                          ),
                                          autofocus: false,
                                          focusNode: userNameFocusNode,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          decoration: new InputDecoration(
                                            labelText: 'Name',
                                            icon: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 16),
                                            ),
                                          ),
                                          onEditingComplete: () {
                                            FocusScope.of(context)
                                                .requestFocus(emailFocusNode);
                                          },
                                          validator: _validateUserName,
                                          onSaved: (value) {
                                            loginUserData.name = value;
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Container(
                                        child: TextFormField(
                                          controller: emailController,
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize:
                                                ConstanceData.SIZE_TITLE16,
                                            color: AllCoustomTheme
                                                .getBlackAndWhiteThemeColors(),
                                          ),
                                          // autofocus: false,
                                          focusNode: emailFocusNode,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          // enabled: false,
                                          decoration: new InputDecoration(
                                            labelText: 'Email',
                                            icon: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 14),
                                            ),
                                          ),
                                          onEditingComplete: () {
                                            FocusScope.of(context)
                                                .requestFocus(dobFocusNode);
                                          },
                                          validator: _validateEmail,
                                          onSaved: (value) {
                                            loginUserData.email = value;
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      _buildDatePicker(context),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      _buildGenderPickerDemo(context),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Container(
                                        child: TextFormField(
                                          controller: cityController,
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize:
                                                ConstanceData.SIZE_TITLE16,
                                            color: AllCoustomTheme
                                                .getBlackAndWhiteThemeColors(),
                                          ),
                                          // autofocus: false,
                                          // focusNode: emailFocusNode,
                                          keyboardType: TextInputType.text,
                                          // enabled: false,
                                          decoration: new InputDecoration(
                                            labelText: 'City',
                                            icon: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 14),
                                            ),
                                          ),
                                          onEditingComplete: () {
                                            FocusScope.of(context)
                                                .requestFocus(dobFocusNode);
                                          },
                                          onSaved: (value) {
                                            // loginUserData.email = value;
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      Container(
                                        child: TextFormField(
                                          controller: stateController,
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize:
                                                ConstanceData.SIZE_TITLE16,
                                            color: AllCoustomTheme
                                                .getBlackAndWhiteThemeColors(),
                                          ),
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          decoration: new InputDecoration(
                                            labelText: 'State',
                                            icon: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 14),
                                            ),
                                          ),
                                          onEditingComplete: () {
                                            FocusScope.of(context)
                                                .requestFocus(dobFocusNode);
                                          },
                                          onSaved: (value) {
                                            // loginUserData.email = value;
                                          },
                                        ),
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      new Container(
                                        child: TextFormField(
                                          controller: phoneController,
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize:
                                                ConstanceData.SIZE_TITLE16,
                                            color: AllCoustomTheme
                                                .getBlackAndWhiteThemeColors(),
                                          ),
                                          autofocus: false,
                                          keyboardType: TextInputType.number,
                                          decoration: new InputDecoration(
                                            labelStyle: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize:
                                                  ConstanceData.SIZE_TITLE16,
                                            ),
                                            labelText: 'Mobile Number',
                                            icon: Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 14),
                                            ),
                                          ),
                                          enabled: false,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 24,
                                      ),
                                      Container(
                                        height: 40,
                                        padding: EdgeInsets.only(
                                            left: 50, right: 50, bottom: 0),
                                        child: Container(
                                          decoration: new BoxDecoration(
                                            color:
                                                AllCoustomTheme.getThemeData()
                                                    .primaryColor,
                                            borderRadius:
                                                new BorderRadius.circular(4.0),
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.5),
                                                  offset: Offset(0, 1),
                                                  blurRadius: 5.0),
                                            ],
                                          ),
                                          child: Material(
                                            color: Colors.transparent,
                                            child: InkWell(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      4.0),
                                              onTap: () async {
                                                // _submit();
                                                await updateuserprofile(
                                                    name:
                                                        userNameController.text,
                                                    email: emailController.text,
                                                    dob: date
                                                        .toString()
                                                        .substring(0, 11),
                                                    // phone: phoneController.text,
                                                    gender: selectedGender,
                                                    city: cityController.text,
                                                    state: stateController.text,
                                                    pic: selectimage, context: context);
                                              },
                                              child: Center(
                                                child: Text(
                                                  'Update Profile',
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: ConstanceData
                                                        .SIZE_TITLE12,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 24,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  File? selectimage;

  userprofile() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1800,
      maxHeight: 1800,
    );

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);

      int fileSizeInBytes = await imageFile.length();
      double fileSizeInKB = fileSizeInBytes / 1024;
      double fileSizeInMB = fileSizeInKB / 1024;

      if (fileSizeInMB > 5) {
        constToast('Image size exceeds 5 MB. Please select a smaller image.');
      } else {
        setState(() {
          selectimage = imageFile;
        });
        constToast('Image selected.');
      }
    }
  }

  String? _validateUserName(String? value) {
    if (value!.isEmpty) {
      return 'UserName can not be empty';
    } else {
      return null;
    }
  }

  String? _validateEmail(String? value) {
    if (value!.isEmpty) {
      return 'Email can not be empty';
    } else {
      if (!Validators().emailValidator(value)) {
        return 'Email is not valid';
      } else {
        return null;
      }
    }
  }

  Widget _buildDatePicker(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          showCupertinoModalPopup<void>(
            context: context,
            builder: (BuildContext context) {
              return _buildBottomPicker(
                CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: (DateTime newDateTime) {
                    setState(() => date = newDateTime);
                  },
                ),
              );
            },
          );
        },
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Text(
                        'Date of Birth',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: DateFormat.yMd().format(date) !=
                                  DateFormat.yMd().format(DateTime.now())
                              ? ConstanceData.SIZE_TITLE12
                              : ConstanceData.SIZE_TITLE16,
                          color: HexColor('#8C8C8C'),
                        ),
                      ),
                    ),
                    DateFormat.yMd().format(date) !=
                            DateFormat.yMd().format(DateTime.now())
                        ? Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              DateFormat.yMd().format(date) !=
                                      DateFormat.yMd().format(DateTime.now())
                                  ? DateFormat.yMMMMd().format(date)
                                  : '',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE16,
                                color: DateTime.now().difference(date).inDays >=
                                        6570
                                    ? AllCoustomTheme
                                        .getBlackAndWhiteThemeColors()
                                    : Colors.red,
                              ),
                            ),
                          )
                        : SizedBox(
                            width: 0,
                            height: 8,
                          ),
                    Padding(
                      padding: EdgeInsets.only(top: 12),
                      child: Container(
                        height: 1.2,
                        color: HexColor('#8C8C8C'),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildGenderPickerDemo(BuildContext context) {
    final FixedExtentScrollController scrollController =
        FixedExtentScrollController(initialItem: genderListIndex);
    return Container(
      child: InkWell(
        onTap: () async {
          await showCupertinoModalPopup<void>(
            context: context,
            builder: (BuildContext context) {
              return _buildBottomPicker(
                CupertinoPicker(
                  scrollController: scrollController,
                  itemExtent: 44,
                  backgroundColor: CupertinoColors.white,
                  onSelectedItemChanged: (int index) {
                    setState(() => genderListIndex = index);
                  },
                  children:
                      List<Widget>.generate(genderList.length, (int index) {
                    return Center(
                      child: Text(genderList[index][0].toUpperCase() +
                          genderList[index].substring(1).toLowerCase()),
                    );
                  }),
                ),
              );
            },
          ).then((t) {
            selectedGender = genderList[genderListIndex];
          });
        },
        child: Row(
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        'Gender',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE12,
                          color: HexColor('#8C8C8C'),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        genderList[genderListIndex][0].toUpperCase() +
                            genderList[genderListIndex]
                                .substring(1)
                                .toLowerCase(),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 12),
                      child: Container(
                        height: 1.2,
                        color: HexColor('#8C8C8C'),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBottomPicker(Widget picker) {
    return Container(
      height: 216.0,
      padding: const EdgeInsets.only(top: 6.0),
      color: CupertinoColors.white,
      child: DefaultTextStyle(
        style: const TextStyle(
          fontFamily: 'Poppins',
          color: CupertinoColors.black,
          fontSize: 22.0,
        ),
        child: SafeArea(
          top: false,
          child: picker,
        ),
      ),
    );
  }

  void showInSnackBar(String value) {
    var snackBar = SnackBar(
      backgroundColor: Colors.red,
      content: new Text(
        value,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: ConstanceData.SIZE_TITLE14,
          color: AllCoustomTheme.getReBlackAndWhiteThemeColors(),
        ),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _submit() async {
    FocusScope.of(context).requestFocus(FocusNode());

    if (_formKey.currentState!.validate() == false) {
      return;
    }
    if (DateTime.now().difference(date).inDays < 6570) {
      showInSnackBar("Please!, Enter your valid birth date.");
      return;
    }

    _formKey.currentState!.save();
    loginUserData.name = userNameController.text;
    loginUserData.dob = DateFormat('dd/MM/yyyy').format(date);
    loginUserData.gender = genderList[genderListIndex];
    loginUserData.email = emailController.text;
    loginUserData.state = stateList[_selectedStateIndex].name;
    loginUserData.city = cityList[_selectedCityIndex].name;
    loginUserData.referral = referCodeController.text;

    setState(() {
      isLoginProsses = true;
    });

    Fluttertoast.showToast(
      msg: 'Succsessfull Update Profile',
    );
    Navigator.pop(context);

    setState(() {
      isLoginProsses = false;
    });
  }
}
