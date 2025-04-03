// ignore_for_file: unnecessary_null_comparison, deprecated_member_use

import 'dart:async';
import 'package:tempalteflutter/modules/myProfile/views/provider/getuserprovider.dart';
import 'package:flutter/material.dart';
import 'package:scroll_page_view/pager/page_controller.dart';
import 'package:scroll_page_view/pager/scroll_page_view.dart';
import 'package:tempalteflutter/constance/constance.dart';
import 'package:tempalteflutter/constance/global.dart';
import 'package:tempalteflutter/constance/themes.dart';
import 'package:tempalteflutter/core/Utils/authutilities.dart';
import 'package:tempalteflutter/core/Utils/constants.dart';
import 'package:tempalteflutter/core/Utils/loadinghelper.dart';
import 'package:tempalteflutter/core/localstorage/localstorage.dart';
import 'package:tempalteflutter/models/scheduleResponseData.dart';
import 'package:tempalteflutter/modules/contests/views/screens/contestsScreen.dart';
import 'package:tempalteflutter/models/userData.dart';
import 'package:tempalteflutter/modules/drawer/views/screens/drawer.dart';
import 'package:tempalteflutter/modules/home/domain/getlivematchesmodel.dart';
import 'package:tempalteflutter/modules/home/domain/getplaying11.dart';
import 'package:tempalteflutter/modules/home/domain/getupcomingmatchmodel.dart';
import 'package:tempalteflutter/modules/home/views/provider/getbannerprovider.dart';
import 'package:tempalteflutter/modules/home/views/provider/getlivematchesprovider.dart';
import 'package:tempalteflutter/modules/home/views/provider/playing11provider.dart';
import 'package:tempalteflutter/modules/myProfile/views/screens/mywallet.dart';
import 'package:tempalteflutter/modules/myProfile/views/screens/notificationScreen.dart';
import 'package:tempalteflutter/modules/standingScreen/views/provider/completematchprovider.dart';
import 'package:tempalteflutter/modules/standingScreen/views/provider/livematchesprovider.dart';
import 'package:tempalteflutter/modules/standingScreen/views/provider/upcomingmatchesprovider.dart';
import 'package:tempalteflutter/utils/avatarImage.dart';
import 'package:tempalteflutter/validator/validator.dart';
import 'package:provider/provider.dart';

import '../provider/getupcomingmatchprovider.dart';

class HomeScreen extends StatefulWidget {
  final void Function()? menuCallBack;

  const HomeScreen({Key? key, this.menuCallBack}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController? _controller;

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  var sheduallist = <ShedualData>[];
  var _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool isLoginProsses = false;
  late UserData userData;
  bool _isLoading = true;

  Timer? _timer;

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 30), (timer) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Provider.of<GetUpcomingMatchProvider>(context, listen: false)
            .getmatch();
        Provider.of<GetLiveMatchProvider>(context, listen: false).getmatch();
      });
    });
    Timer(Duration(seconds: 3), () {
      setState(() {
        Authutilities.isloaded = false;
      });
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<GetUpcomingMatchesProvider>(context, listen: false)
          .getupcoming();
      Provider.of<GetLiveMatchesProvider>(context, listen: false).getlive();
      Provider.of<GetCompleteMatchesProvider>(context, listen: false)
          .getcomplete();
    });
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    _timer?.cancel();
    super.dispose();
  }

  Widget _imageView(String image) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ClipRRect(
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(8),
        child: Image.network(image, fit: BoxFit.cover),
      ),
    );
  }

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          color: AllCoustomTheme.getThemeData().primaryColor,
        ),
        SafeArea(
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
              title: Image.asset(
                "assets/appicon.png",
                fit: BoxFit.cover,
                height: 60,
              ),
              actions: [
                InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NotificationScreen(),
                          fullscreenDialog: true,
                        ),
                      );
                    },
                    child: Icon(
                      Icons.notifications,
                      color: Colors.white,
                    )),
                SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: () {
                    // Provider.of<GetUserDataProvider>(context, listen: false).getuser();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyWallet(),
                        fullscreenDialog: true,
                      ),
                    );
                  },
                  child: Icon(
                    Icons.account_balance_wallet,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
            drawer: AppDrawer(
              mySettingClick: () {},
              referralClick: () {},
            ),
            key: _scaffoldKey,
            backgroundColor: AllCoustomTheme.getThemeData().colorScheme.background,
            body: RefreshIndicator(
                displacement: 100,
                key: _refreshIndicatorKey,
                onRefresh: () async {
                  Provider.of<GetUpcomingMatchProvider>(context, listen: false)
                      .getmatch();
                  Provider.of<GetLiveMatchProvider>(context, listen: false)
                      .getmatch();
                  // await getTeamData(true);
                },
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Authutilities.isloaded
                      ? buildShimmerList(count: 6)
                      : listItems(),
                )),
          ),
        ),
      ],
    );
  }

  Widget drawerButton() {
    return InkWell(
      onTap: openDrawer,
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundColor:
                AllCoustomTheme.getThemeData().scaffoldBackgroundColor,
            radius: 16,
            child: AvatarImage(
              imageUrl:
                  'https://www.menshairstylesnow.com/wp-content/uploads/2018/03/Hairstyles-for-Square-Faces-Slicked-Back-Undercut.jpg',
              isCircle: true,
              radius: 28,
              sizeValue: 28,
            ),
          ),
          SizedBox(
            width: 4,
          ),
          Icon(
            Icons.sort,
            size: 30,
          )
        ],
      ),
    );
  }

  Widget notificationButton() {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NotificationScreen(),
            fullscreenDialog: true,
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(12),
        child: Icon(
          Icons.notifications,
          color: AllCoustomTheme.getReBlackAndWhiteThemeColors(),
        ),
      ),
    );
  }

  Widget sliverText() {
    return FlexibleSpaceBar(
      centerTitle: false,
      titlePadding: EdgeInsetsDirectional.only(start: 16, bottom: 8, top: 0),
      title: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Upcoming Matches',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
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

  Widget listItems() {
    return Column(
      children: <Widget>[
        Consumer<GetBannerProvider>(
          builder: (context, value, child) {
            if (value.isLoading) {
              return Center(child: CircularProgressIndicator());
            }
            final matches = value.todos;
            if (matches == null) {
              return const Center(
                child: Text(
                  'No Banner found',
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 20),
                ),
              );
            }

            List<String> images = matches.map((match) => match.image).toList();

            return Padding(
              padding: const EdgeInsets.only(
                  left: 20, right: 20, top: 30, bottom: 20),
              child: SizedBox(
                height: 120,
                child: ScrollPageView(
                  controller: ScrollPageController(),
                  delay: const Duration(seconds: 4),
                  indicatorAlign: Alignment.bottomRight,
                  indicatorPadding: const EdgeInsets.only(bottom: 8, right: 16),
                  // indicatorWidgetBuilder: _indicatorBuilder,
                  children: images.map((image) => _imageView(image)).toList(),
                ),
              ),
            );
          },
        ),
        Container(
          padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Upcoming Matches',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
        Consumer<GetLiveMatchProvider>(
          builder: (context, value, child) {
            if (value.isLoading) {
              return SizedBox();
            }
            final matches = value.todos;
            if (matches == null) {
              return SizedBox();
            }

            return ListView.builder(
              itemCount: matches.length,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final todo = matches[index];
                String status = checkTimePassed(todo.dateStartIst.toString());
                DateTime now = DateTime.now();

                Duration difference = todo.dateStartIst.difference(now);

                bool islineupout = false;

                if (todo.fantasySquads.teamb.isEmpty) {
                  islineupout = true;
                }
                // 0,1,2,4,10,11
                return status == 'true'
                    ? MatchesListLive(
                        fantasySquads: todo.fantasySquads,
                        cid: todo.competition.cid.toString(),
                        matchid: todo.matchId.toString(),
                        titel: todo.competition.title,
                        country1Name: todo.teama.shortName,
                        country2Name: todo.teamb.shortName,
                        country1Flag: todo.teama.logoUrl,
                        country2Flag: todo.teamb.logoUrl,
                        price: todo.highestPrizePool.toString(),
                        time: todo.dateStartIst.toString(),
                        lineupout: islineupout,
                      )
                    : ([0, 1, 2, 4, 10, 11].contains(todo.game_state)
                        ? MatchesListLive(
                            fantasySquads: todo.fantasySquads,
                            cid: todo.competition.cid.toString(),
                            matchid: todo.matchId.toString(),
                            titel: todo.competition.title,
                            country1Name: todo.teama.shortName,
                            country2Name: todo.teamb.shortName,
                            country1Flag: todo.teama.logoUrl,
                            country2Flag: todo.teamb.logoUrl,
                            price: todo.highestPrizePool.toString(),
                            time: todo.dateStartIst.toString(),
                            lineupout: islineupout,
                          )
                        : SizedBox());
              },
            );
          },
        ),
        Consumer<GetUpcomingMatchProvider>(
          builder: (context, value, child) {
            // if (value.isLoading) {
            //   return buildShimmerList(count: 6);
            // }
            final matches = value.todos;
            if (matches == null) {
              return const Center(
                child: Text(
                  'No Match found',
                  style: TextStyle(fontFamily: 'Poppins', fontSize: 20),
                ),
              );
            }

            return ListView.builder(
              itemCount: matches.length,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final todo = matches[index];

                DateTime now = DateTime.now();

                Duration difference = todo.dateStartIst.difference(now);

                bool islineupout = false;

                if (todo.fantasySquads.teamb.isEmpty) {
                  islineupout = true;
                }

                return MatchesList(
                  fantasySquads: todo.fantasySquads,
                  cid: todo.competition.cid.toString(),
                  matchid: todo.matchId.toString(),
                  titel: todo.competition.title,
                  country1Name: todo.teama.shortName,
                  country2Name: todo.teamb.shortName,
                  country1Flag: todo.teama.logoUrl,
                  country2Flag: todo.teamb.logoUrl,
                  price: todo.highestPrizePool.toString(),
                  time: getTimeDifference(time: todo.dateStartIst.toString()),
                  lineupout: islineupout,
                );
              },
            );
          },
        ),
        SizedBox(
          height: 50,
        )
      ],
    );
  }

  void openDrawer() {
    widget.menuCallBack!();
  }
}

class MatchesList extends StatefulWidget {
  final String? titel;
  final String? country1Name;
  final String? country1Flag;
  final String? country2Name;
  final String? country2Flag;
  final String? time;
  final String? price;
  final String? matchid;
  final String? cid;
  FantasySquads? fantasySquads;
  bool lineupout;

  MatchesList(
      {Key? key,
      this.titel,
      this.country1Name,
      this.country2Name,
      this.matchid,
      this.cid,
      this.time,
      this.price,
      this.country1Flag,
      this.country2Flag,
      required this.lineupout,
      this.fantasySquads})
      : super(key: key);

  @override
  _MatchesListState createState() => _MatchesListState();
}

class _MatchesListState extends State<MatchesList> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        print(widget.fantasySquads?.teamb.length);
        var playerProvider =
            Provider.of<Player11Provider>(context, listen: false);

        playerProvider.clearPlayers();

        for (var player in widget.fantasySquads!.teama) {
          playerProvider.addPlaying11Player(Player11(
            name: player.name,
            playerId: player.playerId,
          ));
        }

        for (var player in widget.fantasySquads!.teamb) {
          playerProvider.addPlaying11Player(Player11(
            name: player.name,
            playerId: player.playerId,
          ));
        }

        for (var player in playerProvider.playing11Players) {
          print(player);
          print(player.name.length);
        }
        await Storage().setItem('matchid', widget.matchid);
        await Storage().setItem('cid', widget.cid);
        print(await Storage().getItem('matchid'));
        print(await Storage().getItem('cid'));
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ContestsScreen(
              country1Flag: widget.country1Flag,
              country2Flag: widget.country2Flag,
              country1Name: widget.country1Name,
              country2Name: widget.country2Name,
              price: widget.price,
              time: widget.time,
              titel: widget.titel,
            ),
          ),
        );
      },
      onLongPress: () {
        showModalBottomSheet<void>(
          context: context,
          builder: (
            BuildContext context,
          ) =>
              UnderGroundDrawer(
            country1Flag: widget.country1Flag!,
            country2Flag: widget.country2Flag!,
            country1Name: widget.country1Name!,
            country2Name: widget.country2Name!,
            price: widget.price!,
            time: widget.time!,
            titel: widget.titel!,
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black26),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: -2,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          widget.titel!,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: ConstanceData.SIZE_TITLE12,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).disabledColor,
                          ),
                        ),
                      ),
                      widget.lineupout
                          ? SizedBox()
                          : Image.asset(
                              ConstanceData.lineups,
                              height: 17,
                            ),
                    ],
                  ),
                  Divider(
                    thickness: 1.3,
                  ),
                  Row(
                    children: [
                      Text(
                        widget.country1Name!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Expanded(child: SizedBox()),
                      Text(
                        widget.country2Name!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        child: Image.network(widget.country1Flag!),
                      ),
                      Container(
                        child: Text(
                          widget.time!,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: ConstanceData.SIZE_TITLE12,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        child: Image.network(widget.country2Flag!),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: AllCoustomTheme.isLight
                    ? Color(0xFFE6ECF1)
                    : Theme.of(context).disabledColor.withOpacity(0.1),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: primaryColorString,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 3, left: 3),
                        child: Text(
                          "Mega",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: ConstanceData.SIZE_TITLE12,
                            color: Color(0xFFFEEFC3),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      '₹ ${formatNumber(int.parse(widget.price!))}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: ConstanceData.SIZE_TITLE14,
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    Image.asset(
                      ConstanceData.tv,
                      height: 18,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MatchesListLive extends StatefulWidget {
  final String? titel;
  final String? country1Name;
  final String? country1Flag;
  final String? country2Name;
  final String? country2Flag;
  final String? time;
  final String? price;
  final String? matchid;
  final String? cid;
  FantasySquadsLive? fantasySquads;
  bool lineupout;

  MatchesListLive(
      {Key? key,
      this.titel,
      this.country1Name,
      this.country2Name,
      this.matchid,
      this.cid,
      this.time,
      this.price,
      this.country1Flag,
      this.country2Flag,
      required this.lineupout,
      this.fantasySquads})
      : super(key: key);

  @override
  _MatchesListLiveState createState() => _MatchesListLiveState();
}

class _MatchesListLiveState extends State<MatchesListLive> {
  @override
  Widget build(BuildContext context) {
    String status = checkTimePassed(widget.time!);
    return InkWell(
      onTap: () async {
        print(widget.fantasySquads?.teamb.length);

        var playerProvider =
            Provider.of<Player11Provider>(context, listen: false);

        playerProvider.clearPlayers();

        for (var player in widget.fantasySquads!.teama) {
          playerProvider.addPlaying11Player(Player11(
            name: player.name,
            playerId: player.playerId,
          ));
        }

        for (var player in widget.fantasySquads!.teamb) {
          playerProvider.addPlaying11Player(Player11(
            name: player.name,
            playerId: player.playerId,
          ));
        }

        for (var player in playerProvider.playing11Players) {
          print(player);
          print(player.name.length);
        }
        await Storage().setItem('matchid', widget.matchid);
        await Storage().setItem('cid', widget.cid);
        print(await Storage().getItem('matchid'));
        print(await Storage().getItem('cid'));
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ContestsScreen(
              country1Flag: widget.country1Flag,
              country2Flag: widget.country2Flag,
              country1Name: widget.country1Name,
              country2Name: widget.country2Name,
              price: widget.price,
              time: getTimeDifference(time: widget.time!),
              titel: widget.titel,
            ),
          ),
        );
      },
      onLongPress: () {
        showModalBottomSheet<void>(
          context: context,
          builder: (
            BuildContext context,
          ) =>
              UnderGroundDrawer(
            country1Flag: widget.country1Flag!,
            country2Flag: widget.country2Flag!,
            country1Name: widget.country1Name!,
            country2Name: widget.country2Name!,
            price: widget.price!,
            time: '',
            titel: widget.titel!,
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.black26),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: -2,
              blurRadius: 5,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          widget.titel!,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: ConstanceData.SIZE_TITLE12,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).disabledColor,
                          ),
                        ),
                      ),
                      widget.lineupout
                          ? SizedBox()
                          : Image.asset(
                              ConstanceData.lineups,
                              height: 17,
                            ),
                    ],
                  ),
                  Divider(
                    thickness: 1.3,
                  ),
                  Row(
                    children: [
                      Text(
                        widget.country1Name!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Expanded(child: SizedBox()),
                      Text(
                        widget.country2Name!,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        child: Image.network(widget.country1Flag!),
                      ),
                      Container(
                        child: Text(
                          status == 'true'
                              ? getTimeDifference(time: widget.time.toString())
                              : '',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: ConstanceData.SIZE_TITLE12,
                            color: Colors.red,
                          ),
                        ),
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        child: Image.network(widget.country2Flag!),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: AllCoustomTheme.isLight
                    ? Color(0xFFE6ECF1)
                    : Theme.of(context).disabledColor.withOpacity(0.1),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: primaryColorString,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 3, left: 3),
                        child: Text(
                          "Mega",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: ConstanceData.SIZE_TITLE12,
                            color: Color(0xFFFEEFC3),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Text(
                      '₹ ${formatNumber(int.parse(widget.price!))}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: ConstanceData.SIZE_TITLE14,
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    Image.asset(
                      ConstanceData.tv,
                      height: 18,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class UnderGroundDrawer extends StatefulWidget {
  final String? titel;
  final String? country1Name;
  final String? country1Flag;
  final String? country2Name;
  final String? country2Flag;
  final String? time;
  final String? price;

  const UnderGroundDrawer({
    Key? key,
    this.titel,
    this.country1Name,
    this.country1Flag,
    this.country2Name,
    this.country2Flag,
    this.time,
    this.price,
  }) : super(key: key);

  @override
  _UnderGroundDrawerState createState() => _UnderGroundDrawerState();
}

class _UnderGroundDrawerState extends State<UnderGroundDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
      ),
      child: Column(
        children: <Widget>[
          matchSchedulData(),
          Divider(
            height: 1,
          ),
          Expanded(
            child: matchInfoList(),
          ),
        ],
      ),
    );
  }

  Widget matchInfoList() {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: 1,
      itemBuilder: (context, index) {
        return Container(
          child: Column(
            children: <Widget>[
              Container(
                padding:
                    EdgeInsets.only(right: 16, left: 16, top: 10, bottom: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 100,
                      child: Text(
                        'Match',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: AllCoustomTheme.getTextThemeColors(),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: Text(
                        widget.country1Name! + " vs " + widget.country2Name!,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Container(
                padding: EdgeInsets.only(right: 16, left: 16, bottom: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 100,
                      child: Text(
                        'Series',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: AllCoustomTheme.getTextThemeColors(),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: Text(
                        widget.titel!,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              // Container(
              //   padding: EdgeInsets.only(right: 16, left: 16, bottom: 6),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: <Widget>[
              //       Container(
              //         width: 100,
              //         child: Text(
              //           'Start Date',
              //           textAlign: TextAlign.start,
              //           style: TextStyle(
              //             fontFamily: 'Poppins',
              //             fontSize: ConstanceData.SIZE_TITLE16,
              //             color: AllCoustomTheme.getTextThemeColors(),
              //           ),
              //         ),
              //       ),
              //       SizedBox(
              //         width: 20,
              //       ),
              //       Flexible(
              //         child: Text(
              //           widget.time!,
              //           style: TextStyle(
              //             fontFamily: 'Poppins',
              //             fontSize: ConstanceData.SIZE_TITLE16,
              //             color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              // Divider(),
              Container(
                padding: EdgeInsets.only(right: 16, left: 16, bottom: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 100,
                      child: Text(
                        'Start Time',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: AllCoustomTheme.getTextThemeColors(),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: Text(
                        widget.time!,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Container(
                padding: EdgeInsets.only(right: 16, left: 16, bottom: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 100,
                      child: Text(
                        'Venue',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: AllCoustomTheme.getTextThemeColors(),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: Text(
                        'India',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Container(
                padding: EdgeInsets.only(right: 16, left: 16, bottom: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 100,
                      child: Text(
                        'Umpires',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: AllCoustomTheme.getTextThemeColors(),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: Text(
                        'Martine',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Container(
                padding: EdgeInsets.only(right: 16, left: 16, bottom: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 100,
                      child: Text(
                        'Referee',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: AllCoustomTheme.getTextThemeColors(),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: Text(
                        'Charls piter',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Container(
                padding: EdgeInsets.only(right: 16, left: 16, bottom: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 100,
                      child: Text(
                        'Match Format',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: AllCoustomTheme.getTextThemeColors(),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: Text(
                        'Match Formate',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              Container(
                padding: EdgeInsets.only(right: 16, left: 16, bottom: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 100,
                      child: Text(
                        'Location',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: AllCoustomTheme.getTextThemeColors(),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Flexible(
                      child: Text(
                        'India',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: ConstanceData.SIZE_TITLE16,
                          color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Divider()
            ],
          ),
        );
      },
    );
  }

  Widget matchSchedulData() {
    return Container(
      padding: EdgeInsets.all(10),
      height: 60,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 30,
                height: 30,
                child: Container(
                  width: 50,
                  height: 50,
                  child: Image.network(widget.country1Flag!),
                ),
              ),
            ],
          ),
          Container(
            padding: EdgeInsets.only(left: 4),
            child: new Text(
              widget.country1Name!,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                color: AllCoustomTheme.getThemeData().primaryColor,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            child: Text(
              'vs',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: ConstanceData.SIZE_TITLE14,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Container(
            child: new Text(
              widget.country2Name!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                color: AllCoustomTheme.getThemeData().primaryColor,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 4),
            child: Container(
              child: Container(
                width: 50,
                height: 50,
                child: Image.network(widget.country2Flag!),
              ),
            ),
          ),
          Expanded(
            child: Container(),
          ),
          Text(
            widget.time!,
            style: TextStyle(
              fontFamily: 'Poppins',
              color: HexColor(
                '#AAAFBC',
              ),
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

enum AppBarBehavior { normal, pinned, floating, snapping }
