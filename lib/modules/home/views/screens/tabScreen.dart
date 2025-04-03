import 'package:flutter/material.dart';
import 'package:tempalteflutter/constance/themes.dart';
import 'package:tempalteflutter/modules/home/views/provider/getbannerprovider.dart';
import 'package:tempalteflutter/modules/home/views/provider/getlivematchesprovider.dart';
import 'package:tempalteflutter/modules/myProfile/views/provider/getuserprovider.dart';
import 'package:tempalteflutter/modules/standingScreen/views/screens/standingScreen.dart';
import 'homeScreen.dart';
import '../../../setting/views/screens/moreScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../provider/getupcomingmatchprovider.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  static var _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(menuCallBack: () {
      _scaffoldKey.currentState!.openEndDrawer();
    }),
    StandingScree(menuCallBack: () {
      _scaffoldKey.currentState!.openEndDrawer();
    }),
    // Winner(),
    MoreScreen(inviteFriendClick: () {}),
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<GetUserDataProvider>(context, listen: false).getuser();
      Provider.of<GetBannerProvider>(context, listen: false).getbanner();
      Provider.of<GetUpcomingMatchProvider>(context, listen: false).getmatch();
      Provider.of<GetLiveMatchProvider>(context, listen: false).getmatch();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 3,
        selectedFontSize: 3,
        unselectedFontSize: 3,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
            print(_currentIndex);
          });
        },
        selectedItemColor: AllCoustomTheme.getThemeData().primaryColor,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/Frame 6.svg",
              color: _currentIndex == 0
                  ? AllCoustomTheme.getThemeData().primaryColor
                  : Colors.grey,
              // width: 45,
              // height: 45,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/Frame 7.svg",
              color: _currentIndex == 1
                  ? AllCoustomTheme.getThemeData().primaryColor
                  : Colors.grey,
              width: 45,
              height: 45,
            ),
            label: '',
          ),
          // BottomNavigationBarItem(
          //   icon: Padding(
          //     padding: const EdgeInsets.only(top: 3),
          //     child: SvgPicture.asset(
          //       "assets/Frame 8.svg",
          //       color: _currentIndex == 2
          //           ? AllCoustomTheme.getThemeData().primaryColor
          //           : Colors.grey,
          //       width: 42,
          //       height: 42,
          //     ),
          //   ),
          //   label: '',
          // ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/Frame 9.svg",
              color: _currentIndex == 2
                  ? AllCoustomTheme.getThemeData().primaryColor
                  : Colors.grey,
              width: 45,
              height: 45,
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
