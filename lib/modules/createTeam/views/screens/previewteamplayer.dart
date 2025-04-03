import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tempalteflutter/constance/constance.dart';
import 'package:tempalteflutter/constance/themes.dart';
import 'package:tempalteflutter/modules/createTeam/domain/selectplayermodel.dart';
import 'package:tempalteflutter/modules/createTeam/views/provider/selectplayerprovider.dart';
import 'package:tempalteflutter/utils/avatarImage.dart';

class PreviewTeamPlayer extends StatefulWidget {
  const PreviewTeamPlayer({super.key});

  @override
  State<PreviewTeamPlayer> createState() => _PreviewTeamPlayerState();
}

class _PreviewTeamPlayerState extends State<PreviewTeamPlayer> {

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
                      List<SelectPlayer> wkList = value.selectedPlayers.where((player) => player.playingRole == 'wk').toList();
                      List<SelectPlayer> batList = value.selectedPlayers.where((player) => player.playingRole == 'bat').toList();
                      List<SelectPlayer> arList = value.selectedPlayers.where((player) => player.playingRole == 'all').toList();
                      List<SelectPlayer> bowlList = value.selectedPlayers.where((player) => player.playingRole == 'bowl').toList();

                      return Container(
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
                                getTypeList(wkList), // Display list of wicket-keepers
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
                                getTypeList(batList), // Display list of batsmen
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
                                getTypeList(arList), // Display list of all-rounders
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
                                getTypeList(bowlList), // Display list of bowlers
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                          ],
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
                  Expanded(
                    child: Container(),
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

      if (playersRow.length == 4 || i == list.length - 1) {
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
    List<Color> availableColors = [
      Colors.blue,
      Colors.green,
      Colors.red,
      Colors.orange,
      Colors.purple,
      // Colors.yellow,
      Colors.teal,
      Colors.pink,
    ];

    Color getColorForTeam(String teamName) {
      int index = teamName.hashCode % availableColors.length;
      return availableColors[index];
    }

    Color teamColor = getColorForTeam(player.teamname.trim());

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
              InkWell(
                child: Container(
                  width: (MediaQuery.of(context).size.width > 360 ? 45 : 40),
                  height: (MediaQuery.of(context).size.width > 360 ? 45 : 40),
                  child: AvatarImage(
                    isAssets: true,
                    imageUrl: 'assets/cricketdemoplayer.png',
                    radius: (MediaQuery.of(context).size.width > 360 ? 45 : 40),
                    sizeValue: (MediaQuery.of(context).size.width > 360 ? 45 : 40),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 6, top: 2, bottom: 2, right: 6),
                decoration: BoxDecoration(
                  color: teamColor, // Set the dynamically assigned team color
                  borderRadius: BorderRadius.circular(4.0),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        offset: Offset(0, 1),
                        blurRadius: 5.0),
                  ],
                ),
                child: Center(
                  child: Text(
                    player.shortName ?? '',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontSize:
                      (MediaQuery.of(context).size.width > 360 ? 10 : 8),
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
                      fontSize: 10,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

}
