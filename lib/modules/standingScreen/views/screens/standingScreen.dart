// ignore_for_file: deprecated_member_use
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:tempalteflutter/constance/constance.dart';
import 'package:tempalteflutter/constance/global.dart';
import 'package:tempalteflutter/constance/sharedPreferences.dart';
import 'package:tempalteflutter/constance/themes.dart';
import 'package:tempalteflutter/core/Utils/constants.dart';
import 'package:tempalteflutter/core/localstorage/localstorage.dart';
import 'package:tempalteflutter/models/userData.dart';
import 'package:tempalteflutter/modules/drawer/views/screens/drawer.dart';
import 'package:tempalteflutter/modules/home/views/screens/homeScreen.dart';
import 'package:tempalteflutter/modules/result/standingResult.dart';
import 'package:tempalteflutter/modules/standingScreen/domain/completedmatchmodel.dart';
import 'package:tempalteflutter/modules/standingScreen/domain/livematchmodel.dart';
import 'package:tempalteflutter/modules/standingScreen/views/provider/completematchprovider.dart';
import 'package:tempalteflutter/modules/standingScreen/views/provider/livematchesprovider.dart';
import 'package:tempalteflutter/modules/standingScreen/views/provider/upcomingmatchesprovider.dart';
import 'package:tempalteflutter/utils/avatarImage.dart';

import '../../domain/upcomingmatchmodel.dart';

class StandingScree extends StatefulWidget {
  final void Function()? menuCallBack;

  const StandingScree({Key? key, this.menuCallBack}) : super(key: key);
  @override
  _StandingScreeState createState() => _StandingScreeState();
}

class _StandingScreeState extends State<StandingScree>
    with SingleTickerProviderStateMixin {
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKeyF =
      new GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Stack(
        children: <Widget>[
          Container(
            color: AllCoustomTheme.getThemeData().primaryColor,
          ),
          SafeArea(
            child: Scaffold(
              drawer: AppDrawer(
                mySettingClick: () {},
                referralClick: () {},
              ),
              appBar: AppBar(
                elevation: 0,
                backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
                title: Text(
                  'Standings',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                bottom: TabBar(
                  tabs: [
                    Tab(
                      icon: Text(
                        "Upcoming",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Tab(
                      icon: Text(
                        "Live",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Tab(
                      icon: Text(
                        "Completed",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              body: Container(
                color: AllCoustomTheme.getThemeData().colorScheme.background,
                child: TabBarView(
                  children: <Widget>[
                    Fixtures(),
                    Live(),
                    Results(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  UserData userData = new UserData();

  Widget drawerButton() {
    return InkWell(
      onTap: openDrawer,
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundColor:
                AllCoustomTheme.getThemeData().scaffoldBackgroundColor,
            radius: 14,
            child: AvatarImage(
              imageUrl: ConstanceData.appIcon,
              isCircle: true,
              radius: 28,
              sizeValue: 28,
              isAssets: false,
            ),
          ),
          Icon(Icons.sort,
              color: AllCoustomTheme.getReBlackAndWhiteThemeColors())
        ],
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
              'Standings',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 24,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w500,
                color: AllCoustomTheme.getThemeData().colorScheme.background,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void openDrawer() {
    widget.menuCallBack!();
  }
}


class Fixtures extends StatefulWidget {
  @override
  _FixturesState createState() => _FixturesState();
}

class _FixturesState extends State<Fixtures> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      displacement: 100,
      key: _refreshIndicatorKey,
      onRefresh: () async {
        await Provider.of<GetUpcomingMatchesProvider>(context, listen: false).getupcoming();
      },
      child: Consumer<GetUpcomingMatchesProvider>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final upcoming = value.todos;
          if (upcoming == null || upcoming.isEmpty) {
            return const Center(
              child: Text('No data found'),
            );
          }

          return ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(), // Ensures the ListView is always scrollable to trigger the refresh
            itemCount: upcoming.length,
            shrinkWrap: true,
            reverse: true,
            itemBuilder: (context, index) {
              final todo = upcoming[index];
              DateTime now = DateTime.now();
              Duration difference = todo.startTime.difference(now);

              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StandingResultUcoming(
                        winLevels: todo.contestSettings.winLevels,
                        entryprize: todo.entryFee.toString(),
                        maxuser: todo.maxParticipants,
                        titel: todo.matchId.competition.title,
                        country1Name: todo.matchId.teama.shortName,
                        country2Name: todo.matchId.teamb.shortName,
                        country1Flag: todo.matchId.teama.logoUrl,
                        country2Flag: todo.matchId.teamb.logoUrl,
                        price: todo.prizePool.toString(),
                        time: ' ${difference.inHours.remainder(24)}h ${difference.inMinutes.remainder(60)}m',
                        participants: todo.participants,
                      ),
                    ),
                  );
                },
                child: MatchesList(
                  winLevels: todo.contestSettings.winLevels,
                  entryprize: todo.entryFee.toString(),
                  maxuser: todo.maxParticipants,
                  titel: todo.matchId.competition.title,
                  country1Name: todo.matchId.teama.shortName,
                  country2Name: todo.matchId.teamb.shortName,
                  country1Flag: todo.matchId.teama.logoUrl,
                  country2Flag: todo.matchId.teamb.logoUrl,
                  price: todo.prizePool.toString(),
                  time: ' ${difference.inHours.remainder(24)}h ${difference.inMinutes.remainder(60)}m',
                  participants: todo.participants,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class Live extends StatefulWidget {
  @override
  _LiveState createState() => _LiveState();
}

class _LiveState extends State<Live> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Consumer<GetLiveMatchesProvider>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final upcoming = value.todos;
          if (upcoming == null) {
            return const Center(
              child: Text('No data found'),
            );
          }

          return Column(
            children: [
              upcoming.length == 0 ?  Column(
                children: [
                  Container(
                    color: Colors.white,
                    width: 100,
                    height: 100,
                    child: Image.asset(
                      'assets/cup.png',
                      width: 50,
                      height: 50,
                    ),
                  ),
                  Text(
                    "You haven't joined any contests that are Live\nJoin contests for any of the upcoming matches",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: ConstanceData.SIZE_TITLE14,
                      color: primaryColorString,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                ],
              ) : SizedBox(),
              ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: upcoming.length,
                shrinkWrap: true,
                reverse: true,
                itemBuilder: (context, index) {
                  final todo = upcoming[index];

                  DateTime now = DateTime.now();

                  Duration difference = todo.startTime.difference(now);
                  return InkWell(
                    onTap: () async{
                      await Storage().setItem('livematchid', todo.matchId.matchId.toString());
                      List<PlayersPoint> allPlayersPoints = [];

                      todo.participants.forEach((element) {
                        allPlayersPoints.addAll(element.team.playersPoints);
                      });
                      print(allPlayersPoints);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StandingResultLive(
                            playersPoints: allPlayersPoints,
                            winLevels: todo.contestSettings.winLevels,
                            entryprize: todo.entryFee.toString(),
                            maxuser: todo.maxParticipants,
                            titel: todo.matchId.competition.title,
                            country1Name: todo.matchId.teama.shortName,
                            country2Name: todo.matchId.teamb.shortName,
                            country1Flag: todo.matchId.teama.logoUrl,
                            country2Flag: todo.matchId.teamb.logoUrl,
                            price: todo.prizePool.toString(),
                            time:
                            '',
                            participants: todo.participants,
                          ),
                        ),
                      );
                    },
                    child: MatchesListLive(
                      winLevels: todo.contestSettings.winLevels,
                      entryprize: todo.entryFee.toString(),
                      maxuser: todo.maxParticipants,
                      titel: todo.matchId.competition.title,
                      country1Name: todo.matchId.teama.shortName,
                      country2Name: todo.matchId.teamb.shortName,
                      country1Flag: todo.matchId.teama.logoUrl,
                      country2Flag: todo.matchId.teamb.logoUrl,
                      price: todo.prizePool.toString(),
                      time:
                      ' ${difference.inHours.remainder(24)}h ${difference.inMinutes.remainder(60)}m',
                      participants: todo.participants,
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}

class Results extends StatefulWidget {
  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Consumer<GetCompleteMatchesProvider>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final upcoming = value.todos;
          if (upcoming == null) {
            return const Center(
              child: Text('No data found',style: TextStyle(color: Colors.black),),
            );
          }

          return ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: upcoming.length,
            shrinkWrap: true,
            reverse: true,
            itemBuilder: (context, index) {
              final todo = upcoming[index];

              DateTime now = DateTime.now();

              Duration difference = todo.startTime.difference(now);
              return InkWell(
                onTap: () async{
                  await Storage().setItem('livematchid', todo.matchId.matchId.toString());
                  List<PlayersPointComplete> playersPoints = [];
                  todo.participants.forEach((element) {
                    playersPoints.addAll(element.team.playersPoints);
                  });
                  print(playersPoints);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StandingResultComplete(
                        playersPoints: playersPoints,
                        winLevels: todo.contestSettings.winLevels,
                        entryprize: todo.entryFee.toString(),
                        maxuser: todo.maxParticipants,
                        titel: todo.matchId.competition.title,
                        country1Name: todo.matchId.teama.shortName,
                        country2Name: todo.matchId.teamb.shortName,
                        country1Flag: todo.matchId.teama.logoUrl,
                        country2Flag: todo.matchId.teamb.logoUrl,
                        price: todo.prizePool.toString(),
                        time: ' ',
                        participants: todo.participants,
                      ),
                    ),
                  );
                },
                child: MatchesListComplete(
                  winLevels: todo.contestSettings.winLevels,
                  entryprize: todo.entryFee.toString(),
                  maxuser: todo.maxParticipants,
                  titel: todo.matchId.competition.title,
                  country1Name: todo.matchId.teama.shortName,
                  country2Name: todo.matchId.teamb.shortName,
                  country1Flag: todo.matchId.teama.logoUrl,
                  country2Flag: todo.matchId.teamb.logoUrl,
                  price: todo.prizePool.toString(),
                  time:
                  ' ${difference.inHours.remainder(24)}h ${difference.inMinutes.remainder(60)}m',
                  participants: todo.participants,
                ),
              );
            },
          );
        },
      ),
    );
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
  final String? entryprize;
  final int? maxuser;
  List<Participant> participants;
  List<WinLevel> winLevels;

  MatchesList(
      {Key? key,
      this.titel,
      this.country1Name,
      this.country2Name,
      this.time,
      this.price,
      this.country1Flag,
      this.country2Flag,
      required this.winLevels,
      required this.participants,
      this.entryprize,
      this.maxuser})
      : super(key: key);

  @override
  _MatchesListState createState() => _MatchesListState();
}

class _MatchesListState extends State<MatchesList> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                  children: [
                    Text(
                      widget.titel!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: ConstanceData.SIZE_TITLE12,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).disabledColor,
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    // Image.asset(
                    //   ConstanceData.lineups,
                    //   height: 14,
                    // ),
                    // SizedBox(
                    //   width: 8,
                    // ),
                    // Icon(
                    //   Icons.notification_add_outlined,
                    //   size: 16,
                    // ),
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
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 3,
                          backgroundColor: Colors.green,
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Text(
                          widget.time!,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: ConstanceData.SIZE_TITLE12,
                            color: Colors.green,
                          ),
                        ),
                      ],
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
                      fontSize: ConstanceData.SIZE_TITLE12,
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
  final String? entryprize;
  final int? maxuser;
  List<Participants> participants;
  List<WinLevels> winLevels;

  MatchesListLive(
      {Key? key,
      this.titel,
      this.country1Name,
      this.country2Name,
      this.time,
      this.price,
      this.country1Flag,
      this.country2Flag,
      required this.winLevels,
      required this.participants,
      this.entryprize,
      this.maxuser})
      : super(key: key);

  @override
  _MatchesListLiveState createState() => _MatchesListLiveState();
}

class _MatchesListLiveState extends State<MatchesListLive> {

  @override
  Widget build(BuildContext context) {
    return Container(
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
                Text(
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
                    // Row(
                    //   children: [
                    //     CircleAvatar(
                    //       radius: 3,
                    //       backgroundColor: Colors.green,
                    //     ),
                    //     SizedBox(
                    //       width: 2,
                    //     ),
                    //     Text(
                    //       widget.time!,
                    //       style: TextStyle(
                    //         fontFamily: 'Poppins',
                    //         fontSize: ConstanceData.SIZE_TITLE12,
                    //         color: Colors.green,
                    //       ),
                    //     ),
                    //   ],
                    // ),
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
                      fontSize: ConstanceData.SIZE_TITLE12,
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
    );
  }
}

class MatchesListComplete extends StatefulWidget {
  final String? titel;
  final String? country1Name;
  final String? country1Flag;
  final String? country2Name;
  final String? country2Flag;
  final String? time;
  final String? price;
  final String? entryprize;
  final int? maxuser;
  List<Participantcomplete> participants;
  List<WinLevelcomplete> winLevels;

  MatchesListComplete(
      {Key? key,
      this.titel,
      this.country1Name,
      this.country2Name,
      this.time,
      this.price,
      this.country1Flag,
      this.country2Flag,
      required this.winLevels,
      required this.participants,
      this.entryprize,
      this.maxuser})
      : super(key: key);

  @override
  _MatchesListCompleteState createState() => _MatchesListCompleteState();
}

class _MatchesListCompleteState extends State<MatchesListComplete> {

  @override
  Widget build(BuildContext context) {
    return Container(
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
                  children: [
                    Text(
                      widget.titel!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: ConstanceData.SIZE_TITLE12,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).disabledColor,
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    // Image.asset(
                    //   ConstanceData.lineups,
                    //   height: 14,
                    // ),
                    // SizedBox(
                    //   width: 8,
                    // ),
                    // Icon(
                    //   Icons.notification_add_outlined,
                    //   size: 16,
                    // ),
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
                    // Row(
                    //   children: [
                    //     CircleAvatar(
                    //       radius: 3,
                    //       backgroundColor: Colors.green,
                    //     ),
                    //     SizedBox(
                    //       width: 2,
                    //     ),
                    //     Text(
                    //       widget.time!,
                    //       style: TextStyle(
                    //         fontFamily: 'Poppins',
                    //         fontSize: ConstanceData.SIZE_TITLE12,
                    //         color: Colors.green,
                    //       ),
                    //     ),
                    //   ],
                    // ),
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
                      fontSize: ConstanceData.SIZE_TITLE12,
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
            tabs: [
              new Tab(text: 'Fixtures'),
              new Tab(text: 'Live'),
              new Tab(text: 'Results'),
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
