// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:tempalteflutter/constance/constance.dart';
import 'package:tempalteflutter/constance/themes.dart';
import 'package:tempalteflutter/modules/contests/views/screens/contestsScreen.dart';
import 'package:tempalteflutter/modules/result/resultContest.dart';
import 'package:tempalteflutter/modules/standingScreen/domain/completedmatchmodel.dart';
import 'package:tempalteflutter/modules/standingScreen/domain/getfantasyplayerpoint.dart';
import 'package:tempalteflutter/modules/standingScreen/domain/livematchmodel.dart';
import 'package:tempalteflutter/modules/standingScreen/views/provider/fantasyplayerointprovider.dart';
import 'package:tempalteflutter/modules/standingScreen/views/screens/getplayerpointscreen.dart';
import 'package:tempalteflutter/utils/avatarImage.dart';
import 'package:tempalteflutter/validator/validator.dart';

import '../standingScreen/domain/upcomingmatchmodel.dart';

class StandingResult extends StatefulWidget {
  final String? titel;
  final String? country1Name;
  final String? country1Flag;
  final String? country2Name;
  final String? country2Flag;
  final String? time;
  final String? price;
  String entryprize;
  int maxuser;
  List<WinLevel> winLevels;
  List<Participant> participants;

  StandingResult(
      {Key? key,
      this.titel,
      this.country1Name,
      this.country1Flag,
      this.country2Name,
      this.country2Flag,
      this.time,
      this.price,
      required this.winLevels,
      required this.participants,
      required this.entryprize,
      required this.maxuser})
      : super(key: key);
  @override
  _StandingResultState createState() => _StandingResultState();
}

class _StandingResultState extends State<StandingResult>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    controller = new TabController(length: 2, vsync: this);
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
        appBar: AppBar(
          elevation: 0,
          backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
          title: Text(
            "Joined Contests",
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            MatchHadder(
              country1Flag: widget.country1Flag,
              country2Flag: widget.country2Flag,
              country1Name: widget.country1Name,
              country2Name: widget.country2Name,
              price: widget.price,
              time: widget.time,
              titel: widget.titel,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 8, right: 8, top: 4),
                child: Column(
                  children: <Widget>[
                    // Row(
                    //   children: <Widget>[
                    //     Text(
                    //       "SCORECARD",
                    //       style: TextStyle(
                    //         fontFamily: 'Poppins',
                    //         color: HexColor(
                    //           '#AAAFBC',
                    //         ),
                    //         fontSize: 14,
                    //       ),
                    //     )
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: 8,
                    // ),
                    // Row(
                    //   children: <Widget>[
                    //     Text(
                    //       "${widget.country1Name}  213-10",
                    //       style: TextStyle(
                    //         fontFamily: 'Poppins',
                    //         fontSize: 14,
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    //     ),
                    //     Text(
                    //       " (49.5)",
                    //       style: TextStyle(
                    //         fontFamily: 'Poppins',
                    //         fontSize: 14,
                    //         fontWeight: FontWeight.bold,
                    //         color: HexColor(
                    //           '#AAAFBC',
                    //         ),
                    //       ),
                    //     ),
                    //     SizedBox(
                    //       width: 10,
                    //     ),
                    //     Text('|'),
                    //     SizedBox(
                    //       width: 10,
                    //     ),
                    //     Text(
                    //       "${widget.country2Name}    224-8",
                    //       style: TextStyle(
                    //         fontFamily: 'Poppins',
                    //         fontSize: 14,
                    //         fontWeight: FontWeight.bold,
                    //       ),
                    //     ),
                    //     Text(
                    //       "  (50)",
                    //       style: TextStyle(
                    //         fontFamily: 'Poppins',
                    //         fontSize: 14,
                    //         fontWeight: FontWeight.bold,
                    //         color: HexColor(
                    //           '#AAAFBC',
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    // SizedBox(
                    //   height: 8,
                    // ),
                    // Row(
                    //   children: <Widget>[
                    //     Text(
                    //       'India won by 11 runs',
                    //       style: TextStyle(
                    //         fontFamily: 'Poppins',
                    //         fontSize: 14,
                    //         color: HexColor(
                    //           '#AAAFBC',
                    //         ),
                    //       ),
                    //     )
                    //   ],
                    // ),
                    Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              pageController.jumpToPage(0);
                            });
                          },
                          child: Text(
                            "Player Points",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              color: pageNumber == 0
                                  ? Theme.of(context).primaryColor
                                  : HexColor(
                                      '#AAAFBC',
                                    ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              pageController.jumpToPage(1);
                            });
                          },
                          child: Text(
                            "Contest",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 16,
                              color: pageNumber == 1
                                  ? Theme.of(context).primaryColor
                                  : HexColor(
                                      '#AAAFBC',
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(),
                    Expanded(
                      child: PageView(
                        controller: pageController,
                        onPageChanged: (number) {
                          setState(() {
                            pageNumber = number;
                          });
                        },
                        children: [
                          // playerPoint(),
                          SizedBox(),
                          contest(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget contest() {
    int spotleft = widget.maxuser - widget.participants.length;
    double progress = widget.participants.length / widget.maxuser;
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: <Widget>[
        Column(
          children: <Widget>[
            Card(
              color: Colors.white,
              elevation: 10,
              child: Container(
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, top: 4),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                'Prize Pool',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: HexColor(
                                    '#AAAFBC',
                                  ),
                                  fontSize: ConstanceData.SIZE_TITLE14,
                                ),
                              ),
                              Text(
                                '₹${widget.price}',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: ConstanceData.SIZE_TITLE20,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                          // Column(
                          //   children: <Widget>[
                          //     Text(
                          //       'Winner',
                          //       style: TextStyle(
                          //         fontFamily: 'Poppins',
                          //         color: HexColor(
                          //           '#AAAFBC',
                          //         ),
                          //         fontSize: ConstanceData.SIZE_TITLE14,
                          //       ),
                          //     ),
                          //     Text(
                          //       '1',
                          //       style: TextStyle(
                          //         fontFamily: 'Poppins',
                          //         // color: HexColor(
                          //         //   '#AAAFBC',
                          //         // ),
                          //         fontSize: ConstanceData.SIZE_TITLE14,
                          //       ),
                          //     )
                          //   ],
                          // ),
                          Column(
                            children: <Widget>[
                              Text(
                                'Entry',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: HexColor(
                                    '#AAAFBC',
                                  ),
                                  fontSize: ConstanceData.SIZE_TITLE14,
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                // color: Color(0xFF064475),
                                width: 50,
                                child: Text(
                                  '₹${widget.entryprize}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      LinearPercentIndicator(
                        lineHeight: 6,
                        percent: progress,
                        linearStrokeCap: LinearStrokeCap.roundAll,
                        backgroundColor: AllCoustomTheme.getThemeData()
                            .scaffoldBackgroundColor,
                        progressColor:
                            AllCoustomTheme.getThemeData().primaryColor,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '$spotleft spots left',
                            style: TextStyle(color: Colors.red),
                          ),
                          Text(
                            '${widget.participants.length} spots',
                            style: TextStyle(color: Colors.red),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Flexible(
              child: Container(
                child: contestsListData(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  ScrollController _scrollController = new ScrollController();
  TabController? controller;
  final PageController pageController = PageController(initialPage: 0);

  Widget contestsListData() {
    return NestedScrollView(
      controller: _scrollController,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverPersistentHeader(
            pinned: true,
            delegate: ContestTabHeader(controller!),
          ),
        ];
      },
      body: TabBarView(
        controller: controller,
        children: <Widget>[
          dowunloadbar(),
          ListView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount: widget.winLevels.length,
            itemBuilder: (context, index) {
              final todo = widget.winLevels[index];
              return Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10, top: 4, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '# ${todo.position}',
                        ),
                        Text(
                          '₹ ${todo.percentage}',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: AllCoustomTheme.getTextThemeColors(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget dowunloadbar() {
    return Column(
      children: <Widget>[
        // Container(
        //   height: 50,
        //   color: AllCoustomTheme.getTextThemeColors().withOpacity(0.1),
        //   child: Container(
        //     padding: EdgeInsets.only(left: 10, top: 10, right: 10),
        //     child: Row(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: <Widget>[
        //         Text(
        //           'view all teams \nafter the deadline',
        //           style: TextStyle(
        //             fontFamily: 'Poppins',
        //             fontSize: ConstanceData.SIZE_TITLE12,
        //             color: AllCoustomTheme.getTextThemeColors(),
        //           ),
        //         ),
        //         Container(
        //           child: Opacity(
        //             opacity: 0.6,
        //             child: Container(
        //               width: 150,
        //               height: 24,
        //               decoration: BoxDecoration(
        //                 color: AllCoustomTheme.getThemeData().backgroundColor,
        //                 borderRadius: new BorderRadius.circular(4.0),
        //                 boxShadow: <BoxShadow>[
        //                   BoxShadow(
        //                       color:
        //                           AllCoustomTheme.getBlackAndWhiteThemeColors()
        //                               .withOpacity(0.3),
        //                       offset: Offset(0, 1),
        //                       blurRadius: 5.0),
        //                 ],
        //               ),
        //               child: Material(
        //                 color: Colors.transparent,
        //                 child: Row(
        //                   mainAxisSize: MainAxisSize.max,
        //                   crossAxisAlignment: CrossAxisAlignment.center,
        //                   mainAxisAlignment: MainAxisAlignment.center,
        //                   children: <Widget>[
        //                     Container(
        //                       child: Text(
        //                         'Download Teams ',
        //                         style: TextStyle(
        //                             fontFamily: 'Poppins',
        //                             fontSize: ConstanceData.SIZE_TITLE10,
        //                             color:
        //                                 AllCoustomTheme.getTextThemeColors()),
        //                       ),
        //                     ),
        //                     Container(
        //                       padding: EdgeInsets.only(top: 2),
        //                       child: Icon(
        //                         Icons.file_download,
        //                         color: AllCoustomTheme.getTextThemeColors(),
        //                         size: 14,
        //                       ),
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        Container(
          padding: EdgeInsets.only(left: 15, top: 10, right: 15),
          child: Row(
            children: <Widget>[
              Text(
                'All Teams (${widget.participants.length})',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: AllCoustomTheme.getTextThemeColors(),
                ),
              ),
            ],
          ),
        ),
        Divider(),
        widget.participants.length == 0
            ? Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: <Widget>[
                      Text(
                        'No team has joined this contest yet',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: AllCoustomTheme.getTextThemeColors(),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        child: Image.asset(ConstanceData.users),
                      ),
                      Container(
                        child: Text(
                          'Be the first one to join this contest & start winning!',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: ConstanceData.SIZE_TITLE14,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
              )
            : ListView.builder(
                itemCount: widget.participants.length,
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final todo = widget.participants[index];
                  return Row(
                    children: [
                      todo.user.image == null
                          ? Container(
                              height: 44,
                              width: 44,
                              margin: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.grey)),
                              child: Icon(Icons.person),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(todo.user.image),
                              ),
                            ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        todo.user.fullName ?? '',
                        style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
                      )
                    ],
                  );
                },
              )
      ],
    );
  }

  Widget playerPoint() {
    return Column(
      children: [
        Container(
          height: 24,
          child: Padding(
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Players",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: ConstanceData.SIZE_TITLE12,
                    color: HexColor(
                      '#AAAFBC',
                    ),
                  ),
                ),
                Text(
                  'POINTS',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: ConstanceData.SIZE_TITLE12,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(0),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 14),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          child: AvatarImage(
                            isProgressPrimaryColor: true,
                            isCircle: true,
                            isAssets: true,
                            imageUrl: 'assets/cname/8.png',
                            radius: 50,
                            sizeValue: 50,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Faf du Plessis',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.green),
                              child: Icon(
                                Icons.done,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Text(
                            '58.0',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          child: AvatarImage(
                            isProgressPrimaryColor: true,
                            isCircle: true,
                            isAssets: true,
                            imageUrl: 'assets/cname/11.png',
                            radius: 50,
                            sizeValue: 50,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Quinton de Kock',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.green),
                              child: Icon(
                                Icons.done,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Text(
                            '20.0',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          child: AvatarImage(
                            isProgressPrimaryColor: true,
                            isCircle: true,
                            isAssets: true,
                            imageUrl: 'assets/cname/115.png',
                            radius: 50,
                            sizeValue: 50,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Rohit Sharma',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.green),
                              child: Icon(
                                Icons.done,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Text(
                            '101.0',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          child: AvatarImage(
                            isProgressPrimaryColor: true,
                            isCircle: true,
                            isAssets: true,
                            imageUrl: 'assets/cname/117.png',
                            radius: 50,
                            sizeValue: 50,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Shikhar Dhavan',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.green),
                              child: Icon(
                                Icons.done,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Text(
                            '200.3',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          child: AvatarImage(
                            isProgressPrimaryColor: true,
                            isCircle: true,
                            isAssets: true,
                            imageUrl: 'assets/cname/119.png',
                            radius: 50,
                            sizeValue: 50,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Virat Kohali',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.green),
                              child: Icon(
                                Icons.done,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Text(
                            '195.0',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          child: AvatarImage(
                            isProgressPrimaryColor: true,
                            isCircle: true,
                            isAssets: true,
                            imageUrl: 'assets/cname/123.png',
                            radius: 50,
                            sizeValue: 50,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'MS Dhoni',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.green),
                              child: Icon(
                                Icons.done,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Text(
                            '137.0',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          child: AvatarImage(
                            isProgressPrimaryColor: true,
                            isCircle: true,
                            isAssets: true,
                            imageUrl: 'assets/cname/131.png',
                            radius: 50,
                            sizeValue: 50,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Shami',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.green),
                              child: Icon(
                                Icons.done,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Text(
                            '452.0',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          child: AvatarImage(
                            isProgressPrimaryColor: true,
                            isCircle: true,
                            isAssets: true,
                            imageUrl: 'assets/cname/159.png',
                            radius: 50,
                            sizeValue: 50,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Quinton de Kock',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.green),
                              child: Icon(
                                Icons.done,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Text(
                            '136.0',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          child: AvatarImage(
                            isProgressPrimaryColor: true,
                            isCircle: true,
                            isAssets: true,
                            imageUrl: 'assets/cname/161.png',
                            radius: 50,
                            sizeValue: 50,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'hashim Amla',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.green),
                              child: Icon(
                                Icons.done,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Text(
                            '364.0',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          child: AvatarImage(
                            isProgressPrimaryColor: true,
                            isCircle: true,
                            isAssets: true,
                            imageUrl: 'assets/cname/163.png',
                            radius: 50,
                            sizeValue: 50,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Fat du Plessis',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.green),
                              child: Icon(
                                Icons.done,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Text(
                            '108.0',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          child: AvatarImage(
                            isProgressPrimaryColor: true,
                            isCircle: true,
                            isAssets: true,
                            imageUrl: 'assets/cname/167.png',
                            radius: 50,
                            sizeValue: 50,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Lungi Ngidi',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.green),
                              child: Icon(
                                Icons.done,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Text(
                            '95.0',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          child: AvatarImage(
                            isProgressPrimaryColor: true,
                            isCircle: true,
                            isAssets: true,
                            imageUrl: 'assets/cname/175.png',
                            radius: 50,
                            sizeValue: 50,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Dale Steyn',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.green),
                              child: Icon(
                                Icons.done,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Text(
                            '203.0',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    SizedBox(
                      height: 70,
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  int pageNumber = 0;
}

class StandingResultUcoming extends StatefulWidget {
  final String? titel;
  final String? country1Name;
  final String? country1Flag;
  final String? country2Name;
  final String? country2Flag;
  final String? time;
  final String? price;
  String entryprize;
  int maxuser;
  List<WinLevel> winLevels;
  List<Participant> participants;

  StandingResultUcoming(
      {Key? key,
      this.titel,
      this.country1Name,
      this.country1Flag,
      this.country2Name,
      this.country2Flag,
      this.time,
      this.price,
      required this.winLevels,
      required this.participants,
      required this.entryprize,
      required this.maxuser})
      : super(key: key);
  @override
  _StandingResultUcomingState createState() => _StandingResultUcomingState();
}

class _StandingResultUcomingState extends State<StandingResultUcoming>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    controller = new TabController(length: 2, vsync: this);
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
        appBar: AppBar(
          elevation: 0,
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
          title: Text(
            "Joined Contests",
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            MatchHadder(
              country1Flag: widget.country1Flag,
              country2Flag: widget.country2Flag,
              country1Name: widget.country1Name,
              country2Name: widget.country2Name,
              price: widget.price,
              time: widget.time,
              titel: widget.titel,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 8, right: 8, top: 4),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: contest(),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget contest() {
    int spotleft = widget.maxuser - widget.participants.length;
    double progress = widget.participants.length / widget.maxuser;
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: <Widget>[
        Column(
          children: <Widget>[
            Card(
              color: Colors.white,
              elevation: 10,
              child: Container(
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, top: 4),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                'Prize Pool',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: HexColor(
                                    '#AAAFBC',
                                  ),
                                  fontSize: ConstanceData.SIZE_TITLE14,
                                ),
                              ),
                              Text(
                                '₹${widget.price}',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: ConstanceData.SIZE_TITLE20,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                          // Column(
                          //   children: <Widget>[
                          //     Text(
                          //       'Winner',
                          //       style: TextStyle(
                          //         fontFamily: 'Poppins',
                          //         color: HexColor(
                          //           '#AAAFBC',
                          //         ),
                          //         fontSize: ConstanceData.SIZE_TITLE14,
                          //       ),
                          //     ),
                          //     Text(
                          //       '1',
                          //       style: TextStyle(
                          //         fontFamily: 'Poppins',
                          //         // color: HexColor(
                          //         //   '#AAAFBC',
                          //         // ),
                          //         fontSize: ConstanceData.SIZE_TITLE14,
                          //       ),
                          //     )
                          //   ],
                          // ),
                          Column(
                            children: <Widget>[
                              Text(
                                'Entry',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: HexColor(
                                    '#AAAFBC',
                                  ),
                                  fontSize: ConstanceData.SIZE_TITLE14,
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                // color: Color(0xFF064475),
                                width: 50,
                                child: Text(
                                  '₹${widget.entryprize}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      LinearPercentIndicator(
                        lineHeight: 6,
                        percent: progress,
                        linearStrokeCap: LinearStrokeCap.roundAll,
                        backgroundColor: AllCoustomTheme.getThemeData()
                            .scaffoldBackgroundColor,
                        progressColor:
                            AllCoustomTheme.getThemeData().primaryColor,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '$spotleft spots left',
                            style: TextStyle(color: Colors.red),
                          ),
                          Text(
                            '${widget.participants.length} spots',
                            style: TextStyle(color: Colors.red),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Flexible(
              child: Container(
                child: contestsListData(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  ScrollController _scrollController = new ScrollController();
  TabController? controller;
  final PageController pageController = PageController(initialPage: 0);

  Widget contestsListData() {
    return NestedScrollView(
      controller: _scrollController,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverPersistentHeader(
            pinned: true,
            delegate: ContestTabHeader(controller!),
          ),
        ];
      },
      body: TabBarView(
        controller: controller,
        children: <Widget>[
          dowunloadbar(),
          ListView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount: widget.winLevels.length,
            itemBuilder: (context, index) {
              final todo = widget.winLevels[index];
              double price = double.parse(widget.price.toString());
              double distributionAmount = (todo.percentage / 100) * price;
              String formattedAmount = distributionAmount
                  .toStringAsFixed(2)
                  .replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), "");
              return Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10, top: 4, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '# ${todo.position}',
                        ),
                        Text(
                          '₹ $formattedAmount',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: AllCoustomTheme.getTextThemeColors(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget dowunloadbar() {
    return Column(
      children: <Widget>[
        // Container(
        //   height: 50,
        //   color: AllCoustomTheme.getTextThemeColors().withOpacity(0.1),
        //   child: Container(
        //     padding: EdgeInsets.only(left: 10, top: 10, right: 10),
        //     child: Row(
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       children: <Widget>[
        //         Text(
        //           'view all teams \nafter the deadline',
        //           style: TextStyle(
        //             fontFamily: 'Poppins',
        //             fontSize: ConstanceData.SIZE_TITLE12,
        //             color: AllCoustomTheme.getTextThemeColors(),
        //           ),
        //         ),
        //         Container(
        //           child: Opacity(
        //             opacity: 0.6,
        //             child: Container(
        //               width: 150,
        //               height: 24,
        //               decoration: BoxDecoration(
        //                 color: AllCoustomTheme.getThemeData().backgroundColor,
        //                 borderRadius: new BorderRadius.circular(4.0),
        //                 boxShadow: <BoxShadow>[
        //                   BoxShadow(
        //                       color:
        //                           AllCoustomTheme.getBlackAndWhiteThemeColors()
        //                               .withOpacity(0.3),
        //                       offset: Offset(0, 1),
        //                       blurRadius: 5.0),
        //                 ],
        //               ),
        //               child: Material(
        //                 color: Colors.transparent,
        //                 child: Row(
        //                   mainAxisSize: MainAxisSize.max,
        //                   crossAxisAlignment: CrossAxisAlignment.center,
        //                   mainAxisAlignment: MainAxisAlignment.center,
        //                   children: <Widget>[
        //                     Container(
        //                       child: Text(
        //                         'Download Teams ',
        //                         style: TextStyle(
        //                             fontFamily: 'Poppins',
        //                             fontSize: ConstanceData.SIZE_TITLE10,
        //                             color:
        //                                 AllCoustomTheme.getTextThemeColors()),
        //                       ),
        //                     ),
        //                     Container(
        //                       padding: EdgeInsets.only(top: 2),
        //                       child: Icon(
        //                         Icons.file_download,
        //                         color: AllCoustomTheme.getTextThemeColors(),
        //                         size: 14,
        //                       ),
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //             ),
        //           ),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        Container(
          padding: EdgeInsets.only(left: 15, top: 10, right: 15),
          child: Row(
            children: <Widget>[
              Text(
                'All Teams (${widget.participants.length})',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: AllCoustomTheme.getTextThemeColors(),
                ),
              ),
            ],
          ),
        ),
        Divider(),
        widget.participants.length == 0
            ? Expanded(
                child: Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    children: <Widget>[
                      Text(
                        'No team has joined this contest yet',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: AllCoustomTheme.getTextThemeColors(),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        width: 100,
                        height: 100,
                        child: Image.asset(ConstanceData.users),
                      ),
                      Container(
                        child: Text(
                          'Be the first one to join this contest & start winning!',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: ConstanceData.SIZE_TITLE14,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
              )
            : ListView.builder(
                itemCount: widget.participants.length,
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final todo = widget.participants[index];
                  return Row(
                    children: [
                      todo.user.image == null
                          ? Container(
                              height: 44,
                              width: 44,
                              margin: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.grey)),
                              child: Icon(Icons.person),
                            )
                          : Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 20,
                                backgroundImage: NetworkImage(todo.user.image),
                              ),
                            ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        todo.user.fullName ?? '',
                        style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
                      )
                    ],
                  );
                },
              )
      ],
    );
  }

  Widget playerPoint() {
    return Column(
      children: [
        Container(
          height: 24,
          child: Padding(
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Players",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: ConstanceData.SIZE_TITLE12,
                    color: HexColor(
                      '#AAAFBC',
                    ),
                  ),
                ),
                Text(
                  'POINTS',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: ConstanceData.SIZE_TITLE12,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(0),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 14),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          child: AvatarImage(
                            isProgressPrimaryColor: true,
                            isCircle: true,
                            isAssets: true,
                            imageUrl: 'assets/cname/8.png',
                            radius: 50,
                            sizeValue: 50,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Faf du Plessis',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.green),
                              child: Icon(
                                Icons.done,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Text(
                            '58.0',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          child: AvatarImage(
                            isProgressPrimaryColor: true,
                            isCircle: true,
                            isAssets: true,
                            imageUrl: 'assets/cname/11.png',
                            radius: 50,
                            sizeValue: 50,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Quinton de Kock',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.green),
                              child: Icon(
                                Icons.done,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Text(
                            '20.0',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          child: AvatarImage(
                            isProgressPrimaryColor: true,
                            isCircle: true,
                            isAssets: true,
                            imageUrl: 'assets/cname/115.png',
                            radius: 50,
                            sizeValue: 50,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Rohit Sharma',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.green),
                              child: Icon(
                                Icons.done,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Text(
                            '101.0',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          child: AvatarImage(
                            isProgressPrimaryColor: true,
                            isCircle: true,
                            isAssets: true,
                            imageUrl: 'assets/cname/117.png',
                            radius: 50,
                            sizeValue: 50,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Shikhar Dhavan',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.green),
                              child: Icon(
                                Icons.done,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Text(
                            '200.3',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          child: AvatarImage(
                            isProgressPrimaryColor: true,
                            isCircle: true,
                            isAssets: true,
                            imageUrl: 'assets/cname/119.png',
                            radius: 50,
                            sizeValue: 50,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Virat Kohali',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.green),
                              child: Icon(
                                Icons.done,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Text(
                            '195.0',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          child: AvatarImage(
                            isProgressPrimaryColor: true,
                            isCircle: true,
                            isAssets: true,
                            imageUrl: 'assets/cname/123.png',
                            radius: 50,
                            sizeValue: 50,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'MS Dhoni',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.green),
                              child: Icon(
                                Icons.done,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Text(
                            '137.0',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          child: AvatarImage(
                            isProgressPrimaryColor: true,
                            isCircle: true,
                            isAssets: true,
                            imageUrl: 'assets/cname/131.png',
                            radius: 50,
                            sizeValue: 50,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Shami',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.green),
                              child: Icon(
                                Icons.done,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Text(
                            '452.0',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          child: AvatarImage(
                            isProgressPrimaryColor: true,
                            isCircle: true,
                            isAssets: true,
                            imageUrl: 'assets/cname/159.png',
                            radius: 50,
                            sizeValue: 50,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Quinton de Kock',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.green),
                              child: Icon(
                                Icons.done,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Text(
                            '136.0',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          child: AvatarImage(
                            isProgressPrimaryColor: true,
                            isCircle: true,
                            isAssets: true,
                            imageUrl: 'assets/cname/161.png',
                            radius: 50,
                            sizeValue: 50,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'hashim Amla',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.green),
                              child: Icon(
                                Icons.done,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Text(
                            '364.0',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          child: AvatarImage(
                            isProgressPrimaryColor: true,
                            isCircle: true,
                            isAssets: true,
                            imageUrl: 'assets/cname/163.png',
                            radius: 50,
                            sizeValue: 50,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Fat du Plessis',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.green),
                              child: Icon(
                                Icons.done,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Text(
                            '108.0',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          child: AvatarImage(
                            isProgressPrimaryColor: true,
                            isCircle: true,
                            isAssets: true,
                            imageUrl: 'assets/cname/167.png',
                            radius: 50,
                            sizeValue: 50,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Lungi Ngidi',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.green),
                              child: Icon(
                                Icons.done,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Text(
                            '95.0',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          child: AvatarImage(
                            isProgressPrimaryColor: true,
                            isCircle: true,
                            isAssets: true,
                            imageUrl: 'assets/cname/175.png',
                            radius: 50,
                            sizeValue: 50,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Dale Steyn',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.green),
                              child: Icon(
                                Icons.done,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Text(
                            '203.0',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    SizedBox(
                      height: 70,
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  int pageNumber = 0;
}

class StandingResultLive extends StatefulWidget {
  final String? titel;
  final String? country1Name;
  final String? country1Flag;
  final String? country2Name;
  final String? country2Flag;
  final String? time;
  final String? price;
  String entryprize;
  int maxuser;
  List<PlayersPoint> playersPoints;
  List<WinLevels> winLevels;
  List<Participants> participants;

  StandingResultLive(
      {Key? key,
      this.titel,
      this.country1Name,
      this.country1Flag,
      this.country2Name,
      this.country2Flag,
      this.time,
      this.price,
      required this.playersPoints,
      required this.winLevels,
      required this.participants,
      required this.entryprize,
      required this.maxuser})
      : super(key: key);
  @override
  _StandingResultLiveState createState() => _StandingResultLiveState();
}

class _StandingResultLiveState extends State<StandingResultLive>
    with SingleTickerProviderStateMixin {


  @override
  void initState() {
    controller = new TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<GetFantasyPlayerPointProvider>(context, listen: false)
          .getplayerpoint();
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
        appBar: AppBar(
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          elevation: 0,
          backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
          title: Text(
            "Joined Contests",
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            MatchHadder(
              country1Flag: widget.country1Flag,
              country2Flag: widget.country2Flag,
              country1Name: widget.country1Name,
              country2Name: widget.country2Name,
              price: widget.price,
              time: widget.time,
              titel: widget.titel,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 8, right: 8, top: 4),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: contest(),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget contest() {
    int spotleft = widget.maxuser - widget.participants.length;
    double progress = widget.participants.length / widget.maxuser;
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: <Widget>[
        Column(
          children: <Widget>[
            Card(
              color: Colors.white,
              elevation: 10,
              child: Container(
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, top: 4),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                'Prize Pool',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: HexColor(
                                    '#AAAFBC',
                                  ),
                                  fontSize: ConstanceData.SIZE_TITLE14,
                                ),
                              ),
                              Text(
                                '₹${widget.price}',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: ConstanceData.SIZE_TITLE20,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                          // Column(
                          //   children: <Widget>[
                          //     Text(
                          //       'Winner',
                          //       style: TextStyle(
                          //         fontFamily: 'Poppins',
                          //         color: HexColor(
                          //           '#AAAFBC',
                          //         ),
                          //         fontSize: ConstanceData.SIZE_TITLE14,
                          //       ),
                          //     ),
                          //     Text(
                          //       '1',
                          //       style: TextStyle(
                          //         fontFamily: 'Poppins',
                          //         // color: HexColor(
                          //         //   '#AAAFBC',
                          //         // ),
                          //         fontSize: ConstanceData.SIZE_TITLE14,
                          //       ),
                          //     )
                          //   ],
                          // ),
                          Column(
                            children: <Widget>[
                              Text(
                                'Entry',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: HexColor(
                                    '#AAAFBC',
                                  ),
                                  fontSize: ConstanceData.SIZE_TITLE14,
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                // color: Color(0xFF064475),
                                width: 50,
                                child: Text(
                                  '₹${widget.entryprize}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      LinearPercentIndicator(
                        lineHeight: 6,
                        percent: progress,
                        linearStrokeCap: LinearStrokeCap.roundAll,
                        backgroundColor: AllCoustomTheme.getThemeData()
                            .scaffoldBackgroundColor,
                        progressColor:
                            AllCoustomTheme.getThemeData().primaryColor,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '$spotleft spots left',
                            style: TextStyle(color: Colors.red),
                          ),
                          Text(
                            '${widget.participants.length} spots',
                            style: TextStyle(color: Colors.red),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Flexible(
              child: Container(
                child: contestsListData(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  ScrollController _scrollController = new ScrollController();
  TabController? controller;
  final PageController pageController = PageController(initialPage: 0);

  Widget contestsListData() {
    return NestedScrollView(
      controller: _scrollController,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverPersistentHeader(
            pinned: true,
            delegate: ContestTabHeader(controller!),
          ),
        ];
      },
      body: TabBarView(
        controller: controller,
        children: <Widget>[
          dowunloadbar(),
          ListView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount: widget.winLevels.length,
            itemBuilder: (context, index) {
              final todo = widget.winLevels[index];
              double price = double.parse(widget.price.toString());
              double distributionAmount = (todo.percentage / 100) * price;
              String formattedAmount = distributionAmount
                  .toStringAsFixed(2)
                  .replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), "");
              return Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10, top: 4, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '# ${todo.position}',
                        ),
                        Text(
                          '₹ $formattedAmount',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: AllCoustomTheme.getTextThemeColors(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget dowunloadbar() {
    final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
        GlobalKey<RefreshIndicatorState>();

    return RefreshIndicator(
      displacement: 100,
      key: _refreshIndicatorKey,
      onRefresh: () async {
        await Provider.of<GetFantasyPlayerPointProvider>(context, listen: false)
            .getplayerpoint();
      },
      child: Consumer<GetFantasyPlayerPointProvider>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final upcoming = value.todos;
          if (upcoming == null) {
            return Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 15, top: 10, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'All Teams (${widget.participants.length})',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: AllCoustomTheme.getTextThemeColors(),
                        ),
                      ),
                      Text(
                        'Points',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: AllCoustomTheme.getTextThemeColors(),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
                widget.participants.length == 0
                    ? Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: ListView(
                            physics: BouncingScrollPhysics(),
                            children: <Widget>[
                              Text(
                                'No team has joined this contest yet',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: AllCoustomTheme.getTextThemeColors(),
                                ),
                                textAlign: TextAlign.center,
                              ),
                              Container(
                                width: 100,
                                height: 100,
                                child: Image.asset(ConstanceData.users),
                              ),
                              Container(
                                child: Text(
                                  'Be the first one to join this contest & start winning!',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: ConstanceData.SIZE_TITLE14,
                                    color: Colors.grey,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: widget.participants.length,
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final todo = widget.participants[index];

                          int total = 4;
                          return InkWell(
                            onTap: () {
                              print(widget.playersPoints.length);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PlayerPointScreen(
                                        cap: todo.team.captain,
                                        vicecap: todo.team.viceCaptain,
                                        playersPoints: todo.team.playersPoints),
                                  ));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    todo.user.image == null
                                        ? Container(
                                            height: 44,
                                            width: 44,
                                            margin: EdgeInsets.all(8),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                border: Border.all(
                                                    color: Colors.grey)),
                                            child: Icon(Icons.person),
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: CircleAvatar(
                                              radius: 20,
                                              backgroundImage:
                                                  NetworkImage(todo.user.image),
                                            ),
                                          ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      todo.user.fullName ?? '',
                                      style: TextStyle(
                                          fontFamily: 'Poppins', fontSize: 16),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 8.0),
                                  child: Text(
                                    total.toString() ?? '',
                                    style: TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      )
              ],
            );
          }

          return Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(left: 15, top: 10, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'All Teams (${widget.participants.length})',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: AllCoustomTheme.getTextThemeColors(),
                      ),
                    ),
                    Text(
                      'Points',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: AllCoustomTheme.getTextThemeColors(),
                      ),
                    ),
                  ],
                ),
              ),
              Divider(),
              widget.participants.length == 0
                  ? Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: ListView(
                          physics: BouncingScrollPhysics(),
                          children: <Widget>[
                            Text(
                              'No team has joined this contest yet',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                color: AllCoustomTheme.getTextThemeColors(),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Container(
                              width: 100,
                              height: 100,
                              child: Image.asset(ConstanceData.users),
                            ),
                            Container(
                              child: Text(
                                'Be the first one to join this contest & start winning!',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: ConstanceData.SIZE_TITLE14,
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: widget.participants.length,
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final todo = widget.participants[index];
                        List<Playing11> teamAPlayers =
                            upcoming.response.points.teama.playing11;
                        List<Playing11> teamBPlayers =
                            upcoming.response.points.teamb.playing11;

                        List<Playing11> allPlayers = [
                          ...teamAPlayers,
                          ...teamBPlayers
                        ];

                        List<int> allPlayersPoints = todo.team.playersPoints
                            .map((point) => point.players)
                            .toList();

                        List<Playing11> filteredPlayers =
                            allPlayers.where((player) {
                          return allPlayersPoints
                              .toString()
                              .contains(player.pid);
                        }).toList();

                        double total = 0;

                        filteredPlayers.forEach((player) {
                          int playerPoints = int.tryParse(player.point) ?? 0;

                          if (int.parse(player.pid) == todo.team.captain) {
                            total += playerPoints * 2;
                          } else if (int.parse(player.pid) == todo.team.viceCaptain) {
                            total += playerPoints * 1.5;
                          } else {
                            total += playerPoints;
                          }
                        });


                        return InkWell(
                          onTap: () {
                            print(widget.playersPoints.length);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PlayerPointScreen(
                                      cap: todo.team.captain,
                                      vicecap: todo.team.viceCaptain,
                                      playersPoints: todo.team.playersPoints),
                                ));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  todo.user.image == null
                                      ? Container(
                                          height: 44,
                                          width: 44,
                                          margin: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: Colors.grey)),
                                          child: Icon(Icons.person),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CircleAvatar(
                                            radius: 20,
                                            backgroundImage:
                                                NetworkImage(todo.user.image),
                                          ),
                                        ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    todo.user.fullName ?? '',
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 16),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Text(
                                  total.round().toString() ?? '',
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    )
            ],
          );
        },
      ),
    );
  }

  Widget playerPoint() {
    return Column(
      children: [
        Container(
          height: 24,
          child: Padding(
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Players",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: ConstanceData.SIZE_TITLE12,
                    color: HexColor(
                      '#AAAFBC',
                    ),
                  ),
                ),
                Text(
                  'POINTS',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: ConstanceData.SIZE_TITLE12,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(0),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 14),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          child: AvatarImage(
                            isProgressPrimaryColor: true,
                            isCircle: true,
                            isAssets: true,
                            imageUrl: 'assets/cname/8.png',
                            radius: 50,
                            sizeValue: 50,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Faf du Plessis',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.green),
                              child: Icon(
                                Icons.done,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Text(
                            '58.0',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          child: AvatarImage(
                            isProgressPrimaryColor: true,
                            isCircle: true,
                            isAssets: true,
                            imageUrl: 'assets/cname/11.png',
                            radius: 50,
                            sizeValue: 50,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Quinton de Kock',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.green),
                              child: Icon(
                                Icons.done,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Text(
                            '20.0',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          child: AvatarImage(
                            isProgressPrimaryColor: true,
                            isCircle: true,
                            isAssets: true,
                            imageUrl: 'assets/cname/115.png',
                            radius: 50,
                            sizeValue: 50,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Rohit Sharma',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.green),
                              child: Icon(
                                Icons.done,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Text(
                            '101.0',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          child: AvatarImage(
                            isProgressPrimaryColor: true,
                            isCircle: true,
                            isAssets: true,
                            imageUrl: 'assets/cname/117.png',
                            radius: 50,
                            sizeValue: 50,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Shikhar Dhavan',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.green),
                              child: Icon(
                                Icons.done,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Text(
                            '200.3',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          child: AvatarImage(
                            isProgressPrimaryColor: true,
                            isCircle: true,
                            isAssets: true,
                            imageUrl: 'assets/cname/119.png',
                            radius: 50,
                            sizeValue: 50,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Virat Kohali',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.green),
                              child: Icon(
                                Icons.done,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Text(
                            '195.0',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          child: AvatarImage(
                            isProgressPrimaryColor: true,
                            isCircle: true,
                            isAssets: true,
                            imageUrl: 'assets/cname/123.png',
                            radius: 50,
                            sizeValue: 50,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'MS Dhoni',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.green),
                              child: Icon(
                                Icons.done,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Text(
                            '137.0',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          child: AvatarImage(
                            isProgressPrimaryColor: true,
                            isCircle: true,
                            isAssets: true,
                            imageUrl: 'assets/cname/131.png',
                            radius: 50,
                            sizeValue: 50,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Shami',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.green),
                              child: Icon(
                                Icons.done,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Text(
                            '452.0',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          child: AvatarImage(
                            isProgressPrimaryColor: true,
                            isCircle: true,
                            isAssets: true,
                            imageUrl: 'assets/cname/159.png',
                            radius: 50,
                            sizeValue: 50,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Quinton de Kock',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.green),
                              child: Icon(
                                Icons.done,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Text(
                            '136.0',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          child: AvatarImage(
                            isProgressPrimaryColor: true,
                            isCircle: true,
                            isAssets: true,
                            imageUrl: 'assets/cname/161.png',
                            radius: 50,
                            sizeValue: 50,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'hashim Amla',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.green),
                              child: Icon(
                                Icons.done,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Text(
                            '364.0',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          child: AvatarImage(
                            isProgressPrimaryColor: true,
                            isCircle: true,
                            isAssets: true,
                            imageUrl: 'assets/cname/163.png',
                            radius: 50,
                            sizeValue: 50,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Fat du Plessis',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.green),
                              child: Icon(
                                Icons.done,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Text(
                            '108.0',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          child: AvatarImage(
                            isProgressPrimaryColor: true,
                            isCircle: true,
                            isAssets: true,
                            imageUrl: 'assets/cname/167.png',
                            radius: 50,
                            sizeValue: 50,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Lungi Ngidi',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.green),
                              child: Icon(
                                Icons.done,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Text(
                            '95.0',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          child: AvatarImage(
                            isProgressPrimaryColor: true,
                            isCircle: true,
                            isAssets: true,
                            imageUrl: 'assets/cname/175.png',
                            radius: 50,
                            sizeValue: 50,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Dale Steyn',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.green),
                              child: Icon(
                                Icons.done,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Text(
                            '203.0',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    SizedBox(
                      height: 70,
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  int pageNumber = 0;
}

class StandingResultComplete extends StatefulWidget {
  final String? titel;
  final String? country1Name;
  final String? country1Flag;
  final String? country2Name;
  final String? country2Flag;
  final String? time;
  final String? price;
  String entryprize;
  int maxuser;
  List<PlayersPointComplete> playersPoints;
  List<WinLevelcomplete> winLevels;
  List<Participantcomplete> participants;

  StandingResultComplete(
      {Key? key,
      this.titel,
      this.country1Name,
      this.country1Flag,
      this.country2Name,
      this.country2Flag,
      this.time,
      this.price,
      required this.playersPoints,
      required this.winLevels,
      required this.participants,
      required this.entryprize,
      required this.maxuser})
      : super(key: key);
  @override
  _StandingResultCompleteState createState() => _StandingResultCompleteState();
}

class _StandingResultCompleteState extends State<StandingResultComplete>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    controller = new TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<GetFantasyPlayerPointProvider>(context, listen: false)
          .getplayerpoint();
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
        appBar: AppBar(
          elevation: 0,
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
          backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
          title: Text(
            "Joined Contests",
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Colors.white,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            MatchHadder(
              country1Flag: widget.country1Flag,
              country2Flag: widget.country2Flag,
              country1Name: widget.country1Name,
              country2Name: widget.country2Name,
              price: widget.price,
              time: widget.time,
              titel: widget.titel,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 8, right: 8, top: 4),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: contest(),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget contest() {
    int spotleft = widget.maxuser - widget.participants.length;
    double progress = widget.participants.length / widget.maxuser;
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: <Widget>[
        Column(
          children: <Widget>[
            Card(
              color: Colors.white,
              elevation: 10,
              child: Container(
                margin: EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, top: 4),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Text(
                                'Prize Pool',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: HexColor(
                                    '#AAAFBC',
                                  ),
                                  fontSize: ConstanceData.SIZE_TITLE14,
                                ),
                              ),
                              Text(
                                '₹${widget.price}',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: ConstanceData.SIZE_TITLE20,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                          // Column(
                          //   children: <Widget>[
                          //     Text(
                          //       'Winner',
                          //       style: TextStyle(
                          //         fontFamily: 'Poppins',
                          //         color: HexColor(
                          //           '#AAAFBC',
                          //         ),
                          //         fontSize: ConstanceData.SIZE_TITLE14,
                          //       ),
                          //     ),
                          //     Text(
                          //       '1',
                          //       style: TextStyle(
                          //         fontFamily: 'Poppins',
                          //         // color: HexColor(
                          //         //   '#AAAFBC',
                          //         // ),
                          //         fontSize: ConstanceData.SIZE_TITLE14,
                          //       ),
                          //     )
                          //   ],
                          // ),
                          Column(
                            children: <Widget>[
                              Text(
                                'Entry',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: HexColor(
                                    '#AAAFBC',
                                  ),
                                  fontSize: ConstanceData.SIZE_TITLE14,
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                // color: Color(0xFF064475),
                                width: 50,
                                child: Text(
                                  '₹${widget.entryprize}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      LinearPercentIndicator(
                        lineHeight: 6,
                        percent: progress,
                        linearStrokeCap: LinearStrokeCap.roundAll,
                        backgroundColor: AllCoustomTheme.getThemeData()
                            .scaffoldBackgroundColor,
                        progressColor:
                            AllCoustomTheme.getThemeData().primaryColor,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '$spotleft spots left',
                            style: TextStyle(color: Colors.red),
                          ),
                          Text(
                            '${widget.participants.length} spots',
                            style: TextStyle(color: Colors.red),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Flexible(
              child: Container(
                child: contestsListData(),
              ),
            ),
          ],
        ),
      ],
    );
  }

  ScrollController _scrollController = new ScrollController();
  TabController? controller;
  final PageController pageController = PageController(initialPage: 0);

  Widget contestsListData() {
    return NestedScrollView(
      controller: _scrollController,
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverPersistentHeader(
            pinned: true,
            delegate: ContestTabHeader(controller!),
          ),
        ];
      },
      body: TabBarView(
        controller: controller,
        children: <Widget>[
          dowunloadbar(),
          ListView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount: widget.winLevels.length,
            itemBuilder: (context, index) {
              final todo = widget.winLevels[index];
              double price = double.parse(widget.price.toString());
              double distributionAmount = (todo.percentage / 100) * price;
              String formattedAmount = distributionAmount
                  .toStringAsFixed(2)
                  .replaceAll(RegExp(r"([.]*0+)(?!.*\d)"), "");
              return Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10, top: 4, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '# ${todo.position}',
                        ),
                        Text(
                          '₹ $formattedAmount',
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: AllCoustomTheme.getTextThemeColors(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget dowunloadbar() {
    return Consumer<GetFantasyPlayerPointProvider>(
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

        List<Participantcomplete> participants = widget.participants;

        Map<Participantcomplete, int> participantPointsMap = {};

        participants.forEach((participant) {
          List<Playing11> teamAPlayers =
              upcoming.response.points.teama.playing11;
          List<Playing11> teamBPlayers =
              upcoming.response.points.teamb.playing11;

          List<Playing11> allPlayers = [...teamAPlayers, ...teamBPlayers];

          List<int> allPlayersPoints = participant.team.playersPoints
              .map((point) => point.players)
              .toList();

          List<Playing11> filteredPlayers = allPlayers.where((player) {
            return allPlayersPoints.toString().contains(player.pid);
          }).toList();

          int total = 0;

          filteredPlayers.forEach((player) {
            total += int.tryParse(player.point) ?? 0;
          });

          participantPointsMap[participant] = total;
        });

        participants.sort((a, b) =>
            participantPointsMap[b]!.compareTo(participantPointsMap[a]!));

        return Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                left: 15,
                top: 10,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    flex: 7,
                    child: Text(
                      'All Teams (${widget.participants.length})',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: AllCoustomTheme.getTextThemeColors(),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Points',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: AllCoustomTheme.getTextThemeColors(),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      'Rank',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: AllCoustomTheme.getTextThemeColors(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(),
            widget.participants.length == 0
                ? Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        children: <Widget>[
                          Text(
                            'No team has joined this contest yet',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: AllCoustomTheme.getTextThemeColors(),
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Container(
                            width: 100,
                            height: 100,
                            child: Image.asset(ConstanceData.users),
                          ),
                          Container(
                            child: Text(
                              'Be the first one to join this contest & start winning!',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE14,
                                color: Colors.grey,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: participants.length,
                    physics: BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final participant = participants[index];
                      int totalPoints = participantPointsMap[participant]!;

                      return InkWell(
                        onTap: () {
                          print(widget.playersPoints.length);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlayerPointScreenComplete(
                                playersPoints: participant.team.playersPoints,
                                cap: participant.team.captain,
                                vicecap: participant.team.viceCaptain,
                              ),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 4,
                              child: Row(
                                children: [
                                  participant.user.image == null
                                      ? Container(
                                          height: 44,
                                          width: 44,
                                          margin: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color: Colors.grey)),
                                          child: Icon(Icons.person),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: CircleAvatar(
                                            radius: 20,
                                            backgroundImage: NetworkImage(
                                                participant.user.image),
                                          ),
                                        ),
                                  SizedBox(width: 10),
                                  Text(
                                    participant.user.fullName ?? '',
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Text(
                                  participant.team.totalWinningPoint
                                          .toString() ??
                                      '',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Text(
                                  '#${index + 1}',
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )
          ],
        );
      },
    );
  }

  Widget playerPoint() {
    return Column(
      children: [
        Container(
          height: 24,
          child: Padding(
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Players",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: ConstanceData.SIZE_TITLE12,
                    color: HexColor(
                      '#AAAFBC',
                    ),
                  ),
                ),
                Text(
                  'POINTS',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: ConstanceData.SIZE_TITLE12,
                  ),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: ListView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(0),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10, right: 14),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          child: AvatarImage(
                            isProgressPrimaryColor: true,
                            isCircle: true,
                            isAssets: true,
                            imageUrl: 'assets/cname/8.png',
                            radius: 50,
                            sizeValue: 50,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Faf du Plessis',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.green),
                              child: Icon(
                                Icons.done,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Text(
                            '58.0',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          child: AvatarImage(
                            isProgressPrimaryColor: true,
                            isCircle: true,
                            isAssets: true,
                            imageUrl: 'assets/cname/11.png',
                            radius: 50,
                            sizeValue: 50,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Quinton de Kock',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.green),
                              child: Icon(
                                Icons.done,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Text(
                            '20.0',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          child: AvatarImage(
                            isProgressPrimaryColor: true,
                            isCircle: true,
                            isAssets: true,
                            imageUrl: 'assets/cname/115.png',
                            radius: 50,
                            sizeValue: 50,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Rohit Sharma',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.green),
                              child: Icon(
                                Icons.done,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Text(
                            '101.0',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          child: AvatarImage(
                            isProgressPrimaryColor: true,
                            isCircle: true,
                            isAssets: true,
                            imageUrl: 'assets/cname/117.png',
                            radius: 50,
                            sizeValue: 50,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Shikhar Dhavan',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.green),
                              child: Icon(
                                Icons.done,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Text(
                            '200.3',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          child: AvatarImage(
                            isProgressPrimaryColor: true,
                            isCircle: true,
                            isAssets: true,
                            imageUrl: 'assets/cname/119.png',
                            radius: 50,
                            sizeValue: 50,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Virat Kohali',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.green),
                              child: Icon(
                                Icons.done,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Text(
                            '195.0',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          child: AvatarImage(
                            isProgressPrimaryColor: true,
                            isCircle: true,
                            isAssets: true,
                            imageUrl: 'assets/cname/123.png',
                            radius: 50,
                            sizeValue: 50,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'MS Dhoni',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.green),
                              child: Icon(
                                Icons.done,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Text(
                            '137.0',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          child: AvatarImage(
                            isProgressPrimaryColor: true,
                            isCircle: true,
                            isAssets: true,
                            imageUrl: 'assets/cname/131.png',
                            radius: 50,
                            sizeValue: 50,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Shami',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.green),
                              child: Icon(
                                Icons.done,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Text(
                            '452.0',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          child: AvatarImage(
                            isProgressPrimaryColor: true,
                            isCircle: true,
                            isAssets: true,
                            imageUrl: 'assets/cname/159.png',
                            radius: 50,
                            sizeValue: 50,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Quinton de Kock',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.green),
                              child: Icon(
                                Icons.done,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Text(
                            '136.0',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          child: AvatarImage(
                            isProgressPrimaryColor: true,
                            isCircle: true,
                            isAssets: true,
                            imageUrl: 'assets/cname/161.png',
                            radius: 50,
                            sizeValue: 50,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'hashim Amla',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.green),
                              child: Icon(
                                Icons.done,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Text(
                            '364.0',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          child: AvatarImage(
                            isProgressPrimaryColor: true,
                            isCircle: true,
                            isAssets: true,
                            imageUrl: 'assets/cname/163.png',
                            radius: 50,
                            sizeValue: 50,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Fat du Plessis',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.green),
                              child: Icon(
                                Icons.done,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Text(
                            '108.0',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          child: AvatarImage(
                            isProgressPrimaryColor: true,
                            isCircle: true,
                            isAssets: true,
                            imageUrl: 'assets/cname/167.png',
                            radius: 50,
                            sizeValue: 50,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Lungi Ngidi',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.green),
                              child: Icon(
                                Icons.done,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Text(
                            '95.0',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    Row(
                      children: <Widget>[
                        Container(
                          width: 50,
                          height: 50,
                          child: AvatarImage(
                            isProgressPrimaryColor: true,
                            isCircle: true,
                            isAssets: true,
                            imageUrl: 'assets/cname/175.png',
                            radius: 50,
                            sizeValue: 50,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Dale Steyn',
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: ConstanceData.SIZE_TITLE14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle, color: Colors.green),
                              child: Icon(
                                Icons.done,
                                size: 12,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        Expanded(
                          child: Text(
                            '203.0',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: ConstanceData.SIZE_TITLE14,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.end,
                          ),
                        )
                      ],
                    ),
                    Divider(),
                    SizedBox(
                      height: 70,
                    )
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  int pageNumber = 0;
}
