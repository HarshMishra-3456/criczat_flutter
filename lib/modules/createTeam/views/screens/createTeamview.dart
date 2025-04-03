import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:tempalteflutter/constance/constance.dart';
import 'package:tempalteflutter/constance/themes.dart';
import 'package:tempalteflutter/core/Utils/constants.dart';
import 'package:tempalteflutter/modules/createTeam/domain/getplayerdetailsmodel.dart';
import 'package:tempalteflutter/modules/createTeam/domain/selectplayermodel.dart';
import 'package:tempalteflutter/modules/createTeam/views/provider/getplayerdetailsprovider.dart';
import 'package:tempalteflutter/modules/createTeam/views/provider/selectplayerprovider.dart';
import 'package:tempalteflutter/modules/createTeam/views/screens/createTeamProgressbar.dart';
import 'package:tempalteflutter/modules/createTeam/views/screens/previewteamplayer.dart';
import 'package:tempalteflutter/modules/home/views/provider/playing11provider.dart';
import 'package:tempalteflutter/utils/avatarImage.dart';
import 'chooseCVCScreen.dart';


class CreateTeamView extends StatefulWidget {
  bool isupdate;
  CreateTeamView({super.key, required this.isupdate});

  @override
  State<CreateTeamView> createState() => _CreateTeamViewState();
}

class _CreateTeamViewState extends State<CreateTeamView>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  var selectedIndex = 0;
  bool _isAscending = true;

  @override
  void initState() {
    print(widget.isupdate);
    if (widget.isupdate == false) {
      final selectedPlayersProvider =
          Provider.of<SelectedPlayersProvider>(context, listen: false);
      selectedPlayersProvider.clearPlayers();
    }
    tabController = TabController(length: 4, vsync: this, initialIndex: 0);
    tabController.addListener(() {
      setState(() {});
      selectedIndex = tabController.index;
    });
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
      child: Scaffold(
        backgroundColor: AllCoustomTheme.getThemeData().colorScheme.background,
        body: SafeArea(
          child: Consumer<GetPlayerDetailsProvider>(
            builder: (context, value, child) {
              if (value.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final playerteam = value.todos;
              DateTime now = DateTime.now();
              String formattedDate = DateFormat('E, d MMM').format(now);
              if (playerteam == null) {
                return const Center(
                  child: Text('No data found'),
                );
              }

              return Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Column(
                    children: [
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
                              padding: EdgeInsets.all(4),
                              color:
                                  AllCoustomTheme.getThemeData().primaryColor,
                              child: Center(
                                child: Text(
                                  'Max 10 players from a team',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                      fontSize: ConstanceData.SIZE_TITLE14),
                                ),
                              ),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  top: 4, bottom: 4, left: 8, right: 8),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      padding: EdgeInsets.all(4),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            'Players',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              color: Colors.white54,
                                              fontSize: MediaQuery.of(context)
                                                          .size
                                                          .width >=
                                                      360
                                                  ? 12.0
                                                  : 10.0,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: <Widget>[
                                              Consumer<SelectedPlayersProvider>(
                                                builder:
                                                    (context, value, child) {
                                                  return Text(
                                                    value.selectedPlayers.length
                                                        .toString(),
                                                    style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                      fontSize:
                                                          MediaQuery.of(context)
                                                                      .size
                                                                      .width >=
                                                                  360
                                                              ? 20.0
                                                              : 18.0,
                                                    ),
                                                  );
                                                },
                                              ),
                                              SizedBox(width: 4),
                                              Text(
                                                ' / 11',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  color: Colors.white54,
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                                  .size
                                                                  .width >=
                                                              360
                                                          ? 12.0
                                                          : 10.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 3,
                                    child: Consumer<GetPlayerDetailsProvider>(
                                      builder: (context, value, child) {
                                        if (value.isLoading) {
                                          return Center(
                                              child:
                                                  CircularProgressIndicator());
                                        }
                                        final playerteam = value.todos;
                                        if (playerteam == null ||
                                            playerteam.isEmpty) {
                                          return Center(
                                              child: Text('No data found'));
                                        }

                                        return Wrap(
                                          spacing: 8.0,
                                          children: [
                                            for (int i = 0;
                                                i < playerteam.length ~/ 2;
                                                i++)
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 8.0),
                                                child: Row(
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .end,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Text(
                                                            playerteam[0]
                                                                    .team
                                                                    .abbr ??
                                                                '',
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white,
                                                              fontSize: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width >=
                                                                      360
                                                                  ? 14.0
                                                                  : 12.0,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    SizedBox(width: 8.0),
                                                    Container(
                                                      width: 40,
                                                      height: 40,
                                                      child: Image.network(
                                                          playerteam[0]
                                                              .team
                                                              .logoUrl),
                                                    ),
                                                    SizedBox(width: 16.0),
                                                    Container(
                                                      width: 40,
                                                      height: 40,
                                                      child: Image.network(
                                                          playerteam[1]
                                                              .team
                                                              .logoUrl),
                                                    ),
                                                    SizedBox(width: 8.0),
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          Text(
                                                            playerteam[1]
                                                                    .team
                                                                    .abbr ??
                                                                '',
                                                            textAlign:
                                                                TextAlign.start,
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Poppins',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.white,
                                                              fontSize: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width >=
                                                                      360
                                                                  ? 14.0
                                                                  : 12.0,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Container(
                                      padding: EdgeInsets.all(4),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Text(
                                            'Credits Left',
                                            textAlign: TextAlign.end,
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              color: Colors.white54,
                                              fontSize: MediaQuery.of(context)
                                                          .size
                                                          .width >=
                                                      360
                                                  ? 12.0
                                                  : 10.0,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Consumer<SelectedPlayersProvider>(
                                            builder: (context, value, child) {
                                              return Text(
                                                value.creditscore.toString(),
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                  fontSize:
                                                      MediaQuery.of(context)
                                                                  .size
                                                                  .width >=
                                                              360
                                                          ? 16.0
                                                          : 14.0,
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Consumer<SelectedPlayersProvider>(
                              builder: (context, value, child) {
                                return Container(
                                  height: 40,
                                  width: double.infinity,
                                  padding: EdgeInsets.all(8),
                                  child: CreateTeamProgressbarView(
                                    teamCount: value.selectedPlayers.length,
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              height: 4,
                            ),
                          ],
                        ),
                      ),
                      Consumer<SelectedPlayersProvider>(
                        builder: (context, value, child) {
                          return Container(
                            height: 40,
                            child: TabBar(
                              isScrollable: true,
                              indicatorWeight: 3,
                              controller: tabController,
                              unselectedLabelColor:
                                  AllCoustomTheme.getTextThemeColors(),
                              indicatorColor:
                                  AllCoustomTheme.getThemeData().primaryColor,
                              labelColor:
                                  AllCoustomTheme.getBlackAndWhiteThemeColors(),
                              tabs: <Widget>[
                                TabTextView(
                                  tabTextType: TabTextType.wk,
                                  count: value.wkCount,
                                  isSelected: selectedIndex == 0 ? true : false,
                                ),
                                TabTextView(
                                  tabTextType: TabTextType.bat,
                                  count: value.batCount,
                                  isSelected: selectedIndex == 1 ? true : false,
                                ),
                                TabTextView(
                                  tabTextType: TabTextType.ar,
                                  count: value.allCount,
                                  isSelected: selectedIndex == 2 ? true : false,
                                ),
                                TabTextView(
                                  tabTextType: TabTextType.bowl,
                                  count: value.bowlCount,
                                  isSelected: selectedIndex == 3 ? true : false,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      Flexible(
                        child: TabBarView(
                          physics: BouncingScrollPhysics(
                            parent: PageScrollPhysics(),
                          ),
                          controller: tabController,
                          children: <Widget>[
                            playertab(
                                typeofplayer: 'wk',
                                selecttype: 'Wicket-Keeper',
                                context: context),
                            playertab(
                                typeofplayer: 'bat',
                                selecttype: 'Batters',
                                context: context),
                            playertab(
                                typeofplayer: 'all',
                                selecttype: 'Allrounders',
                                context: context),
                            playertab(
                                typeofplayer: 'bowl',
                                selecttype: 'Bowlers',
                                context: context)
                          ],
                        ),
                      )
                    ],
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
                                  onTap: () async {
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
                              bool areCategoriesValid = value.areCategoriesValid();

                              bool isTeamComplete = value.isTeamComplete();

                              return Expanded(
                                child: Opacity(
                                  opacity: areCategoriesValid && isTeamComplete ? 1.0 : 0.2, // Enable or disable button opacity
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFB00020),
                                      borderRadius: BorderRadius.circular(4.0),
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                          color: AllCoustomTheme.getThemeData().primaryColor.withOpacity(0.5),
                                          offset: const Offset(0, 1),
                                          blurRadius: 5.0,
                                        ),
                                      ],
                                    ),
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(4.0),
                                      onTap: () {
                                        if (areCategoriesValid && isTeamComplete) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ChooseCVCScreen(isupdate: widget.isupdate),
                                            ),
                                          );
                                        } else if (!areCategoriesValid) {
                                          constToast('Select at least one player from each category.');
                                        } else if (!isTeamComplete) {
                                          constToast('You must select 11 players.');
                                        }
                                      },
                                      child: Center(
                                        child: Text(
                                          'CONTINUE',
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
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget playertab(
      {required String typeofplayer,
      required String selecttype,
      required BuildContext context}) {
    final playerDetailsProvider =
        Provider.of<GetPlayerDetailsProvider>(context);
    return Column(
      children: <Widget>[
        Container(
          height: 40,
          child: Container(
            height: 40,
            width: double.infinity,
            color: AllCoustomTheme.getThemeData().scaffoldBackgroundColor,
            child: Container(
              child: Center(
                child: Text(
                  'Pick 1-8 $selecttype',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                    fontSize: ConstanceData.SIZE_TITLE14,
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          height: 36,
          child: Column(
            children: <Widget>[
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(left: 74),
                      child: Center(
                        child: Text(
                          'PLAYERS',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            color: AllCoustomTheme.getTextThemeColors(),
                            fontSize: ConstanceData.SIZE_TITLE12,
                          ),
                        ),
                      ),
                    ),
                    Expanded(child: Container()),
                    Container(
                      width: 80,
                      child: Center(
                        child: Text(
                          'POINTS',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.bold,
                            color: AllCoustomTheme.getTextThemeColors(),
                            fontSize: ConstanceData.SIZE_TITLE12,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _isAscending = !_isAscending;
                        });
                        playerDetailsProvider
                            .sortPlayersByFantasyPlayerRating(_isAscending);
                      },
                      child: Container(
                        width: 80,
                        child: Center(
                          child: Row(
                            children: <Widget>[
                              Text(
                                'CREDITS',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  color: AllCoustomTheme
                                      .getBlackAndWhiteThemeColors(),
                                  fontSize: ConstanceData.SIZE_TITLE12,
                                ),
                              ),
                              _isAscending
                                  ? Icon(
                                      Icons.arrow_upward,
                                      size: 20,
                                      color: AllCoustomTheme.getThemeData()
                                          .primaryColor,
                                    )
                                  : Icon(
                                      Icons.arrow_downward,
                                      size: 20,
                                      color: AllCoustomTheme.getThemeData()
                                          .primaryColor,
                                    )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 30,
                    )
                  ],
                ),
              ),
              Divider(
                height: 1,
              )
            ],
          ),
        ),
        Consumer<GetPlayerDetailsProvider>(
          builder: (context, value, child) {
            if (value.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final playerteam = value.todos;
            if (playerteam == null) {
              return const Center(
                child: Text('No data found'),
              );
            }
            int totalPlayersCount = 0;

            playerteam.forEach((team) {
              totalPlayersCount += team.players.length;
            });
            return Expanded(
              child: ListView.builder(
                padding: EdgeInsets.only(bottom: 100),
                physics: BouncingScrollPhysics(),
                itemCount: totalPlayersCount,
                itemBuilder: (context, index) {
                  int teamIndex = 0;
                  int playerIndex = index;
                  while (playerIndex >= playerteam[teamIndex].players.length) {
                    playerIndex -= playerteam[teamIndex].players.length;
                    teamIndex++;
                  }

                  final playersWithWKRole = playerteam
                      .expand((team) => team.players)
                      .where((player) => player.playingRole == typeofplayer)
                      .toList();

                  if (index < playersWithWKRole.length) {
                    final player = playersWithWKRole[index];
                    return PlayerslistUI(
                      player: player,
                    );
                  }
                  return null;
                },
              ),
            );
          },
        ),
      ],
    );
  }
}

class PlayerslistUI extends StatelessWidget {
  final Player player;

  PlayerslistUI({
    Key? key,
    required this.player,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SelectedPlayersProvider>(
      builder: (context, value, child) {
        final isSelected = value.selectedPlayers
            .any((selectedPlayer) => selectedPlayer.pid == player.pid);

        return SizedBox(
          height: 70,
          child: Material(
            color: isSelected ? Colors.grey[300] : Colors.transparent,
            child: InkWell(
              onTap: () {
                value.addPlayer(SelectPlayer(
                  teamname: player.teamAbbr,
                  pid: player.pid,
                  shortName: player.shortName,
                  fantasyPlayerRating: player.fantasyPlayerRating.toString(),
                  playingRole: player.playingRole,
                  fantasyPlayerPoint: player.fantasyTotalPoints,
                ));
              },
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 2),
                          child: Container(
                            width: 50,
                            height: 50,
                            child: AvatarImage(
                              isProgressPrimaryColor: true,
                              isCircle: true,
                              isAssets: true,
                              imageUrl: 'assets/cricketdemoplayer.png',
                              radius: 40,
                              sizeValue: 40,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(left: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Container(
                                  child: Text(
                                    '${player.shortName}',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                      color: AllCoustomTheme
                                          .getBlackAndWhiteThemeColors(),
                                      fontSize: ConstanceData.SIZE_TITLE12,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 4),
                                  child: Text(
                                    '${player.teamAbbr ?? ''} - ${player.playingRole.toUpperCase()}',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color:
                                          AllCoustomTheme.getTextThemeColors(),
                                      fontSize: ConstanceData.SIZE_TITLE10,
                                    ),
                                  ),
                                ),
                                Consumer<Player11Provider>(
                                  builder: (context, value, child) {
                                    final playerteam = value.playing11Players;

                                    Set<String> playing11Ids = playerteam
                                        .map((player) => player.playerId)
                                        .toSet();

                                    bool isNotPlaying = !playing11Ids
                                        .contains(player.pid.toString());

                                    return playerteam.length != 0
                                        ? Column(
                                            children: [
                                              if (isNotPlaying)
                                                SizedBox()
                                              else
                                                Text(
                                                  'Playing',
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.green,
                                                    fontSize: ConstanceData
                                                        .SIZE_TITLE10,
                                                  ),
                                                ),
                                            ],
                                          )
                                        : Consumer<GetPlayerDetailsProvider>(
                                            builder: (context, value, child) {
                                              if (value.isLoading) {
                                                return const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              }

                                              final playerteam = value.todos;
                                              if (playerteam == null ||
                                                  playerteam.isEmpty) {
                                                return const Center(
                                                  child: Text('No data found'),
                                                );
                                              }

                                              final List<LastMatchPlayed>
                                                  lastMatchPlayedData = value
                                                      .lastMatchPlayed
                                                      .where((match) =>
                                                          int.parse(
                                                              match.playerId) ==
                                                          player.pid)
                                                      .toList();

                                              if (lastMatchPlayedData
                                                  .isNotEmpty) {
                                                return Column(
                                                  children: [
                                                    Text(
                                                      'Last Match Played',
                                                      style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: const Color(
                                                            0xFFB00020),
                                                        fontSize: ConstanceData
                                                            .SIZE_TITLE10,
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              } else {
                                                return Text(
                                                  '',
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    color: Colors.grey,
                                                    fontSize: ConstanceData
                                                        .SIZE_TITLE10,
                                                  ),
                                                );
                                              }
                                            },
                                          );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: 100,
                          child: Center(
                            child: Text(
                              '${player.fantasyTotalPoints}',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: AllCoustomTheme.getTextThemeColors(),
                                fontSize: ConstanceData.SIZE_TITLE12,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 40,
                          child: Text(
                            '${player.fantasyPlayerRating}',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.bold,
                              color:
                                  AllCoustomTheme.getBlackAndWhiteThemeColors(),
                              fontSize: ConstanceData.SIZE_TITLE12,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 8, bottom: 8),
                          width: 0.4,
                          child: Container(
                            color: AllCoustomTheme.getTextThemeColors()
                                .withOpacity(0.5),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(right: 8),
                          child: Center(
                            child: Container(
                              width: 40,
                              child: Icon(
                                isSelected ? Icons.cancel_outlined : Icons.add,
                                color: Colors.red,
                              ),
                            ),
                          ),
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
          ),
        );
      },
    );
  }
}

class TabTextView extends StatelessWidget {
  final TabTextType? tabTextType;
  final bool? isSelected;
  final int? count;

  const TabTextView({
    Key? key,
    this.tabTextType,
    this.count = 0,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              child: Text(
                tabTextType == TabTextType.wk
                    ? "WK"
                    : tabTextType == TabTextType.bat
                        ? "BAT"
                        : tabTextType == TabTextType.ar
                            ? "AR"
                            : tabTextType == TabTextType.bowl
                                ? "BOWL"
                                : '',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  color: isSelected!
                      ? AllCoustomTheme.getBlackAndWhiteThemeColors()
                      : AllCoustomTheme.getTextThemeColors(),
                  fontSize: ConstanceData.SIZE_TITLE14,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(bottom: 2),
              child: Text(
                ' ($count)',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.bold,
                  color: isSelected!
                      ? AllCoustomTheme.getBlackAndWhiteThemeColors()
                      : AllCoustomTheme.getTextThemeColors(),
                  fontSize: ConstanceData.SIZE_TITLE10,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

enum TabTextType { wk, bat, ar, bowl }
