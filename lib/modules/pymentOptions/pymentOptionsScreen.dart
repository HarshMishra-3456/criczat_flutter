// ignore_for_file: unused_field, unnecessary_null_comparison, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tempalteflutter/constance/constance.dart';
import 'package:tempalteflutter/constance/themes.dart';
import 'package:tempalteflutter/core/Utils/constants.dart';
import 'package:tempalteflutter/models/scheduleResponseData.dart';
import 'package:tempalteflutter/models/userData.dart';
import 'package:tempalteflutter/modules/contests/views/screens/contestsScreen.dart';
import 'package:provider/provider.dart';
import 'package:tempalteflutter/modules/myProfile/data/userwalletapi.dart';
import 'package:tempalteflutter/modules/myProfile/views/provider/getuserprovider.dart';

import '../../api/apiProvider.dart';

class PymentScreen extends StatefulWidget {
  final String? paymetMoney;
  final entryFees;
  final ShedualData? shedualData;
  final bool? isOnlyAddMoney;
  final VoidCallback? isTruePayment;

  const PymentScreen({Key? key, this.paymetMoney, this.shedualData, this.isOnlyAddMoney = false, this.entryFees, this.isTruePayment})
      : super(key: key);
  @override
  _PymentScreenState createState() => _PymentScreenState();
}

class _PymentScreenState extends State<PymentScreen> {
  var paymet = '';
  var isProsses = false;
  var paymentController = new TextEditingController();
  UserData userData = new UserData();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var cashBonus = '';
  var data;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
     var responce= ApiProvider().getProfile();
    });
    getUserData();
  }

  void getUserData() async {
    var responseData = ApiProvider().getProfile();
    data = responseData.data;

    setState(() {});
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
              key: _scaffoldKey,
              backgroundColor: AllCoustomTheme.getThemeData().colorScheme.background,
              body: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: <Widget>[
                  Column(
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
                                        widget.isOnlyAddMoney! ? 'Add Cash' : 'Payment',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 24,
                                          fontWeight: FontWeight.w500,
                                          color: AllCoustomTheme.getThemeData().colorScheme.background,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: AppBar().preferredSize.height,
                                  ),
                                ],
                              ),
                            ),
                            widget.shedualData != null ? MatchHadder() : SizedBox(),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    Column(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(left: 16.0, right: 16, bottom: 16, top: 16),
                                          child: Row(
                                            children: <Widget>[
                                              Text(
                                                'Current Balance',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  color: Colors.black,
                                                ),
                                              ),
                                              Expanded(
                                                child: SizedBox(),
                                              ),
                                              Consumer<GetUserDataProvider>(
                                                builder: (context, value, child) {
                                                  if (value.isLoading) {
                                                    return const Center(
                                                      child: CircularProgressIndicator(),
                                                    );
                                                  }
                                                  final userdata = value.todos;
                                                  if (userdata == null) {
                                                    return const Center(
                                                      child: Text('No data found'),
                                                    );
                                                  }
                                                  final todo = userdata.data;
                                                  return Text(
                                                    '₹${todo.wallet}',
                                                    style: TextStyle(
                                                      fontFamily: 'Poppins',
                                                      color: const Color(0xFFB00020),
                                                      fontSize: ConstanceData.SIZE_TITLE18,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          height: 1,
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(top: 16, left: 16),
                                      child: Text(
                                        'Add amount',
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: ConstanceData.SIZE_TITLE14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                                      child: Container(
                                        padding: EdgeInsets.only(left: 8, right: 8),
                                        decoration: BoxDecoration(
                                          borderRadius: new BorderRadius.circular(4.0),
                                          border: Border.all(
                                            color: Colors.black.withOpacity(0.5),
                                            width: 1.2,
                                          ),
                                        ),
                                        child: TextFormField(
                                          controller: paymentController,
                                          style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: ConstanceData.SIZE_TITLE16,
                                            color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                                          ),
                                          autofocus: true,
                                          keyboardType: TextInputType.number,
                                          decoration: new InputDecoration(
                                            prefix: Padding(
                                              padding: const EdgeInsets.only(right: 20,left: 10),
                                              child: Text(
                                                '₹',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: ConstanceData.SIZE_TITLE16,
                                                ),
                                              ),
                                            ),
                                            border: InputBorder.none,
                                            labelStyle: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: ConstanceData.SIZE_TITLE16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(left: 8, right: 8),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        children: <Widget>[
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    paymentController.text = '50';
                                                  });
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.only(top: 8, bottom: 8),
                                                  decoration: BoxDecoration(
                                                    borderRadius: new BorderRadius.circular(4.0),
                                                    border: Border.all(
                                                      color: Colors.grey,
                                                      width: 1.2,
                                                    ),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: <Widget>[
                                                      Container(
                                                        child: Text(
                                                          '₹50',
                                                          style: TextStyle(
                                                            fontFamily: 'Poppins',
                                                            color: Colors.grey,
                                                            fontSize: ConstanceData.SIZE_TITLE18,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    paymentController.text = '100';
                                                  });
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.only(top: 8, bottom: 8),
                                                  decoration: BoxDecoration(
                                                    borderRadius: new BorderRadius.circular(4.0),
                                                    border: Border.all(
                                                      color: Colors.grey,
                                                      width: 1.2,
                                                    ),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: <Widget>[
                                                      Container(
                                                        child: Text(
                                                          '₹100',
                                                          style: TextStyle(
                                                            fontFamily: 'Poppins',
                                                            color: Colors.grey,
                                                            fontSize: ConstanceData.SIZE_TITLE18,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    paymentController.text = '200';
                                                  });
                                                },
                                                child: Container(
                                                  padding: EdgeInsets.only(top: 8, bottom: 8),
                                                  decoration: BoxDecoration(
                                                    borderRadius: new BorderRadius.circular(4.0),
                                                    border: Border.all(
                                                      color: Colors.grey,
                                                      width: 1.2,
                                                    ),
                                                  ),
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: <Widget>[
                                                      Container(
                                                        child: Text(
                                                          '₹200',
                                                          style: TextStyle(
                                                            fontFamily: 'Poppins',
                                                            color: Colors.grey,
                                                            fontSize: ConstanceData.SIZE_TITLE18,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Container(
                                      height: 60,
                                      padding: EdgeInsets.only(left: 50, right: 50, bottom: 20),
                                      child: Row(
                                        children: <Widget>[
                                          Flexible(
                                            child: Container(
                                              decoration:  BoxDecoration(
                                                color: AllCoustomTheme.getThemeData().primaryColor,
                                                borderRadius:  BorderRadius.circular(4.0),
                                                boxShadow: <BoxShadow>[
                                                  BoxShadow(color: Colors.black.withOpacity(0.5), offset: Offset(0, 1), blurRadius: 5.0),
                                                ],
                                              ),
                                              child:Consumer<GetUserDataProvider>(
                                                  builder: (context, value, child) {
                                                    return InkWell(
                                                      borderRadius: new BorderRadius.circular(4.0),
                                                      onTap: () async{
                                                        if(paymentController.text.isNotEmpty) {
                                                          const platform = MethodChannel('com.example.payment/sdk');

                                                          String _paymentStatus = '';
                                                          Map<String, dynamic>? _response;

                                                          Future<void> _startPayment() async {
                                                            try {
                                                              final result = await platform.invokeMethod<Map<dynamic, dynamic>>('startPayment', {
                                                                'payerName': '${value.cricketdata!=null?value.cricketdata!.data.fullName:"Guest001"}',
                                                                'payerEmail': '${value.cricketdata!=null?value.cricketdata!.data.email:"info@criczat.com"}',
                                                                'payerMobile': '${value.cricketdata!=null?value.cricketdata!.data.phone:""}',
                                                                'amount': paymentController.text,
                                                              });
                                                              setState(() {
                                                                _paymentStatus = "Success";
                                                                _response = Map<String, dynamic>.from(result!);
                                                                clickPayment();
                                                              });
                                                            } on PlatformException catch (e) {
                                                              setState(() {
                                                                _paymentStatus = "Failed";
                                                                _response = {"error": e.message};
                                                              });
                                                            }
                                                          }
                                                          if(value.cricketdata==null){
                                                            constToast("Please Provide basic Profile Detail Name & Email");
                                                          }else if(value.cricketdata!.data.fullName==""){
                                                            constToast("Please Provide basic Profile Detail Name & Email");
                                                          }else if(value.cricketdata!.data.email==""){
                                                            constToast("Please Provide basic Profile Detail Name & Email");
                                                          }else {
                                                            _startPayment();
                                                          }
                                                        }
                                                      },
                                                      child: Center(
                                                          child: isProsses ?  CircularProgressIndicator() :Text(
                                                            'Add cash'.toUpperCase(),
                                                            style: TextStyle(
                                                              fontFamily: 'Poppins',
                                                              fontWeight: FontWeight.bold,
                                                              color: Colors.white,
                                                              fontSize: ConstanceData.SIZE_TITLE12,
                                                            ),
                                                          )
                                                      ),
                                                    );
                                                  },
                                              )
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              )
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void clickPayment() async {
    setState(() {
      isProsses = true;
    });
    if(paymentController.text.isNotEmpty){
      UserWalletApis().AddAmount(paymentController.text, context);

    }else{
      constToast('Enter The Amount');
    }
    setState(() {
      isProsses = false;
    });
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

  void showInSnackBars(String value) {
    var snackBar = SnackBar(
      backgroundColor: Colors.green,
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
