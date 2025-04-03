// ignore_for_file: unused_field, unnecessary_null_comparison, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tempalteflutter/api/apiProvider.dart';
import 'package:tempalteflutter/api/logout.dart';
import 'package:tempalteflutter/constance/constance.dart';
import 'package:tempalteflutter/constance/sharedPreferences.dart';
import 'package:tempalteflutter/constance/themes.dart';
import 'package:provider/provider.dart';
import 'package:tempalteflutter/core/localstorage/localstorage.dart';
import 'package:tempalteflutter/models/userData.dart';
import 'package:tempalteflutter/modules/drawer/views/screens/drawer.dart';
import 'package:tempalteflutter/modules/home/views/screens/homeScreen.dart';
import 'package:tempalteflutter/modules/myProfile/domain/getalltransactionmodel.dart';
import 'package:tempalteflutter/modules/myProfile/views/provider/getalltrasactionprovider.dart';
import 'package:tempalteflutter/modules/myProfile/views/provider/getuserprovider.dart';
import 'package:tempalteflutter/modules/myProfile/views/screens/transectionHistoryScreen.dart';
import 'package:tempalteflutter/modules/myProfile/views/screens/updateProfileScreen.dart';
import 'package:tempalteflutter/modules/myProfile/views/screens/verifydocuments.dart';
import 'package:tempalteflutter/modules/pymentOptions/withdrawScreen.dart';
import 'package:tempalteflutter/modules/standingScreen/views/provider/completematchprovider.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tempalteflutter/utils/avatarImage.dart';

var responseData;

class MyProfileScreen extends StatefulWidget {
  @override
  _MyProfileScreenState createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen>
    with SingleTickerProviderStateMixin {
  double _appBarHeight = 100.0;
  AppBarBehavior _appBarBehavior = AppBarBehavior.pinned;
  var name = '';
  var imageUrl = '';
  ScrollController _scrollController = new ScrollController();

  var data;



  @override
  void initState() {
    getUserData();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<GetUserDataProvider>(context, listen: false).getuser();
      Provider.of<GetUserAllTransactionProvider>(context, listen: false)
          .gettransaction();
      Provider.of<GetCompleteMatchesProvider>(context, listen: false)
          .getcomplete();
    });
    var profileData = ApiProvider().getProfile();
    if (profileData != null && profileData.data != null) {
      final txt = profileData.data!.name!.trim().split(' ');
      name = txt[0][0].toUpperCase() + txt[0].substring(1, txt[0].length);
      imageUrl = profileData.data!.image!;
      MySharedPreferences().setUserDataString(profileData.data!);
    }
  }

  void getUserData() async {
    var responseData = ApiProvider().getProfile();
    data = responseData.data;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Stack(
        children: [
          Container(
            color: AllCoustomTheme.getThemeData().primaryColor,
          ),
          SafeArea(
            child: Scaffold(
              backgroundColor: AllCoustomTheme.getThemeData().colorScheme.background,
              appBar: AppBar(
                elevation: 0,
                title: Consumer<GetUserDataProvider>(
                  builder: (context, value, child) {
                    if (value.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final userdata = value.todos;
                    if (userdata == null) {
                      return const Center(
                        child: Text('No data found'),
                      );
                    }
                    final todo = userdata.data;
                    return Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          todo.image == null
                              ? Container(
                                  height: 44,
                                  width: 44,
                                  child: AvatarImage(
                                    sizeValue: 44,
                                    radius: 44,
                                    isCircle: true,
                                    imageUrl:
                                        "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1534&q=80",
                                  ),
                                )
                              : CircleAvatar(
                                  radius: 20,
                                  backgroundImage: NetworkImage(todo.image),
                                ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            todo.fullName ?? '',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                bottom: TabBar(
                  tabs: [
                    Tab(
                      icon: Text(
                        "My Detail",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Tab(
                      icon: Text(
                        "Matches",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Tab(
                      icon: Text(
                        "Wallet",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              floatingActionButton: Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: FloatingActionButton(
                  foregroundColor:
                      AllCoustomTheme.getThemeData().colorScheme.background,
                  backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UpdateProfileScreen(
                          loginUserData: data,
                        ),
                      ),
                    );
                    getUserData();
                  },
                  child: Icon(Icons.edit),
                ),
              ),
              body: Container(
                color: AllCoustomTheme.getThemeData().colorScheme.background,
                child: Consumer<GetUserDataProvider>(
                  builder: (context, value, child) {
                    if (value.isLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    final userdata = value.todos;
                    if (userdata == null) {
                      return const Center(
                        child: Text('No data found'),
                      );
                    }
                    final todo = userdata.data;
                    return TabBarView(
                      children: <Widget>[
                        Container(
                          child: SingleChildScrollView(
                            padding: EdgeInsets.all(0),
                            physics: BouncingScrollPhysics(),
                            child: Container(
                              padding: EdgeInsets.only(top: 16),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    margin:
                                    EdgeInsets.only(left: 15, right: 15),
                                    padding: EdgeInsets.all(15),
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        color: Colors.black12,
                                        borderRadius:
                                        BorderRadius.circular(15)),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: [
                                            scancard(
                                                image: 'assets/adhar.png',
                                                details: 'Aadhaar',
                                                isicon: false,
                                                isverified: userdata
                                                    .data
                                                    .uploadId
                                                    .isAadharCardUpload),
                                            scancard(
                                                image: 'assets/pan.png',
                                                details: 'Pan',
                                                isicon: false,
                                                isverified: userdata.data
                                                    .uploadId.isPanCardUpload),
                                            scancard(
                                                card: Icons.account_balance,
                                                details: 'Bank',
                                                isicon: true,
                                                isverified: userdata
                                                    .data
                                                    .bankDetails
                                                    .isUploadbankDetails),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        (userdata.data
                                            .bankDetails.isUploadbankDetails &&
                                            userdata.data.uploadId
                                                .isAadharCardUpload &&
                                            userdata.data.uploadId
                                                .isPanCardUpload)
                                            ? SizedBox()
                                            : InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      AadharCardDetailsScreen(),
                                                ));
                                          },
                                          child: Align(
                                            alignment:
                                            Alignment.centerRight,
                                            child: Container(
                                              width: 100,
                                              padding: EdgeInsets.all(10),
                                              decoration: BoxDecoration(
                                                color: const Color(
                                                    0xFFB00020),
                                                borderRadius:
                                                BorderRadius.circular(
                                                    10),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black26,
                                                    offset: Offset(0, 2),
                                                    blurRadius: 4.0,
                                                  ),
                                                ],
                                              ),
                                              child: Center(
                                                child: Text(
                                                  'Verify',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontFamily: 'Poppins',
                                                    fontWeight:
                                                    FontWeight.w600,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(
                                        right: 16, left: 16, top: 4, bottom: 4),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: 100,
                                          child: Text(
                                            'Name',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize:
                                              ConstanceData.SIZE_TITLE16,
                                              color: AllCoustomTheme
                                                  .getTextThemeColors(),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            todo.fullName ?? '',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize:
                                              ConstanceData.SIZE_TITLE16,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Divider(),
                                  Container(
                                    padding: EdgeInsets.only(
                                        right: 16, left: 16, top: 4, bottom: 4),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: 100,
                                          child: Text(
                                            'Email',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize:
                                              ConstanceData.SIZE_TITLE16,
                                              color: AllCoustomTheme
                                                  .getTextThemeColors(),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            todo.email ?? '',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize:
                                              ConstanceData.SIZE_TITLE16,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Divider(),
                                  Container(
                                    padding: EdgeInsets.only(
                                        right: 16, left: 16, top: 4, bottom: 4),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: 100,
                                          child: Text(
                                            'Mobile No',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize:
                                              ConstanceData.SIZE_TITLE16,
                                              color: AllCoustomTheme
                                                  .getTextThemeColors(),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            "+91 ${todo.phone}",
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize:
                                              ConstanceData.SIZE_TITLE16,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Divider(),
                                  Container(
                                    padding: EdgeInsets.only(
                                        right: 16, left: 16, top: 4, bottom: 4),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: 100,
                                          child: Text(
                                            'Date of Birth',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize:
                                              ConstanceData.SIZE_TITLE16,
                                              color: AllCoustomTheme
                                                  .getTextThemeColors(),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            todo.dob ?? '',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize:
                                              ConstanceData.SIZE_TITLE16,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Divider(),
                                  Container(
                                    padding: EdgeInsets.only(
                                        right: 16, left: 16, top: 4, bottom: 4),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: 100,
                                          child: Text(
                                            'Gender',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize:
                                              ConstanceData.SIZE_TITLE16,
                                              color: AllCoustomTheme
                                                  .getTextThemeColors(),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            todo.gender ?? '',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize:
                                              ConstanceData.SIZE_TITLE16,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Divider(),
                                  Container(
                                    padding: EdgeInsets.only(
                                        right: 16, left: 16, top: 4, bottom: 4),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: 100,
                                          child: Text(
                                            'State',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize:
                                              ConstanceData.SIZE_TITLE16,
                                              color: AllCoustomTheme
                                                  .getTextThemeColors(),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            todo.state ?? '',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize:
                                              ConstanceData.SIZE_TITLE16,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Divider(),
                                  Container(
                                    padding: EdgeInsets.only(
                                        right: 16, left: 16, top: 4, bottom: 4),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          width: 100,
                                          child: Text(
                                            'City',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize:
                                              ConstanceData.SIZE_TITLE16,
                                              color: AllCoustomTheme
                                                  .getTextThemeColors(),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            todo.city ?? '',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize:
                                              ConstanceData.SIZE_TITLE16,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Divider(),
                                  logoutButton(),
                                ],
                              ),
                            ),
                          ),
                        ),
                        PlayingHistory(),
                        Wallet(todo.wallet.toString()),
                      ],
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget scancard(
      {IconData? card,
      required String details,
      required bool isicon,
      required bool isverified,
      String? image}) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              width: 60,
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), color: Colors.white),
              child: Column(
                children: [
                  isicon
                      ? Icon(
                          card,
                          color: Colors.black45,
                          size: 40,
                        )
                      : Image.asset(image.toString())
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              details,
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 15),
            )
          ],
        ),
        isverified
            ? Align(
                alignment: Alignment.topRight,
                child: Icon(
                  Icons.verified,
                  color: Colors.greenAccent,
                ),
              )
            : SizedBox()
      ],
    );
  }

  Widget logoutButton() {
    return Container(
      height: 30,
      child: InkWell(
        onTap: () async {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const LogoutDialog();
            },
          );
        },
        child: Padding(
          padding: EdgeInsets.only(left: 14, right: 14),
          child: new Row(
            children: <Widget>[
              Container(
                child: Icon(
                  FontAwesomeIcons.powerOff,
                  size: 22,
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: Container(
                  child: Text(
                    'Logout',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.red,
                      fontSize: ConstanceData.SIZE_TITLE14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget sliverText() {
    return FlexibleSpaceBar(
      titlePadding: EdgeInsetsDirectional.only(start: 16, bottom: 8, top: 0),
      centerTitle: false,
      title: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 44,
            width: 44,
            child: AvatarImage(
              sizeValue: 44,
              radius: 44,
              isCircle: true,
              imageUrl:
                  "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1534&q=80",
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Text(
            'Enric',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: AllCoustomTheme.getThemeData().colorScheme.background,
            ),
          ),
        ],
      ),
    );
  }
}

class AccountInfoScreen extends StatefulWidget {
  final Function? update;

  const AccountInfoScreen({Key? key, this.update}) : super(key: key);
  @override
  _AccountInfoScreenState createState() => _AccountInfoScreenState();
}

class _AccountInfoScreenState extends State<AccountInfoScreen> {
  bool isLoginProsses = false;
  UserData data = UserData();

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() async {
    setState(() {
      isLoginProsses = true;
    });
    var responseData = ApiProvider().getProfile();
    data = responseData.data!;
    setState(() {
      isLoginProsses = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AllCoustomTheme.getThemeData().colorScheme.background,
      body: Stack(
        alignment: Alignment.bottomRight,
        children: [
          Container(
            child: ModalProgressHUD(
              inAsyncCall: isLoginProsses,
              color: Colors.transparent,
              progressIndicator: CircularProgressIndicator(
                strokeWidth: 2.0,
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.all(0),
                physics: BouncingScrollPhysics(),
                child: data.name != ''
                    ? Container(
                        padding: EdgeInsets.only(top: 16),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(
                                  right: 16, left: 16, top: 4, bottom: 4),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    width: 100,
                                    child: Text(
                                      'Name',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: ConstanceData.SIZE_TITLE16,
                                        color: AllCoustomTheme
                                            .getTextThemeColors(),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "Enric",
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: ConstanceData.SIZE_TITLE16,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Divider(),
                            Container(
                              padding: EdgeInsets.only(
                                  right: 16, left: 16, top: 4, bottom: 4),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    width: 100,
                                    child: Text(
                                      'Email',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: ConstanceData.SIZE_TITLE16,
                                        color: AllCoustomTheme
                                            .getTextThemeColors(),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "enric@gmail.com",
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: ConstanceData.SIZE_TITLE16,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Divider(),
                            Container(
                              padding: EdgeInsets.only(
                                  right: 16, left: 16, top: 4, bottom: 4),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    width: 100,
                                    child: Text(
                                      'Mobile No',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: ConstanceData.SIZE_TITLE16,
                                        color: AllCoustomTheme
                                            .getTextThemeColors(),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      "+91 1234567890",
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: ConstanceData.SIZE_TITLE16,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Divider(),
                            Container(
                              padding: EdgeInsets.only(
                                  right: 16, left: 16, top: 4, bottom: 4),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    width: 100,
                                    child: Text(
                                      'Date of Birth',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: ConstanceData.SIZE_TITLE16,
                                        color: AllCoustomTheme
                                            .getTextThemeColors(),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      DateFormat('dd MMM, yyyy').format(
                                          DateFormat('dd/MM/yyyy')
                                              .parse(data.dob!)),
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: ConstanceData.SIZE_TITLE16,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Divider(),
                            Container(
                              padding: EdgeInsets.only(
                                  right: 16, left: 16, top: 4, bottom: 4),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    width: 100,
                                    child: Text(
                                      'Gender',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: ConstanceData.SIZE_TITLE16,
                                        color: AllCoustomTheme
                                            .getTextThemeColors(),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      data.gender![0].toUpperCase() +
                                          data.gender!.substring(1),
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: ConstanceData.SIZE_TITLE16,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Divider(),
                            Container(
                              padding: EdgeInsets.only(
                                  right: 16, left: 16, top: 4, bottom: 4),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    width: 100,
                                    child: Text(
                                      'Country',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: ConstanceData.SIZE_TITLE16,
                                        color: AllCoustomTheme
                                            .getTextThemeColors(),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      'US',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: ConstanceData.SIZE_TITLE16,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Divider(),
                            Container(
                              padding: EdgeInsets.only(
                                  right: 16, left: 16, top: 4, bottom: 4),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    width: 100,
                                    child: Text(
                                      'State',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: ConstanceData.SIZE_TITLE16,
                                        color: AllCoustomTheme
                                            .getTextThemeColors(),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      data.state!,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: ConstanceData.SIZE_TITLE16,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Divider(),
                            Container(
                              padding: EdgeInsets.only(
                                  right: 16, left: 16, top: 4, bottom: 4),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    width: 100,
                                    child: Text(
                                      'City',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: ConstanceData.SIZE_TITLE16,
                                        color: AllCoustomTheme
                                            .getTextThemeColors(),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      data.city!,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: ConstanceData.SIZE_TITLE16,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Divider(),
                            logoutButton(),
                          ],
                        ),
                      )
                    : SizedBox(),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: -10, right: 30),
            child: FloatingActionButton(
              foregroundColor: AllCoustomTheme.getThemeData().colorScheme.background,
              backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
              onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UpdateProfileScreen(
                        loginUserData: data,
                      ),
                    ),
                  );
              },
              child: Icon(Icons.edit),
            ),
          ),
        ],
      ),
    );
  }

  Widget logoutButton() {
    return Container(
      height: 30,
      child: InkWell(
        onTap: () {
          LogOut().logout(context);
        },
        child: Padding(
          padding: EdgeInsets.only(left: 14, right: 14),
          child: new Row(
            children: <Widget>[
              Container(
                child: Icon(
                  FontAwesomeIcons.powerOff,
                  size: 22,
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: Container(
                  child: Text(
                    'Logout',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.red,
                      fontSize: ConstanceData.SIZE_TITLE14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PlayingHistory extends StatefulWidget {
  @override
  _PlayingHistoryState createState() => _PlayingHistoryState();
}

class _PlayingHistoryState extends State<PlayingHistory> {

  int totalWinningContests = 0;

  @override
  void initState() {
    fetchTotalWinningContests();
    super.initState();
  }

  Future<void> fetchTotalWinningContests() async {
    final String url = 'https://9gamefire.com/api/api/v1/all/winning-contests';

    final response = await http.get(
      Uri.parse(url),
      headers: {
        'Authorization': 'Bearer ${await Storage().getItem('usertoken')}',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body)['data'];
      setState(() {
        totalWinningContests = data['totalWinningContests'];
      });
      print('Total Winning Contests: $totalWinningContests');
    } else {
      print('Failed to load data. Status code: ${response.statusCode}');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 16),
      child: Consumer<GetCompleteMatchesProvider>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final complete = value.todos;
          int matches = 0;
          Set<String> uniqueMatchIds = {};
          complete.forEach((element) {
            if (uniqueMatchIds.add(element.matchId.matchId.toString())) {
              matches++;
            }
          });
          if (complete == null) {
            return const Center(
              child: Text('No data found'),
            );
          }

          return Center(
            child: Column(
              children: <Widget>[
                Container(
                  padding:
                  EdgeInsets.only(right: 16, left: 16, top: 4, bottom: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 100,
                        child: Text(
                          'Contests',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: ConstanceData.SIZE_TITLE16,
                            color: AllCoustomTheme.getTextThemeColors(),
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          complete.length.toString() ?? '1',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Divider(),
                Container(
                  padding:
                  EdgeInsets.only(right: 16, left: 16, top: 4, bottom: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 100,
                        child: Text(
                          'Matches',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: ConstanceData.SIZE_TITLE16,
                            color: AllCoustomTheme.getTextThemeColors(),
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          matches.toString() ?? '1',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Divider(),
                Container(
                  padding:
                  EdgeInsets.only(right: 16, left: 16, top: 4, bottom: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        width: 100,
                        child: Text(
                          'Wins',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: ConstanceData.SIZE_TITLE16,
                            color: AllCoustomTheme.getTextThemeColors(),
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          totalWinningContests.toString(),
                          style: TextStyle(
                            fontFamily: 'Poppins',
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class Wallet extends StatefulWidget {
  String mybalance ='';

  Wallet(this.mybalance);

  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  bool isLoginProsses = false;
  UserData data = UserData();
  bool emialApproved = false;
  bool pancardApproved = false;
  bool bankApproved = false;
  bool allApproved = false;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  void getUserData() async {
    setState(() {
      isLoginProsses = true;
    });

    var responseData = ApiProvider().getProfile();

    if (responseData != null && responseData.data != null) {
      data = responseData.data!;
    }

    var email = await ApiProvider().getEmailResponce();

    if ('Your E-mail and Mobile Number are Verified.' == email.message) {
      emialApproved = true;
    }

    var pancard = await ApiProvider().getPanCardResponce();

    if (pancard.success == '1') {
      if (pancard.pancardDetail != null) {
        if (pancard.pancardDetail!.length > 0) {
          if (pancard.pancardDetail![0].pancardNo != '') {
            if ('Your Pan Card Verification Has been Approved' ==
                pancard.message) {
              pancardApproved = true;
            }
          }
        }
      }
    }

    var bankData = await ApiProvider().bankListApprovedResponseData();
    if (bankData.success == 1) {
      if (bankData.accountDetail != null) {
        if (bankData.accountDetail!.length > 0) {
          bankApproved = true;
        }
      }
    }

    if (emialApproved && pancardApproved && bankApproved) {
      allApproved = true;
    }

    setState(() {
      isLoginProsses = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8),
      child: Center(
        child: ModalProgressHUD(
          inAsyncCall: isLoginProsses,
          color: Colors.transparent,
          progressIndicator: CircularProgressIndicator(
            strokeWidth: 2.0,
          ),
          child: Consumer<GetUserAllTransactionProvider>(
            builder: (context, value, child) {
              if (value.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final transaction = value.todos;
              if (transaction == null || transaction.isEmpty) {
                return const Center(
                  child: Text('No data found'),
                );
              }

              num calculateTotalAmount(List<GetUserAllTransactionData> transactions, String type) {
                return transactions
                    .where((transaction) => transaction.type == type)
                    .fold<num>(0, (sum, transaction) => sum + transaction.amount);
              }

              num totalCreditAmount = calculateTotalAmount(transaction, 'Credit');
              num totalDebitAmount = calculateTotalAmount(transaction, 'Debit');


              return  Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                        right: 16, left: 16, top: 4, bottom: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'My Balance',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: ConstanceData.SIZE_TITLE16,
                            color: AllCoustomTheme.getTextThemeColors(),
                          ),
                        ),
                        Text(
                          '₹' + widget.mybalance,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: ConstanceData.SIZE_TITLE16,
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(),
                  Container(
                    padding: EdgeInsets.only(
                        right: 16, left: 16, top: 4, bottom: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 110,
                          child: Text(
                            'Credit',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE16,
                              color: AllCoustomTheme.getTextThemeColors(),
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            '₹$totalCreditAmount',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE16,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(),
                  Container(
                    padding: EdgeInsets.only(
                        right: 16, left: 16, top: 8, bottom: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 110,
                          child: Text(
                            'Debit',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE16,
                              color: AllCoustomTheme.getTextThemeColors(),
                            ),
                          ),
                        ),
                        Container(
                          child: Text(
                            '₹' + totalDebitAmount.toString(),
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE16,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(),
                  Container(
                    padding: EdgeInsets.only(
                        right: 16, left: 16, top: 4, bottom: 4),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: 110,
                          child: Text(
                            'Winning',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE16,
                              color: AllCoustomTheme.getTextThemeColors(),
                            ),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WithdrawScreen(),
                                fullscreenDialog: true,
                              ),
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                                left: 8, right: 8, top: 4, bottom: 4),
                            decoration: new BoxDecoration(
                              color: AllCoustomTheme.getThemeData().colorScheme.background,
                              borderRadius: new BorderRadius.circular(8),
                              border: Border.all(
                                color: Colors.green,
                                width: 1,
                              ),
                              boxShadow: <BoxShadow>[
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    offset: Offset(0, 1),
                                    blurRadius: 5.0),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                'withdraw'.toUpperCase(),
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.green,
                                  fontSize: ConstanceData.SIZE_TITLE14,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Container(
                          child: Text(
                            '₹100',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE16,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(),
                  SizedBox(height: 20,),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TransectionHistoryScreen(),
                          fullscreenDialog: true,
                        ),
                      );
                    },
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 60,
                          color: AllCoustomTheme.getThemeData()
                              .primaryColor
                              .withOpacity(0.2),
                          padding: EdgeInsets.only(left: 16, right: 16),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  "My Transactions",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: ConstanceData.SIZE_TITLE16,
                                    fontWeight: FontWeight.bold,
                                    color: AllCoustomTheme.getThemeData()
                                        .primaryColor,
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.keyboard_arrow_right,
                                size: ConstanceData.SIZE_TITLE22,
                                color: AllCoustomTheme.getThemeData()
                                    .primaryColor,
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          height: 1,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class PersistentHeader extends SliverPersistentHeaderDelegate {
  final TabController controller;

  PersistentHeader(
    this.controller,
  );

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Column(
      children: <Widget>[
        Container(
          height: 40,
          color: AllCoustomTheme.getThemeData().colorScheme.background,
          child: new TabBar(
            unselectedLabelColor: AllCoustomTheme.getTextThemeColors(),
            indicatorColor: AllCoustomTheme.getThemeData().primaryColor,
            labelColor: AllCoustomTheme.getThemeData().primaryColor,
            labelStyle: TextStyle(
              fontFamily: 'Poppins',
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AllCoustomTheme.getThemeData().primaryColor,
            ),
            tabs: [
              new Tab(text: 'Account Info'),
              new Tab(text: 'Playing History'),
              new Tab(text: 'Wallet'),
            ],
            controller: controller,
          ),
        ),
        Divider(
          height: 1,
        )
      ],
    );
  }

  @override
  double get maxExtent => 41.0;

  @override
  double get minExtent => 41.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
