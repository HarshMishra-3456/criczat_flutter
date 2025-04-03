// ignore_for_file: deprecated_member_use, unnecessary_null_comparison

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:tempalteflutter/constance/constance.dart';
import 'package:tempalteflutter/constance/themes.dart';
import 'package:tempalteflutter/modules/contests/data/contestapi.dart';
import 'package:tempalteflutter/validator/validator.dart';

class CreateContestScreen extends StatefulWidget {
  final String? titel;
  final String? country1Name;
  final String? country1Flag;
  final String? country2Name;
  final String? country2Flag;
  final String? time;
  final String? price;

  const CreateContestScreen(
      {Key? key,
      this.titel,
      this.country1Name,
      this.country1Flag,
      this.country2Name,
      this.country2Flag,
      this.time,
      this.price})
      : super(key: key);
  @override
  _CreateContestScreenState createState() => _CreateContestScreenState();
}

class _CreateContestScreenState extends State<CreateContestScreen> {
  bool isProsses = false;
  var pAmout = '';
  var cSize = '';
  var totalWinningamount = 0;
  var contestSize = 0;
  var contestName = '';
  var entryfee = '';
  var finalEntryfee = 0.0;
  Timer? timer;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  var amountController = new TextEditingController();
  var entryfees = new TextEditingController();
  var sizeController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading:  InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back,color: Colors.white,)),
        backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Coming Soon',
              style: TextStyle(
                  color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
    // return Container(
    //   decoration: BoxDecoration(
    //     gradient: LinearGradient(
    //       colors: [
    //         AllCoustomTheme.getThemeData().primaryColor,
    //         AllCoustomTheme.getThemeData().primaryColor,
    //         Colors.white,
    //         Colors.white,
    //       ],
    //       begin: Alignment.topCenter,
    //       end: Alignment.bottomCenter,
    //     ),
    //   ),
    //   child: Stack(
    //     children: <Widget>[
    //       SafeArea(
    //         child: Scaffold(
    //           key: _scaffoldKey,
    //           backgroundColor: AllCoustomTheme.getThemeData().backgroundColor,
    //           body: GestureDetector(
    //             onTap: () {
    //               FocusScope.of(context).requestFocus(new FocusNode());
    //             },
    //             child: Column(
    //               children: <Widget>[
    //                 Container(
    //                   color: AllCoustomTheme.getThemeData().primaryColor,
    //                   child: Column(
    //                     children: <Widget>[
    //                       Container(
    //                         height: AppBar().preferredSize.height,
    //                         child: Row(
    //                           children: <Widget>[
    //                             Material(
    //                               color: Colors.transparent,
    //                               child: InkWell(
    //                                 onTap: () {
    //                                   Navigator.pop(context);
    //                                 },
    //                                 child: Container(
    //                                   width: AppBar().preferredSize.height,
    //                                   height: AppBar().preferredSize.height,
    //                                   child: Icon(
    //                                     Icons.arrow_back,
    //                                     color: Colors.white,
    //                                   ),
    //                                 ),
    //                               ),
    //                             ),
    //                             Expanded(
    //                               child: Center(
    //                                 child: Text(
    //                                   'Make your own Contest',
    //                                   style: TextStyle(
    //                                     fontFamily: 'Poppins',
    //                                     fontSize: 20,
    //                                     fontWeight: FontWeight.w500,
    //                                     color: AllCoustomTheme.getThemeData()
    //                                         .backgroundColor,
    //                                   ),
    //                                 ),
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                       Container(
    //                         color:
    //                             AllCoustomTheme.getThemeData().backgroundColor,
    //                         child: Column(
    //                           children: <Widget>[
    //                             Container(
    //                               height: 36,
    //                               padding: EdgeInsets.only(
    //                                   left: 8, right: 8, bottom: 4, top: 4),
    //                               child: Row(
    //                                 children: <Widget>[
    //                                   Container(
    //                                     width: 24,
    //                                     height: 24,
    //                                     child:
    //                                         Image.network(widget.country1Flag!),
    //                                   ),
    //                                   Container(
    //                                     padding:
    //                                         EdgeInsets.only(left: 8, right: 8),
    //                                     child: Text(
    //                                       widget.country1Name!,
    //                                       textAlign: TextAlign.start,
    //                                       style: TextStyle(
    //                                         fontFamily: 'Poppins',
    //                                         fontWeight: FontWeight.bold,
    //                                         color:
    //                                             AllCoustomTheme.getThemeData()
    //                                                 .primaryColor,
    //                                         fontSize:
    //                                             ConstanceData.SIZE_TITLE12,
    //                                       ),
    //                                     ),
    //                                   ),
    //                                   Container(
    //                                     child: Text(
    //                                       'vs',
    //                                       textAlign: TextAlign.start,
    //                                       style: TextStyle(
    //                                         fontFamily: 'Poppins',
    //                                         fontSize:
    //                                             ConstanceData.SIZE_TITLE12,
    //                                         fontWeight: FontWeight.bold,
    //                                         color: Colors.red,
    //                                       ),
    //                                     ),
    //                                   ),
    //                                   Container(
    //                                     padding:
    //                                         EdgeInsets.only(left: 8, right: 8),
    //                                     child: Text(
    //                                       widget.country2Name!,
    //                                       textAlign: TextAlign.start,
    //                                       style: TextStyle(
    //                                         fontFamily: 'Poppins',
    //                                         fontWeight: FontWeight.bold,
    //                                         color:
    //                                             AllCoustomTheme.getThemeData()
    //                                                 .primaryColor,
    //                                         fontSize:
    //                                             ConstanceData.SIZE_TITLE12,
    //                                       ),
    //                                     ),
    //                                   ),
    //                                   Container(
    //                                     width: 24,
    //                                     height: 24,
    //                                     child:
    //                                         Image.network(widget.country2Flag!),
    //                                   ),
    //                                   Expanded(
    //                                     child: SizedBox(),
    //                                   ),
    //                                   Container(
    //                                     child: Text(
    //                                       widget.time!,
    //                                       style: TextStyle(
    //                                         fontFamily: 'Poppins',
    //                                         color: HexColor(
    //                                           '#AAAFBC',
    //                                         ),
    //                                         fontWeight: FontWeight.w600,
    //                                         fontSize: 14,
    //                                       ),
    //                                     ),
    //                                   ),
    //                                 ],
    //                               ),
    //                             ),
    //                             Divider(
    //                               height: 1,
    //                             )
    //                           ],
    //                         ),
    //                       ),
    //                     ],
    //                   ),
    //                 ),
    //                 Flexible(
    //                   child: Container(
    //                     child: contestsData(),
    //                   ),
    //                 ),
    //                 SizedBox(
    //                   height: 100,
    //                 ),
    //                 InkWell(
    //                   onTap: () {
    //                     ContestApi().CreateContest(
    //                         context: context,
    //                         contestsize: sizeController.text,
    //                         entryfee: entryfees.text,
    //                         winningamount: amountController.text);
    //                   },
    //                   child: Container(
    //                     width: double.infinity,
    //                     child: Container(
    //                       height: 60,
    //                       padding:
    //                           EdgeInsets.only(left: 50, right: 50, bottom: 20),
    //                       child: Container(
    //                         decoration: new BoxDecoration(
    //                           color:
    //                               AllCoustomTheme.getThemeData().primaryColor,
    //                           borderRadius: new BorderRadius.circular(4.0),
    //                           boxShadow: <BoxShadow>[
    //                             BoxShadow(
    //                                 color: Colors.black.withOpacity(0.5),
    //                                 offset: Offset(0, 1),
    //                                 blurRadius: 5.0),
    //                           ],
    //                         ),
    //                         child: Material(
    //                           color: Colors.transparent,
    //                           child: InkWell(
    //                             borderRadius: new BorderRadius.circular(4.0),
    //                             child: Center(
    //                               child: Text(
    //                                 'CREATE CONTEST',
    //                                 style: TextStyle(
    //                                   fontFamily: 'Poppins',
    //                                   fontWeight: FontWeight.bold,
    //                                   color: Colors.white,
    //                                   fontSize: ConstanceData.SIZE_TITLE12,
    //                                 ),
    //                               ),
    //                             ),
    //                           ),
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //       )
    //     ],
    //   ),
    // );
  }

  Widget contestsData() {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          new Container(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: new TextField(
              controller: entryfees,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: ConstanceData.SIZE_TITLE16,
                color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
              ),
              autofocus: true,
              keyboardType: TextInputType.numberWithOptions(),
              decoration: new InputDecoration(
                labelText: 'Entry Fee',
              ),
            ),
          ),
          new Container(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: new TextField(
              controller: amountController,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: ConstanceData.SIZE_TITLE16,
                color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
              ),
              autofocus: false,
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(
                labelText: 'winning amount (Rs).',
                counterStyle: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 0,
                  color: Colors.transparent,
                ),
              ),
              maxLength: 5,
            ),
          ),
          new Container(
            padding: EdgeInsets.only(left: 16, right: 16),
            child: new TextField(
              controller: sizeController,
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: ConstanceData.SIZE_TITLE16,
                color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
              ),
              autofocus: false,
              keyboardType: TextInputType.number,
              decoration: new InputDecoration(
                labelText: 'Contest size.',
                counterStyle: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 0,
                  color: Colors.transparent,
                ),
              ),
              maxLength: 3,
            ),
          ),
        ],
      ),
    );
  }

  void showInSnackBar(String value, {bool isGreeen = false}) {
    var snackBar = SnackBar(
      backgroundColor: isGreeen ? Colors.green : Colors.red,
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
}
