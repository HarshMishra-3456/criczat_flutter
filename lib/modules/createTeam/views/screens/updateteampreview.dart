import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tempalteflutter/constance/constance.dart';
import 'package:tempalteflutter/constance/themes.dart';
import 'package:tempalteflutter/modules/createTeam/domain/selectplayermodel.dart';
import 'package:tempalteflutter/modules/createTeam/views/provider/selectplayerprovider.dart';
import 'package:tempalteflutter/modules/createTeam/views/screens/createTeamview.dart';
import 'package:tempalteflutter/modules/home/views/provider/playing11provider.dart';
import 'package:tempalteflutter/utils/avatarImage.dart';

class UpdateTeamPreview extends StatefulWidget {
  int captain = 0;
  int vicecaptain = 0;
  List<String> notPlayingids = [];
  Map<String, int>? teamFrequency = {};
  final String? country1Name;
  final String? country2Name;
  UpdateTeamPreview({
    super.key,
    required this.captain,
    required this.notPlayingids,
    this.teamFrequency,
    required this.vicecaptain,
    this.country1Name,
    this.country2Name,
  });

  @override
  State<UpdateTeamPreview> createState() => _UpdateTeamPreviewState();
}

class _UpdateTeamPreviewState extends State<UpdateTeamPreview> {
  String? formatTeamFrequencies() {
    return widget.teamFrequency?.entries.map((entry) {
      return "${entry.key}: ${entry.value}";
    }).join(", ");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Stack(
        children: <Widget>[
          SafeArea(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Stack(
                alignment: AlignmentDirectional.center,
                children: <Widget>[
                  Opacity(
                    opacity: 0.4,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Image.asset(
                        ConstanceData.cricketGround,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Consumer<SelectedPlayersProvider>(
                    builder: (context, value, child) {
                      List<SelectPlayer> wkList = value.selectedPlayers
                          .where((player) => player.playingRole == 'wk')
                          .toList();
                      List<SelectPlayer> batList = value.selectedPlayers
                          .where((player) => player.playingRole == 'bat')
                          .toList();
                      List<SelectPlayer> arList = value.selectedPlayers
                          .where((player) => player.playingRole == 'all')
                          .toList();
                      List<SelectPlayer> bowlList = value.selectedPlayers
                          .where((player) => player.playingRole == 'bowl')
                          .toList();

                      return Container(
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: 8,
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(bottom: 8, top: 4),
                                    child: Text(
                                      'WICKET - KEEPER',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                        fontSize: ConstanceData.SIZE_TITLE12,
                                      ),
                                    ),
                                  ),
                                  getTypeList(wkList),
                                ],
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(bottom: 8, top: 4),
                                    child: Text(
                                      'BATSMEN',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                        fontSize: ConstanceData.SIZE_TITLE12,
                                      ),
                                    ),
                                  ),
                                  getTypeList(
                                      batList), // Display list of batsmen
                                ],
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(bottom: 8, top: 4),
                                    child: Text(
                                      'ALL-ROUNDERS',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                        fontSize: ConstanceData.SIZE_TITLE12,
                                      ),
                                    ),
                                  ),
                                  getTypeList(arList),
                                ],
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.only(bottom: 8, top: 4),
                                    child: Text(
                                      'BOWLERS',
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Colors.white,
                                        fontSize: ConstanceData.SIZE_TITLE12,
                                      ),
                                    ),
                                  ),
                                  getTypeList(bowlList),
                                ],
                              ),
                              SizedBox(
                                height: 8,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
            child: Container(
              height: AppBar().preferredSize.height,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        child: Icon(Icons.close, color: Colors.white),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        // Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CreateTeamView(isupdate: true),
                            ));
                      },
                      child: Container(
                        width: AppBar().preferredSize.height,
                        height: AppBar().preferredSize.height,
                        child: Icon(Icons.edit, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget getTypeList(List<SelectPlayer> list) {
    List<Widget> rows = [];
    List<Widget> playersRow = [];

    for (int i = 0; i < list.length; i++) {
      playersRow.add(getPlayerView(list[i]));

      if (playersRow.length == 3 || i == list.length - 1) {
        rows.add(Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: playersRow,
          ),
        ));

        playersRow = [];
      }
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: rows,
      ),
    );
  }

  Widget getPlayerView(SelectPlayer player) {
    // Debug prints to help troubleshoot
    print('notPlayingids: ${widget.notPlayingids}');
    print('Player ID: ${player.pid}');

    String playerIdString = player.pid.toString();

    Set<String> notPlayingIdsSet = widget.notPlayingids.map((id) => id.toString()).toSet();

    bool isNotPlaying = notPlayingIdsSet.contains(playerIdString);

    print('Is not playing: $isNotPlaying');  // Debug print

    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
              left: (MediaQuery.of(context).size.width > 360 ? 8 : 4),
              right: (MediaQuery.of(context).size.width > 360 ? 8 : 4)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: (MediaQuery.of(context).size.width > 360 ? 45 : 40),
                height: (MediaQuery.of(context).size.width > 360 ? 45 : 40),
                child: AvatarImage(
                  isAssets: true,
                  imageUrl: 'assets/cricketdemoplayer.png',
                  radius: (MediaQuery.of(context).size.width > 360 ? 45 : 40),
                  sizeValue: (MediaQuery.of(context).size.width > 360 ? 45 : 40),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 6, top: 2, bottom: 2, right: 6),
                decoration: new BoxDecoration(
                  color: AllCoustomTheme.getThemeData().primaryColor,
                  borderRadius: new BorderRadius.circular(4.0),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        offset: Offset(0, 1),
                        blurRadius: 5.0),
                  ],
                ),
                child: Center(
                  child: Text(
                    player.shortName.length > 15
                        ? '${player.shortName.substring(0, 15)}...'
                        : player.shortName ?? '',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.width > 360 ? 9 : 8,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.all(4),
                child: Center(
                  child: Text(
                    '${player.fantasyPlayerRating}  Cr',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontSize: ConstanceData.SIZE_TITLE10,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: isNotPlaying ? Colors.red : Colors.green,
              borderRadius: BorderRadius.circular(32.0),
              border: Border.all(
                width: 1.0,
                color: Colors.white,
              ),
            ),
            child: Center(
              child: Text(
                isNotPlaying ? '' : '',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: ConstanceData.SIZE_TITLE10,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 0,
          left: 0,
          child: widget.captain == player.pid
              ? Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(32.0),
              border: Border.all(
                width: 1.0,
                color: Colors.white,
              ),
            ),
            child: Container(
              padding: EdgeInsets.only(bottom: 2),
              child: Center(
                child: Text(
                  'C',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: ConstanceData.SIZE_TITLE10,
                  ),
                ),
              ),
            ),
          )
              : widget.vicecaptain == player.pid
              ? Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(32.0),
              border: Border.all(
                width: 1.0,
                color: Colors.white,
              ),
            ),
            child: Container(
              padding: EdgeInsets.only(bottom: 4),
              child: Center(
                child: Text(
                  'vc',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 11,
                  ),
                ),
              ),
            ),
          )
              : SizedBox(),
        ),
      ],
    );
  }
}
