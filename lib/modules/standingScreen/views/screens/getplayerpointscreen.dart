import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tempalteflutter/constance/themes.dart';
import 'package:tempalteflutter/modules/standingScreen/domain/completedmatchmodel.dart';
import 'package:tempalteflutter/modules/standingScreen/domain/getfantasyplayerpoint.dart';
import 'package:tempalteflutter/modules/standingScreen/domain/livematchmodel.dart';
import 'package:tempalteflutter/modules/standingScreen/views/provider/fantasyplayerointprovider.dart';
import 'package:tempalteflutter/utils/avatarImage.dart';

class PlayerPointScreen extends StatefulWidget {
  List<PlayersPoint> playersPoints;
  int cap = 0;
  int vicecap = 0;

  PlayerPointScreen(
      {super.key,
      required this.playersPoints,
      required this.cap,
      required this.vicecap});

  @override
  State<PlayerPointScreen> createState() => _PlayerPointScreenState();
}

class _PlayerPointScreenState extends State<PlayerPointScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<GetFantasyPlayerPointProvider>(context, listen: false)
          .getplayerpoint();
      print('-------------------------------------------');
      print(widget.cap);
      print(widget.vicecap);
      print('-------------------------------------------');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
        title: Text(
          'Player Points',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
            )),
      ),
      body: Consumer<GetFantasyPlayerPointProvider>(
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

          List<Playing11> teamAPlayers =
              upcoming.response.points.teama.playing11;
          List<Playing11> teamBPlayers =
              upcoming.response.points.teamb.playing11;

          List<Playing11> allPlayers = [...teamAPlayers, ...teamBPlayers];

          List<int> allPlayersPoints =
              widget.playersPoints.map((point) => point.players).toList();

          List<Playing11> filteredPlayers = allPlayers.where((player) {
            return allPlayersPoints.toString().contains(player.pid);
          }).toList();

          double total = 0;

          filteredPlayers.forEach((player) {
            int playerPoints = int.tryParse(player.point) ?? 0;

            if (int.parse(player.pid) == widget.cap) {
              total += playerPoints * 2;
            } else if (int.parse(player.pid) == widget.vicecap) {
              total += playerPoints * 1.5;
            } else {
              total += playerPoints;
            }
          });

          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total Points',
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        total.round().toString(),
                        style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: filteredPlayers.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    print(filteredPlayers[index].pid);
                    return Padding(
                      padding:
                          const EdgeInsets.only(left: 10, right: 20, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.only(left: 2),
                                    child: Container(
                                      width: 50,
                                      height: 50,
                                      child: AvatarImage(
                                        isProgressPrimaryColor: true,
                                        isCircle: true,
                                        isAssets: true,
                                        imageUrl:
                                            'assets/cricketdemoplayer.png',
                                        radius: 40,
                                        sizeValue: 40,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        filteredPlayers[index].name,
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontWeight: FontWeight.w600),
                                      ),
                                      int.parse(filteredPlayers[index].pid) ==
                                              widget.cap
                                          ? Text(
                                              ' (C)',
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w600),
                                            )
                                          : SizedBox(),
                                      int.parse(filteredPlayers[index].pid) ==
                                              widget.vicecap
                                          ? Text(
                                              ' (VC)',
                                              style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontWeight: FontWeight.w600),
                                            )
                                          : SizedBox(),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              int.parse(filteredPlayers[index].pid) ==
                                      widget.cap
                                  ? Text(
                                      '  ${int.parse(filteredPlayers[index].point) * 2}',
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600),
                                    )
                                  : SizedBox(),
                              int.parse(filteredPlayers[index].pid) ==
                                      widget.vicecap
                                  ? Text(
                                      '  ${int.parse(filteredPlayers[index].point) * 1.5}',
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600),
                                    )
                                  : SizedBox(),
                              (int.parse(filteredPlayers[index].pid) ==
                                          widget.vicecap ||
                                      int.parse(filteredPlayers[index].pid) ==
                                          widget.cap)
                                  ? SizedBox()
                                  : Text(
                                      filteredPlayers[index].point,
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class PlayerPointScreenComplete extends StatefulWidget {
  List<PlayersPointComplete> playersPoints;
  int cap = 0;
  int vicecap = 0;

  PlayerPointScreenComplete(
      {super.key,
      required this.playersPoints,
      required this.cap,
      required this.vicecap});

  @override
  State<PlayerPointScreenComplete> createState() =>
      _PlayerPointScreenCompleteState();
}

class _PlayerPointScreenCompleteState extends State<PlayerPointScreenComplete> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<GetFantasyPlayerPointProvider>(context, listen: false)
          .getplayerpoint();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
        title: Text(
          'Player Points',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
            )),
      ),
      body: Consumer<GetFantasyPlayerPointProvider>(
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

          List<Playing11> teamAPlayers =
              upcoming.response.points.teama.playing11;
          List<Playing11> teamBPlayers =
              upcoming.response.points.teamb.playing11;

          List<Playing11> allPlayers = [...teamAPlayers, ...teamBPlayers];

          List<int> allPlayersPoints =
              widget.playersPoints.map((point) => point.players).toList();

          List<Playing11> filteredPlayers = allPlayers.where((player) {
            return allPlayersPoints.toString().contains(player.pid);
          }).toList();

          double total = 0;

          filteredPlayers.forEach((player) {
            int playerPoints = int.tryParse(player.point) ?? 0;

            if (int.parse(player.pid) == widget.cap) {
              total += playerPoints * 2;
            } else if (int.parse(player.pid) == widget.vicecap) {
              total += playerPoints * 1.5;
            } else {
              total += playerPoints;
            }
          });
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Points',
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                    Text(
                      total.toString(),
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
              ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: widget.playersPoints.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final todo = widget.playersPoints[index];
                  return Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 20, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Row(
                              children: [
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
                                Row(
                                  children: [
                                    Text(
                                      todo.name ?? '',
                                      style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontWeight: FontWeight.w600),
                                    ),
                                    todo.players == widget.cap
                                        ? Text(
                                            ' (C)',
                                            style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w600),
                                          )
                                        : SizedBox(),
                                    todo.players == widget.vicecap
                                        ? Text(
                                            ' (VC)',
                                            style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontWeight: FontWeight.w600),
                                          )
                                        : SizedBox(),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            todo.players ==
                                widget.cap
                                ? Text(
                              '  ${todo.points.round() * 2}',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600),
                            )
                                : SizedBox(),
                            todo.players ==
                                widget.vicecap
                                ? Text(
                              '  ${todo.points.round() * 1.5}',
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600),
                            )
                                : SizedBox(),
                            (todo.players ==
                                widget.vicecap ||
                                todo.players ==
                                    widget.cap)
                                ? SizedBox()
                                : Text(
                              todo.points.toString(),
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
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
