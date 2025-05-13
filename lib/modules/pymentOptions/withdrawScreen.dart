// ignore_for_file: unnecessary_null_comparison, deprecated_member_use

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:tempalteflutter/api/apiProvider.dart';
import 'package:tempalteflutter/constance/constance.dart';
import 'package:tempalteflutter/constance/themes.dart';
import 'package:tempalteflutter/core/Utils/constants.dart';
import 'package:tempalteflutter/models/bankListResponseData.dart';
import 'package:tempalteflutter/models/userData.dart';
import 'package:provider/provider.dart';
import 'package:tempalteflutter/modules/myProfile/data/userwalletapi.dart';
import 'package:tempalteflutter/modules/myProfile/views/provider/getuserprovider.dart';
import 'package:http/http.dart' as http;
import 'package:tempalteflutter/modules/pymentOptions/PreferenceManager.dart';

class WithdrawScreen extends StatefulWidget {
  @override
  _WithdrawScreenState createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  var paymet = '';
  var isProsses = false;
  var paymentController = new TextEditingController();
  var nameController = new TextEditingController();
  var accNoController = new TextEditingController();
  var ifscController = new TextEditingController();
  var bankNameController = new TextEditingController();
  var upiIDController = new TextEditingController();
  List<AccountDetail> accountDetailList = <AccountDetail>[];
  // UserData user = new UserData();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    paymentController.text = paymet;
    super.initState();
    PreferenceManager.instance.getString("BANK").then((onValue){
      var newdata=jsonDecode(onValue);
      nameController.text=newdata["name"];
     accNoController.text=newdata["account_number"];
     ifscController.text=newdata["ifsc"];
     bankNameController.text=newdata["bank_name"];
     upiIDController.text=newdata["upi_id"];
    });
  }

  @override
  void dispose() {
    paymentController.dispose();
    super.dispose();
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
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
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
                                          'Withdraw',
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
                            ],
                          ),
                        ),
                        Expanded(
                          child: ModalProgressHUD(
                            inAsyncCall: isProsses,
                            color: Colors.transparent,
                            progressIndicator: CircularProgressIndicator(
                              strokeWidth: 2.0,
                            ),
                            child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(left: 16.0, right: 16, bottom: 16, top: 16),
                                          child: Row(
                                            children: <Widget>[
                                              Text(
                                                'Your Winnings Prices',
                                                style: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
                                                  fontSize: ConstanceData.SIZE_TITLE14,
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
                                                      color: AllCoustomTheme.getBlackAndWhiteThemeColors(),
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
                                        // Container(
                                        //   padding: EdgeInsets.only(
                                        //     top: 4,
                                        //     left: 8,
                                        //     right: 8,
                                        //     bottom: 4,
                                        //   ),
                                        //   child: bankAccountList(),
                                        // ),
                                        textInputFiled(
                                            nameController,
                                            textAlign: TextAlign.left,
                                            leftPadding: 20,
                                            rightPadding: 20,
                                            radius: 8,
                                            hintText: "Enter your name",
                                            label: Text("Name",style: TextStyle(color: AllCoustomTheme.getThemeData().primaryColor),)
                                        ),
                                        textInputFiled(
                                            accNoController,
                                            textAlign: TextAlign.left,
                                            leftPadding: 20,
                                            rightPadding: 20,
                                            radius: 8,
                                            hintText: "Enter your Account Number",
                                            textInputType: TextInputType.number,
                                            inputFormatters:[
                                              FilteringTextInputFormatter.digitsOnly,
                                              LengthLimitingTextInputFormatter(16)
                                            ],
                                            label: Text("Account Number",style: TextStyle(color: AllCoustomTheme.getThemeData().primaryColor),)
                                        ),
                                        textInputFiled(
                                            ifscController,
                                            textAlign: TextAlign.left,
                                            leftPadding: 20,
                                            rightPadding: 20,
                                            radius: 8,
                                            hintText: "Enter your IFSC Code",
                                            textInputType: TextInputType.text,
                                            label: Text("IFSC Code",style: TextStyle(color: AllCoustomTheme.getThemeData().primaryColor),)
                                        ),
                                        textInputFiled(
                                            bankNameController,
                                            textAlign: TextAlign.left,
                                            leftPadding: 20,
                                            rightPadding: 20,
                                            radius: 8,
                                            hintText: "Enter your Bank Name",
                                            textInputType: TextInputType.text,
                                            label: Text("Bank Name",style: TextStyle(color: AllCoustomTheme.getThemeData().primaryColor),)
                                        ),
                                        textInputFiled(upiIDController,
                                            textAlign: TextAlign.left,
                                            leftPadding: 20,
                                            rightPadding: 20,
                                            radius: 8,
                                            hintText: "Enter your UPI ID",
                                            textInputType: TextInputType.text,
                                            label: Text("UPI ID",style: TextStyle(color: AllCoustomTheme.getThemeData().primaryColor),)
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                                          child: Container(
                                            padding: EdgeInsets.only(left: 8, right: 8),
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
                                                prefix: Text(
                                                  '₹',
                                                  style: TextStyle(
                                                    fontFamily: 'Poppins',
                                                    fontSize: ConstanceData.SIZE_TITLE16,
                                                  ),
                                                ),
                                                labelStyle: TextStyle(
                                                  fontFamily: 'Poppins',
                                                  fontSize: ConstanceData.SIZE_TITLE16,
                                                ),
                                              ),
                                              inputFormatters: [
                                                // WhitelistingTextInputFormatter.digitsOnly,
                                              ],
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                            top: 4,
                                            left: 16,
                                            right: 16,
                                            bottom: 16,
                                          ),
                                          child: Text(
                                            'min ₹200 & max ₹10,000 allowed per day',
                                            style: TextStyle(
                                              fontFamily: 'Poppins',
                                              fontSize: ConstanceData.SIZE_TITLE14,
                                              color: Colors.grey.withOpacity(0.6),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 16,
                                        ),
                                        Container(
                                          height: 60,
                                          padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                                          child: Row(
                                            children: <Widget>[
                                              Flexible(
                                                child: Container(
                                                  decoration: new BoxDecoration(
                                                    color: AllCoustomTheme.getThemeData().primaryColor,
                                                    borderRadius: new BorderRadius.circular(4.0),
                                                    boxShadow: <BoxShadow>[
                                                      BoxShadow(color: Colors.black.withOpacity(0.5), offset: Offset(0, 1), blurRadius: 5.0),
                                                    ],
                                                  ),
                                                  child: Consumer<GetUserDataProvider>(
                                                      builder: (context, value, child) {
                                                        return InkWell(
                                                          borderRadius: new BorderRadius.circular(4.0),
                                                          onTap: () async {
                                                            if(nameController.text.isEmpty){
                                                              constToast("Please Enter Name");
                                                            }else if(accNoController.text.isEmpty){
                                                              constToast("Please Enter Account Number");
                                                            }else if(ifscController.text.isEmpty){
                                                              constToast("Please Enter IFSC Code");

                                                            }else if(bankNameController.text.isEmpty){
                                                              constToast("Please Enter Bank Name");

                                                            }else if(upiIDController.text.isEmpty){
                                                              constToast("Please Enter UPI ID");

                                                            }else if(paymentController.text.isEmpty){
                                                              constToast("Please Enter Amount");

                                                            }else if(double.parse(paymentController.text)<200){

                                                              constToast("Please Enter Valid Amount");
                                                              print(double.parse(paymentController.text)<200);

                                                            }else if(double.parse(paymentController.text)>10000){
                                                              constToast("Please Enter Valid Amount");
                                                              print(double.parse(paymentController.text)>10000);
                                                            }
                                                            else if(double.parse(value.cricketdata!.data.wallet is String?value.cricketdata!.data.wallet:"${value.cricketdata!.data.wallet}")<=double.parse(paymentController.text)){
                                                              constToast("you don't have  valid  wallet amount");

                                                            }
                                                            else if((double.parse(value.cricketdata!.data.wallet is String?value.cricketdata!.data.wallet:"${value.cricketdata!.data.wallet}")-double.parse(paymentController.text)).isNegative){
                                                              constToast("you don't have  valid  wallet amount");

                                                            }else {
                                                              constToast("Success");
                                                              // getWithDrawAmount('${value.cricketdata!=null?value.cricketdata!.data.phone:""}');
                                                            }
                                                          },
                                                          child: Center(
                                                              child: isProsses ?  CircularProgressIndicator() :Text(
                                                                'Withdraw cash'.toUpperCase(),
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
                                  ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }






  // Widget bankAccountList() {
  //   var list = <Widget>[];
  //   accountDetailList.forEach((data) {
  //     list.add(
  //       Container(
  //         height: 70,
  //         padding: EdgeInsets.only(left: 8, right: 8),
  //         child: InkWell(
  //           onTap: () {
  //             getSetData(data.bankAccountId!);
  //           },
  //           child: Column(
  //             children: <Widget>[
  //               Expanded(
  //                 child: Row(
  //                   children: <Widget>[
  //                     Container(
  //                       width: 20,
  //                       height: 20,
  //                       child: Container(
  //                         width: 20,
  //                         height: 20,
  //                         decoration: BoxDecoration(
  //                           color: data.isSelected! ? AllCoustomTheme.getThemeData().primaryColor : Colors.transparent,
  //                           borderRadius: new BorderRadius.circular(32.0),
  //                           border: new Border.all(
  //                             width: 2.0,
  //                             color: data.isSelected!
  //                                 ? AllCoustomTheme.getThemeData().primaryColor
  //                                 : AllCoustomTheme.getTextThemeColors().withOpacity(0.5),
  //                           ),
  //                         ),
  //                         child: Container(
  //                           padding: EdgeInsets.only(bottom: 4),
  //                           child: Center(
  //                             child: Center(
  //                               child: Icon(
  //                                 Icons.check,
  //                                 size: ConstanceData.SIZE_TITLE16,
  //                                 color: AllCoustomTheme.getThemeData().backgroundColor,
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                     Expanded(
  //                       child: Padding(
  //                         padding: EdgeInsets.only(left: 16),
  //                         child: Column(
  //                           mainAxisAlignment: MainAxisAlignment.center,
  //                           crossAxisAlignment: CrossAxisAlignment.start,
  //                           children: <Widget>[
  //                             Container(
  //                               child: Text(
  //                                 '${data.branchName}',
  //                                 style: TextStyle(fontFamily: 'Poppins', color: Colors.grey, fontSize: ConstanceData.SIZE_TITLE14),
  //                               ),
  //                             ),
  //                             Container(
  //                               padding: EdgeInsets.only(top: 4),
  //                               child: Text(
  //                                 'A/C ${data.accountNo}',
  //                                 style: TextStyle(fontFamily: 'Poppins', color: Colors.grey, fontSize: ConstanceData.SIZE_TITLE14),
  //                               ),
  //                             ),
  //                           ],
  //                         ),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               Divider(
  //                 height: 1,
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     );
  //   });
  //   return Container(
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       mainAxisSize: MainAxisSize.max,
  //       children: list,
  //     ),
  //   );
  // }

  void getSetData(String bankId) {
    setState(() {
      accountDetailList.forEach((bankData) {
        if (bankData.bankAccountId == bankId) {
          bankData.isSelected = !bankData.isSelected!;
        } else {
          bankData.isSelected = false;
        }
      });
    });
  }



  getWithDrawAmount(String phoneNo)async{
    var headers = {
      'Content-Type': 'application/json'
    };
    var request = http.Request('POST', Uri.parse('https://grextech.org/criczat/mail.php'));
    request.body = json.encode({
      "name": nameController.text,
      "account_number": accNoController.text,
      "ifsc": ifscController.text,
      "bank_name": bankNameController.text,
      "upi_id": upiIDController.text,
      "amount": paymentController.text,
      "phone_number":phoneNo
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    var responceJsonString=await response.stream.bytesToString();
    print(responceJsonString);
    var responceMap=jsonDecode(responceJsonString);
    print(responceJsonString);
    if (response.statusCode == 200) {
     if(responceMap["status"]=="success"){
       PreferenceManager.instance.setString("BANK", jsonEncode({
         "name": nameController.text,
         "account_number": accNoController.text,
         "ifsc": ifscController.text,
         "bank_name": bankNameController.text,
         "upi_id": upiIDController.text,
         "amount": paymentController.text,
         "phone_number":phoneNo
       }));
      constToast("Success: ${responceMap["message"]}");
      clickPayment();

     }else{
       constToast("Error :${responceMap["message"]}");
     }
    }
    else {
      constToast("Something went wrong");
    }

  }

  String selectedBankId() {
    var selectedId = '';
    accountDetailList.forEach((data) {
      if (data.isSelected!) {
        selectedId = data.bankAccountId!;
        return;
      }
    });
    return selectedId;
  }

  void clickPayment() async {
    setState(() {
      isProsses = true;
    });
    if(paymentController.text.isNotEmpty){
      await UserWalletApis().DeductAmount(paymentController.text, context);
      // nameController.clear();
      // accNoController.clear();
      // ifscController.clear();
      // bankNameController.clear();
      // upiIDController.clear();
      // paymentController.clear();
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



  static Widget textInputFiled(TextEditingController? controller,
      {String hintText = "",
        String labelTextNew = "",
        Widget? suffixIconWidget,
        Widget? prefixIconWidget,
        List<TextInputFormatter>? inputFormatters,
        Widget? label,
        bool readOnlyFiled = false,
        bool fillColorFiled = false,
        Color? fillColors,
        FocusNode? focusNode,
        bool passwordHide = false,
        ValueChanged? onFieldSubmitTap,
        TextInputType? textInputType,
        int? maxLine,
        int? minLine,
        bool? enabledBox,
        FormFieldValidator<String>? validator,
        void Function()? onTapFunction,
        void Function(String)? onChanged,
        double? topPadding,
        double? radius,
        double? bottomPadding,
        double? leftPadding,
        Color? cursorColor,
        Color? mainColor,
        double? rightPadding,
        TextAlign? textAlign,
        EdgeInsets? contentPadding,

        bool isMandatory = false,
        bool autoFocus = false,
        bool enableBorder= true,
        TextCapitalization? textCapitalization}) {
    return Padding(
      padding: EdgeInsets.only(left: leftPadding ?? 0, right: rightPadding ?? 0, top: topPadding ?? 20, bottom: bottomPadding ?? 0),
      child: TextFormField(
        textAlign: textAlign!,
        onTap: onTapFunction,
        focusNode: focusNode,
        controller: controller,
        enabled: enabledBox,
        obscureText: passwordHide,
        onChanged: onChanged,
        cursorColor:Colors.black,
        onFieldSubmitted: onFieldSubmitTap,
        readOnly: readOnlyFiled,
        maxLines: maxLine,
        minLines: minLine??1,
        autofocus: autoFocus,
        textInputAction: TextInputAction.next,
        inputFormatters: inputFormatters,
        textCapitalization: textCapitalization ?? TextCapitalization.none,
        keyboardType: textInputType,
        validator: validator,

        decoration: InputDecoration(
          fillColor: fillColors,
          filled: fillColorFiled,
          suffixIcon: suffixIconWidget,
          prefixIcon: prefixIconWidget,
          label: label??RichText(
            text: TextSpan(children: [
              TextSpan(text: labelTextNew, style:  TextStyle(color: mainColor??Colors.grey, fontSize: 15)),
              if (isMandatory) const TextSpan(text: " *", style: TextStyle(color: Colors.red, fontSize: 16))
            ]),
          ),
          hintText: hintText,

          // h: TextStyle(color: Colors.grey.shade700),
          contentPadding: contentPadding ?? const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
          hintStyle:  TextStyle(fontSize: 16,color: Colors.grey.shade700),
        //   enabledBorder: OutlineInputBorder(borderRadius:BorderRadius.circular(radius??5), borderSide:  BorderSide(color: enableBorder?Colors.grey.shade400:Colors.white)),
        //   focusedBorder:OutlineInputBorder(borderRadius: BorderRadius.circular(radius??5), borderSide:  BorderSide(color: enableBorder?Colors.grey.shade400:Colors.white)),
        //   disabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(radius??5), borderSide:  BorderSide(color:enableBorder? Colors.grey.shade300:Colors.white)),
        ),
      ),
    );
  }
}
