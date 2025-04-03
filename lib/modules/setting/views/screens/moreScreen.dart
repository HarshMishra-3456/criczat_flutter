// ignore_for_file: deprecated_member_use

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:tempalteflutter/api/apiProvider.dart';
import 'package:tempalteflutter/constance/constance.dart';
import 'package:tempalteflutter/constance/themes.dart';
import 'package:tempalteflutter/modules/home/views/screens/homeScreen.dart';
import 'package:tempalteflutter/modules/myProfile/views/provider/getuserprovider.dart';
import 'package:tempalteflutter/modules/setting/views/screens/FantasyPointSystemScreen.dart';
import 'package:tempalteflutter/modules/setting/views/screens/aboutusscreen.dart';
import 'package:tempalteflutter/modules/setting/views/screens/contactus.dart';
import 'package:tempalteflutter/modules/setting/views/screens/fantasyhelp.dart';
import 'package:tempalteflutter/modules/setting/views/screens/faqscreen.dart';
import 'package:tempalteflutter/modules/setting/views/screens/legalityscreen.dart';
import 'package:tempalteflutter/modules/setting/views/screens/pointsystemscreen.dart';
import 'package:tempalteflutter/modules/setting/views/screens/responsiblegame.dart';
import 'package:tempalteflutter/modules/setting/views/screens/termsandcondtion.dart';
import 'package:tempalteflutter/utils/avatarImage.dart';

class MoreScreen extends StatefulWidget {
  final VoidCallback? inviteFriendClick;

  const MoreScreen({Key? key, this.inviteFriendClick}) : super(key: key);
  @override
  _MoreScreenState createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  double _appBarHeight = 100.0;
  AppBarBehavior _appBarBehavior = AppBarBehavior.pinned;
  bool isVerifiled = false;
  bool isProsses = false;

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    var emialApproved = false;
    var pancardApproved = false;
    var bankApproved = false;

    setState(() {
      isProsses = true;
    });
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
      if (bankData.accountDetail != null &&
          bankData.accountDetail!.length > 0) {
        bankApproved = true;
      }
    }

    if (emialApproved && pancardApproved && bankApproved) {
      isVerifiled = true;
    }
    setState(() {
      isProsses = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          color: AllCoustomTheme.getThemeData().primaryColor,
        ),
        SafeArea(
          child: Scaffold(
            backgroundColor: AllCoustomTheme.getThemeData().colorScheme.background,
            body: Stack(
              children: <Widget>[
                CustomScrollView(
                  physics: BouncingScrollPhysics(),
                  slivers: <Widget>[
                    SliverAppBar(
                      leading: Container(),
                      expandedHeight: _appBarHeight,
                      pinned: _appBarBehavior == AppBarBehavior.pinned,
                      floating: _appBarBehavior == AppBarBehavior.floating ||
                          _appBarBehavior == AppBarBehavior.snapping,
                      snap: _appBarBehavior == AppBarBehavior.snapping,
                      backgroundColor:
                          AllCoustomTheme.getThemeData().primaryColor,
                      primary: true,
                      centerTitle: false,
                      flexibleSpace: sliverText(),
                      elevation: 1,
                    ),
                    SliverList(
                      delegate: new SliverChildBuilderDelegate(
                        (context, index) => listItems(index),
                        childCount: 10,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget sliverText() {
    return FlexibleSpaceBar(
      centerTitle: false,
      titlePadding: EdgeInsetsDirectional.only(start: 16, bottom: 8, top: 0),
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
          return Row(
            // mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                width: 10,
              ),
              Text(
                'More',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget listItems(int index) {
    if (index == 0) {
      return InkWell(
        onTap: () async {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PointSystemScreen(),
              ));
        },
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 50,
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.add_circle_outlined,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        "Fantasy Points System",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: AllCoustomTheme.getBlackAndWhiteThemeColors()
                              .withOpacity(0.8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
                height: 1,
              ),
            ],
          ),
        ),
      );
    } else if (index == 1) {
      return InkWell(
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FantasySelfHelp(),
              fullscreenDialog: true,
            ),
          );
        },
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 50,
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.question_mark,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        "Fantasy Self Help",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: AllCoustomTheme.getBlackAndWhiteThemeColors()
                              .withOpacity(0.8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
                height: 1,
              ),
            ],
          ),
        ),
      );
    } else if (index == 8) {
      return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LegalityScreen(),
            ),
          );
        },
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 50,
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.gavel,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        "Legality",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: AllCoustomTheme.getBlackAndWhiteThemeColors()
                              .withOpacity(0.8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
                height: 1,
              ),
            ],
          ),
        ),
      );
    } else if (index == 2) {
      return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AboutUsPage(),
              fullscreenDialog: true,
            ),
          );
        },
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 50,
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.details,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        "About Us",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: AllCoustomTheme.getBlackAndWhiteThemeColors()
                              .withOpacity(0.8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
                height: 1,
              ),
            ],
          ),
        ),
      );
    } else if (index == 4) {
      return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FantasyPointSystemScreen(),
              fullscreenDialog: true,
            ),
          );
        },
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 50,
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.privacy_tip,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        "Privacy & Policy",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: AllCoustomTheme.getBlackAndWhiteThemeColors()
                              .withOpacity(0.8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
                height: 1,
              ),
            ],
          ),
        ),
      );
    } else if (index == 6) {
      return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ContactUs(),
              // fullscreenDialog: true,
            ),
          );
        },
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 50,
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.call,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        "Contact Us",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: AllCoustomTheme.getBlackAndWhiteThemeColors()
                              .withOpacity(0.8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
                height: 1,
              ),
            ],
          ),
        ),
      );
    } else if (index == 7) {
      return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FaqScreen(),
            ),
          );
        },
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 50,
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.privacy_tip_outlined,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        "FAQ's",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: AllCoustomTheme.getBlackAndWhiteThemeColors()
                              .withOpacity(0.8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
                height: 1,
              ),
            ],
          ),
        ),
      );
    } else if (index == 9) {
      return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResponsibleGame(),
            ),
          );
        },
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 50,
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.heart_broken_sharp,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        "Responsible Gaming",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: AllCoustomTheme.getBlackAndWhiteThemeColors()
                              .withOpacity(0.8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
                height: 1,
              ),
            ],
          ),
        ),
      );
    } else if (index == 3) {
      return InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TermsAndCondtions(),
              // fullscreenDialog: true,
            ),
          );
        },
        child: Container(
          child: Column(
            children: <Widget>[
              Container(
                height: 50,
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Row(
                  children: <Widget>[
                    Icon(
                      Icons.tab_rounded,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Text(
                        "Terms and Conditions",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: AllCoustomTheme.getBlackAndWhiteThemeColors()
                              .withOpacity(0.8),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
                height: 1,
              ),
            ],
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
