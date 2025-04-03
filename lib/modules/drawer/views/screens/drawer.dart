// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tempalteflutter/constance/constance.dart';
import 'package:tempalteflutter/constance/themes.dart';
import 'package:tempalteflutter/core/localstorage/localstorage.dart';
import 'package:tempalteflutter/main.dart';
import 'package:tempalteflutter/modules/color/setColor.dart';
import 'package:tempalteflutter/modules/drawer/views/screens/myofferprograms.dart';
import 'package:tempalteflutter/modules/drawer/views/screens/referandprograms.dart';
import 'package:tempalteflutter/modules/home/views/screens/tabScreen.dart';
import 'package:tempalteflutter/modules/myProfile/views/provider/getuserprovider.dart';
import 'package:tempalteflutter/modules/myProfile/views/screens/myProfileScreen.dart';
import 'package:tempalteflutter/modules/myProfile/views/screens/mywallet.dart';
import 'package:tempalteflutter/modules/myProfile/views/screens/notificationScreen.dart';
import 'package:tempalteflutter/modules/phoneauth/PhoneValidationScreen.dart';
import 'package:tempalteflutter/utils/avatarImage.dart';
import 'package:tempalteflutter/constance/global.dart' as globals;

class AppDrawer extends StatefulWidget {
  final VoidCallback? mySettingClick;
  final VoidCallback? referralClick;

  const AppDrawer({Key? key, this.mySettingClick, this.referralClick}) : super(key: key);
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  var appVerison = '1.1.1';
  bool isLoginProsses = false;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 0,
      child: Column(
        children: <Widget>[
          Container(
            color: AllCoustomTheme.getThemeData().primaryColor,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).padding.top,
                ),
                userDetail(),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: AllCoustomTheme.getThemeData().colorScheme.background,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    myHome(),
                    Divider(
                      height: 1,
                    ),
                    myNotification(),
                    Divider(
                      height: 1,
                    ),
                    myBalance(),
                    Divider(
                      height: 1,
                    ),
                    myReferandearn(),
                    Divider(
                      height: 1,
                    ),
                    myOfferandProgaram(),
                    Divider(
                      height: 1,
                    ),
                    poinSystem(),
                    Divider(
                      height: 1,
                    ),
                    logoutButton(),
                    Expanded(child: SizedBox()),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
                        'Follow Us :',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE18,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(width: 10,),
                        Image.asset('assets/skill-icons_instagram.png',fit: BoxFit.cover,),
                        SizedBox(width: 20,),
                        Image.asset('assets/logos_telegram.png',fit: BoxFit.cover,),
                        SizedBox(width: 20,),
                        Image.asset('assets/logos_youtube-icon.png',fit: BoxFit.cover,),
                        SizedBox(width: 20,),
                        Image.asset('assets/logos_facebook.png',fit: BoxFit.cover,),
                        SizedBox(width: 20,),
                        Image.asset('assets/skill-icons_twitter.png',fit: BoxFit.cover,),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget userDetail() {
    return Container(
      height: 100,
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
          return Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  padding: const EdgeInsets.only(left: 32),
                  child: Icon(
                    Icons.arrow_back,
                    size: 22,
                    color: Colors.white,
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  MyProfileScreen(),));
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    SizedBox(
                      width: 30,
                    ),
                    todo.image == null
                        ? Container(
                      height: 50,
                      width: 50,
                      child: AvatarImage(
                        sizeValue: 44,
                        radius: 44,
                        isCircle: true,
                        imageUrl:
                        "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1534&q=80",
                      ),
                    )
                        : CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(todo.image),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                new Text(
                                  todo.fullName ?? '',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            // Row(
                            //   children: <Widget>[
                            //     Icon(
                            //       Icons.location_on,
                            //       size: 10,
                            //       color: AllCoustomTheme.getThemeData().backgroundColor.withOpacity(0.5),
                            //     ),
                            //     new Text(
                            //       '${todo.city}' + '${todo.state}',
                            //       style: TextStyle(
                            //         fontFamily: 'Poppins',
                            //         fontSize: ConstanceData.SIZE_TITLE14,
                            //         color: AllCoustomTheme.getThemeData().backgroundColor.withOpacity(0.5),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Widget myNotification() {
    return Container(
      height: 54,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MyProfileScreen(),
              fullscreenDialog: true,
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.only(left: 14, right: 14),
          child: new Row(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.userLarge,
                    size: 22,
                    color: Colors.black,
                  ),
                ],
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  'Profile',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget myHome() {
    return Container(
      height: 54,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Padding(
          padding: EdgeInsets.only(left: 14, right: 14),
          child: new Row(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.home,
                    size: 22,
                    color: Colors.black,
                  ),
                ],
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  'Home',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget myReferandearn() {
    return Container(
      height: 54,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ReferAndPrograms(),
              fullscreenDialog: true,
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.only(left: 14, right: 14),
          child: new Row(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Icon(
                    Icons.people,
                    size: 22,
                    color: Colors.black,
                  ),
                ],
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  'Refer & Earn',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget myOfferandProgaram() {
    return Container(
      height: 54,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OfferAndPrograms(),
              fullscreenDialog: true,
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.only(left: 14, right: 14),
          child: new Row(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Icon(
                    Icons.percent,
                    size: 22,
                    color: Colors.black,
                  ),
                ],
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  'Offer & Program',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget myJoincontest() {
    return Container(
      height: 54,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TabScreen(),
              fullscreenDialog: true,
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.only(left: 14, right: 14),
          child: new Row(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Icon(
                    FontAwesomeIcons.trophy,
                    size: 22,
                    color: Colors.black,
                  ),
                ],
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  'join/Create Contest',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget myBalance() {
    return Container(
      height: 54,
      child: Padding(
        padding: EdgeInsets.only(left: 14, right: 14),
        child: new Row(
          children: <Widget>[
            Container(
              child: Icon(
                FontAwesomeIcons.wallet,
                color: Colors.black,
                size: 22,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Container(
                child: Text(
                  'Wallet',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyWallet(),
                        fullscreenDialog: true,
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
                    decoration: new BoxDecoration(
                      color: AllCoustomTheme.getThemeData().primaryColor,
                      borderRadius: new BorderRadius.circular(4.0),
                      // border: Border.all(
                      //   color: Colors.green,
                      //   width: 1,
                      // ),
                      // boxShadow: <BoxShadow>[
                      //   BoxShadow(color: Colors.black.withOpacity(0.2), offset: Offset(0, 1), blurRadius: 5.0),
                      // ],
                    ),
                    child: Center(
                      child: Text(
                        'ADD CASH'.toUpperCase(),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: ConstanceData.SIZE_TITLE12,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget myRewardsOffers() {
    return Container(
      height: 54,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.only(left: 14, right: 14),
          child: new Row(
            children: <Widget>[
              Container(
                child: Icon(
                  FontAwesomeIcons.gift,
                  color: AllCoustomTheme.getThemeData().primaryColor,
                  size: 22,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  child: Text(
                    'My Rewards & Offers',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: AllCoustomTheme.getThemeData().primaryColor,
                      fontWeight: FontWeight.w500,
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

  int light = 1;
  int dark = 2;
  changeColor(BuildContext context, int color) {
    Navigator.pop(context);
    if (color == light) {
      MyApp.setCustomeTheme(context, 6, color: globals.primaryColorString);
    } else {
      MyApp.setCustomeTheme(context, 7, color: globals.primaryColorString);
    }
  }

  openShowPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text(
              'Select theme mode',
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 18,
                  ),
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      changeColor(context, light);
                    },
                    child: CircleAvatar(
                      radius: 34,
                      backgroundColor: Colors.black,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 32,
                        child: Text(
                          'Light',
                          style: TextStyle(fontFamily: 'Poppins', color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    highlightColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    onTap: () {
                      changeColor(context, dark);
                    },
                    child: CircleAvatar(
                      radius: 34,
                      backgroundColor: Theme.of(context).textTheme.titleLarge!.color,
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 32,
                        child: Text(
                          'Dark',
                          style: TextStyle(fontFamily: 'Poppins', color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget setThemeMode() {
    return Container(
      height: 54,
      child: InkWell(
        onTap: () {
          openShowPopup(context);
        },
        child: Padding(
          padding: EdgeInsets.only(left: 12, right: 14),
          child: new Row(
            children: <Widget>[
              Container(
                child: Icon(
                  Icons.colorize,
                  color: AllCoustomTheme.getThemeData().primaryColor,
                  size: 28,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  child: Text(
                    'Theme',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: AllCoustomTheme.getThemeData().primaryColor,
                      fontWeight: FontWeight.w500,
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

  Widget myReferrals() {
    return Container(
      height: 54,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          widget.referralClick!();
        },
        child: Padding(
          padding: EdgeInsets.only(left: 12, right: 14),
          child: new Row(
            children: <Widget>[
              Container(
                child: Icon(
                  Icons.group_add,
                  color: AllCoustomTheme.getThemeData().primaryColor,
                  size: 28,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  child: Text(
                    'My Referrals',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: AllCoustomTheme.getThemeData().primaryColor,
                      fontWeight: FontWeight.w500,
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

  Widget myInfoSetting() {
    return Container(
      height: 54,
      child: InkWell(
        onTap: () async {
          widget.mySettingClick!();
          await Future.delayed(const Duration(milliseconds: 100));
          Navigator.pop(context);
        },
        child: Padding(
          padding: EdgeInsets.only(left: 14, right: 14),
          child: new Row(
            children: <Widget>[
              Container(
                child: Icon(
                  FontAwesomeIcons.cog,
                  color: AllCoustomTheme.getThemeData().primaryColor,
                  size: 22,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  child: Text(
                    'My Info & Settings',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: AllCoustomTheme.getThemeData().primaryColor,
                      fontWeight: FontWeight.w500,
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

  Widget poinSystem() {
    return Container(
      height: 54,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SetColorScreen(),
              fullscreenDialog: true,
            ),
          );
        },
        child: Padding(
          padding: EdgeInsets.only(left: 14, right: 14),
          child: new Row(
            children: <Widget>[
              Container(
                child: Icon(
                  Icons.color_lens,
                  color: Colors.black,
                  size: 26,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  child: Text(
                    'Theme',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
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

  Widget myProfile() {
    return Container(
      height: 54,
      child: InkWell(
        onTap: () async {
          widget.mySettingClick!();
          await Future.delayed(const Duration(milliseconds: 100));
          Navigator.pop(context);
        },
        child: Padding(
          padding: EdgeInsets.only(left: 14, right: 14),
          child: new Row(
            children: <Widget>[
              Container(
                child: Icon(
                  FontAwesomeIcons.solidUserCircle,
                  color: AllCoustomTheme.getThemeData().primaryColor,
                  size: 22,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  child: Text(
                    'My Profile',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: AllCoustomTheme.getThemeData().primaryColor,
                      fontWeight: FontWeight.w500,
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

  Widget logoutButton() {
    return Container(
      height: 54,
      child: InkWell(
        onTap: () async{
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
                  color: AllCoustomTheme.getThemeData().primaryColor,
                  size: 22,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  child: Text(
                    'Logout',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: AllCoustomTheme.getThemeData().primaryColor,
                      fontWeight: FontWeight.w500,
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

class LogoutDialog extends StatelessWidget {
  const LogoutDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: const Text('Are you sure you want to logout?'),
      // content: const Text('Are you sure you want to logout?'),
      actions: [
        TextButton(
          onPressed: () async{
            await Storage().deleteItem('userid');
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (context) => PhoneValidationScreen()
                ),
                    (route) => false
            );
          },
          child: const Text('Yes'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(false);
          },
          child: const Text('No'),
        ),
      ],
    );
  }
}
