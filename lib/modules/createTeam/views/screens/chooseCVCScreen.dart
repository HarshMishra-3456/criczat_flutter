// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:tempalteflutter/constance/constance.dart';
import 'package:tempalteflutter/constance/themes.dart';
import 'package:tempalteflutter/modules/createTeam/data/saveteamapi.dart';
import 'package:tempalteflutter/modules/createTeam/domain/selectplayermodel.dart';
import 'package:tempalteflutter/modules/createTeam/views/provider/selectplayerprovider.dart';
import 'package:tempalteflutter/modules/createTeam/views/screens/previewteamplayer.dart';
import 'package:provider/provider.dart';


class ChooseCVCScreen extends StatefulWidget {
  bool? isupdate;
  ChooseCVCScreen({super.key, this.isupdate});

  @override
  _ChooseCVCScreenState createState() => _ChooseCVCScreenState();
}

class _ChooseCVCScreenState extends State<ChooseCVCScreen> {
  bool iscaptain = false;
  bool isvicecaptain = false;
  int selectindex = 0;
  int cappid = 0;
  bool isLoading = false;
  String playrole = '';
  int selectindexvc = 0;
  int vccappid = 0;
  String vcplayrole = '';
  static DateTime now = DateTime.now();
  String formattedDate = DateFormat('E, d MMM').format(now);

  @override
  void initState() {

    super.initState();
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
      child: Stack(
        children: <Widget>[
          SafeArea(
            child: Scaffold(
              backgroundColor: AllCoustomTheme.getThemeData().colorScheme.background,
              body: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: <Widget>[
                  Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
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
                                          formattedDate,
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 24,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
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
                              Container(
                                child: Center(
                                  child: Text(
                                    'Choose Captain and Vice Captain',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                              Container(
                                child: Center(
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              width: 30,
                                              height: 30,
                                              child: Center(
                                                child: Container(
                                                  width: 24,
                                                  height: 24,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        new BorderRadius
                                                            .circular(30.0),
                                                    border: new Border.all(
                                                      width: 1.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        bottom: 2, top: 2),
                                                    child: Center(
                                                      child: Text(
                                                        'C',
                                                        style: TextStyle(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize:
                                                              ConstanceData
                                                                  .SIZE_TITLE12,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  EdgeInsets.only(bottom: 4),
                                              child: Center(
                                                child: Text(
                                                  ' gets 2x points',
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    color: Colors.white,
                                                    fontSize: ConstanceData
                                                        .SIZE_TITLE14,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Container(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              width: 30,
                                              height: 30,
                                              child: Center(
                                                child: Container(
                                                  width: 24,
                                                  height: 24,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        new BorderRadius
                                                            .circular(30.0),
                                                    border: new Border.all(
                                                      width: 1.0,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        bottom: 4, top: 1),
                                                    child: Center(
                                                      child: Text(
                                                        'vc',
                                                        style: TextStyle(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize:
                                                              ConstanceData
                                                                  .SIZE_TITLE14,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              padding:
                                                  EdgeInsets.only(bottom: 4),
                                              child: Center(
                                                child: Text(
                                                  ' gets 1.5x points',
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    color: Colors.white,
                                                    fontSize: ConstanceData
                                                        .SIZE_TITLE14,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 8,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                headertext(headertext: 'Wicket Keeper'),
                                SizedBox(
                                  height: 10,
                                ),
                                getplayerdata(playingrole: 'wk'),
                                SizedBox(
                                  height: 10,
                                ),
                                headertext(headertext: 'Batsman'),
                                SizedBox(
                                  height: 10,
                                ),
                                getplayerdata(playingrole: 'bat'),
                                SizedBox(
                                  height: 10,
                                ),
                                headertext(
                                  headertext: 'All Rounders',
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                getplayerdata(playingrole: 'all'),
                                headertext(headertext: 'Bowlers'),
                                SizedBox(
                                  height: 10,
                                ),
                                getplayerdata(playingrole: 'bowl'),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 60),
                    child: Container(
                      height: 60,
                      padding: EdgeInsets.only(left: 50, right: 50, bottom: 20),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              decoration: new BoxDecoration(
                                color: Colors.white,
                                borderRadius: new BorderRadius.circular(4.0),
                                boxShadow: <BoxShadow>[
                                  BoxShadow(
                                      color: AllCoustomTheme.getThemeData()
                                          .primaryColor
                                          .withOpacity(0.5),
                                      offset: Offset(0, 1),
                                      blurRadius: 5.0),
                                ],
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: new BorderRadius.circular(4.0),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PreviewTeamPlayer(),
                                        fullscreenDialog: true,
                                      ),
                                    );
                                  },
                                  child: Center(
                                    child: Text(
                                      'PREVIEW',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.bold,
                                        color: AllCoustomTheme.getThemeData()
                                            .primaryColor,
                                        fontSize: ConstanceData.SIZE_TITLE12,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          Consumer<SelectedPlayersProvider>(
                            builder: (context, value, child) {
                              var isDisabled = value.selectedPlayers.length != 11;

                              List<int> playerid = value.selectedPlayers.map((player) => player.pid).toList();

                              return Expanded(
                                child: Opacity(
                                  opacity: (vcplayrole.isNotEmpty && playrole.isNotEmpty) ? 1.0 : 0.2,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AllCoustomTheme.getThemeData().primaryColor,
                                      borderRadius: BorderRadius.circular(4.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.5),
                                          offset: Offset(0, 1),
                                          blurRadius: 5.0,
                                        ),
                                      ],
                                    ),
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(4.0),
                                        onTap: isDisabled || isLoading
                                            ? null
                                            : () async {
                                          if (vcplayrole.isNotEmpty && playrole.isNotEmpty) {
                                            setState(() => isLoading = true); // Show loader

                                            if (widget.isupdate == true) {
                                              await MatchTeam().UpdateTeam(
                                                pid: playerid,
                                                capid: cappid,
                                                context: context,
                                                vccapid: vccappid,
                                              );
                                            } else {
                                              await MatchTeam().CreateTeam(
                                                pid: playerid,
                                                capid: cappid,
                                                context: context,
                                                vccapid: vccappid,
                                              );
                                            }

                                            setState(() => isLoading = false); // Hide loader
                                          }
                                        },
                                        child: Center(
                                          child: isLoading
                                              ? SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 2.5,
                                            ),
                                          )
                                              : Text(
                                            'SAVE TEAM',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: ConstanceData.SIZE_TITLE12,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget headertext({required String headertext}) {
    return Container(
      height: 40,
      margin: EdgeInsets.only(top: 5, bottom: 5),
      alignment: Alignment.center,
      width: double.infinity,
      color: Color(0xFFDAE3EA),
      child: Text(
        headertext,
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, fontFamily: 'Poppins'),
      ),
    );
  }

  Widget getplayerdata({required String playingrole}) {
    return Consumer<SelectedPlayersProvider>(
      builder: (context, value, child) {
        final List<SelectPlayer> players = value.selectedPlayers;

        final List<SelectPlayer> filteredPlayers = players
            .where((player) => player.playingRole == playingrole)
            .toList();

        return ListView.builder(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          itemCount: filteredPlayers.length,
          itemBuilder: (context, index) {
            final player = filteredPlayers[index];

            return Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10, right: 20),
                            height: 40,
                            width: 50,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                  'assets/cricketdemoplayer.png',
                                )),
                                color: Colors.grey,
                                shape: BoxShape.circle),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                player.shortName ?? '',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1,
                                  color: AllCoustomTheme
                                      .getBlackAndWhiteThemeColors(),
                                  fontSize: 15,
                                ),
                              ),
                              Text(
                                player.fantasyPlayerPoint ?? '',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                playrole = playingrole;
                                selectindex = index;
                                cappid = player.pid;
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 35,
                              width: 50,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 2,
                                  color: playingrole == playrole &&
                                          index == selectindex
                                      ? Color(0xFF064475)
                                      : Colors.black,
                                ),
                                color: playingrole == playrole &&
                                        index == selectindex
                                    ? Color(0xFF064475)
                                    : Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                'C',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: playingrole == playrole &&
                                          index == selectindex
                                      ? Colors.white
                                      : Color(0xFF064475),
                                  fontFamily: 'Poppins',
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                vcplayrole = playingrole;
                                selectindexvc = index;
                                vccappid = player.pid;
                              });
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 35,
                              width: 50,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  width: 2,
                                  color: playingrole == vcplayrole &&
                                          index == selectindexvc
                                      ? Color(0xFF064475)
                                      : Colors.black,
                                ),
                                color: playingrole == vcplayrole &&
                                        index == selectindexvc
                                    ? Color(0xFF064475)
                                    : Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                'VC',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: playingrole == vcplayrole &&
                                          index == selectindexvc
                                      ? Colors.white
                                      : Color(0xFF064475),
                                  fontFamily: 'Poppins',
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
