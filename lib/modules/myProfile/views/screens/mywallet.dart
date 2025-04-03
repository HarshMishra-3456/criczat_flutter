import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tempalteflutter/constance/themes.dart';
import 'package:tempalteflutter/core/Utils/authutilities.dart';
import 'package:tempalteflutter/modules/myProfile/views/provider/getalltrasactionprovider.dart';
import 'package:tempalteflutter/modules/myProfile/views/provider/getuserprovider.dart';
import 'package:tempalteflutter/modules/myProfile/views/screens/transectionHistoryScreen.dart';
import 'package:tempalteflutter/modules/pymentOptions/pymentOptionsScreen.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:tempalteflutter/modules/pymentOptions/withdrawScreen.dart';
import 'package:tempalteflutter/utils/avatarImage.dart';

class MyWallet extends StatefulWidget {
  const MyWallet({super.key});

  @override
  State<MyWallet> createState() => _MyWalletState();
}

class _MyWalletState extends State<MyWallet> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<GetUserAllTransactionProvider>(context, listen: false)
          .gettransaction();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text(
          'Wallet',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 30,
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
                  return Container(
                    height: 200,
                    width: double.infinity,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: AllCoustomTheme.getThemeData().primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            todo.image == null
                                ? Container(
                                    height: 44,
                                    width: 44,
                                    child: AvatarImage(
                                      sizeValue: 44,
                                      radius: 44,
                                      isCircle: true,
                                      imageUrl:
                                          "https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1534&q=80",
                                    ),
                                  )
                                : CircleAvatar(
                                    radius: 20,
                                    backgroundImage: NetworkImage(todo.image),
                                  ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              todo.fullName ?? '',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              height: 30,
                              padding: EdgeInsets.all(5),
                              // width: 30,
                              child: Icon(
                                Icons.account_balance_wallet,
                                color: Colors.white,
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.white60,
                                  borderRadius: BorderRadius.circular(10)),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'Balance',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 25),
                                ),
                                Text(
                                  '₹ ${todo.wallet.round()}',
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 30,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PymentScreen(
                            isOnlyAddMoney: true,
                            isTruePayment: () {},
                          ),
                          fullscreenDialog: true,
                        ),
                      );
                    },
                    child: Container(
                      height: 50,
                      width: 150,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: AllCoustomTheme.getThemeData().primaryColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        'Add Cash',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WithdrawScreen(),
                          fullscreenDialog: true,
                        ),
                      );
                    },
                    child: Container(
                      height: 50,
                      width: 150,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: AllCoustomTheme.getThemeData().primaryColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        'WithDraw',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Last Transation',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: 'Poppins',
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TransectionHistoryScreen(),
                          ));
                    },
                    child: Text(
                      'View All',
                      style: TextStyle(
                        color: Color(0xFF8438FF),
                        fontSize: 18,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Consumer<GetUserAllTransactionProvider>(
                builder: (context, value, child) {
                  if (value.isLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  final transaction = value.todos;
                  if (transaction == null || transaction.isEmpty) {
                    return const Center(
                      child: Text('No data found'),
                    );
                  }

                  // final itemCount = transaction.length > 6 ? 6 : transaction.length;

                  return ListView.builder(
                    itemCount: transaction.length,
                    shrinkWrap: true,
                    reverse: true,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final todo = transaction[index];
                      final isCredit = todo.type == 'Credit';

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  isCredit
                                      ? Icons.arrow_circle_up
                                      : Icons.arrow_circle_down,
                                  color: isCredit ? Colors.green : Colors.red,
                                  size: 30,
                                ),
                                SizedBox(width: 16),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      todo.type ?? '',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        letterSpacing: 1,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      formatDateStringToMonthName(todo.date
                                          .toString()
                                          .substring(0, 11)),
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontFamily: 'Poppins',
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Text(
                              isCredit
                                  ? '+ ₹${todo.amount}'
                                  : '- ₹${todo.amount}',
                              style: TextStyle(
                                color: isCredit ? Colors.green : Colors.red,
                                fontSize: 18,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }

  static var platform = MethodChannel('com.sabpaisa.integration/native');

  Future<void> _startPayment() async {
    try {
      final List<Object?> result = await platform.invokeMethod(
          'callSabPaisaSdk',
          ["John", "Doe", "john@gmail.com", "9876543210", "500"]);

      String txnStatus = result[0].toString();
      String txnId = result[1].toString();

      Fluttertoast.showToast(
        msg: "Transaction: $txnStatus\nTransaction ID: $txnId",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        backgroundColor: txnStatus == "SUCCESS" ? Colors.green : Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } on PlatformException catch (e) {
      Fluttertoast.showToast(
        msg: "Error: ${e.message}",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
}
