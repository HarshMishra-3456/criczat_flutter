// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tempalteflutter/constance/constance.dart';
import 'package:tempalteflutter/constance/themes.dart';
import 'package:tempalteflutter/core/Utils/authutilities.dart';
import 'package:tempalteflutter/modules/myProfile/views/provider/getusernotificationprovider.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<GetUserNotificationProvider>(context, listen: false)
          .getnotification();
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
      child: Stack(
        children: <Widget>[
          SafeArea(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
                title: Text(
                  'Notification',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Colors.white
                  ),
                ),
                leading: Material(
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
              ),
              backgroundColor: AllCoustomTheme.getThemeData().colorScheme.background,
              body: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: <Widget>[
                  SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: <Widget>[
                        Consumer<GetUserNotificationProvider>(
                          builder: (context, value, child) {
                            if (value.isLoading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            final notification = value.todos;
                            if (notification == null || notification.isEmpty) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: const Center(
                                  child: Text(
                                    'No data found',
                                    style: TextStyle(
                                        fontFamily: 'Poppins', fontSize: 20),
                                  ),
                                ),
                              );
                            }

                            return ListView.builder(
                              reverse: true,
                              shrinkWrap: true,
                              physics: BouncingScrollPhysics(),
                              itemCount: notification.length,
                              itemBuilder: (context, index) {
                                final todo = notification[index];
                                return Container(
                                  constraints: BoxConstraints(minHeight: 60),
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        padding: EdgeInsets.all(8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              height: 55,
                                              width: 55,
                                              alignment: Alignment.topCenter,
                                              child: Container(
                                                width: 36,
                                                height: 40,
                                                padding:
                                                    EdgeInsets.only(top: 4),
                                                child: Image.asset(
                                                  ConstanceData.notificationCup,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 4),
                                                    child: Text(
                                                      todo.body,
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        color: AllCoustomTheme
                                                            .getBlackAndWhiteThemeColors(),
                                                        fontSize: ConstanceData
                                                            .SIZE_TITLE14,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 4, top: 4),
                                                    child: Text(
                                                      formatDateStringToMonthName(
                                                          todo.createdAt
                                                              .toString()
                                                              .substring(
                                                                  0, 10)),
                                                      textAlign:
                                                          TextAlign.start,
                                                      style: TextStyle(
                                                        fontFamily: 'Poppins',
                                                        color: AllCoustomTheme
                                                            .getTextThemeColors(),
                                                        fontSize: ConstanceData
                                                            .SIZE_TITLE14,
                                                      ),
                                                    ),
                                                  )
                                                ],
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
                                );
                              },
                            );
                          },
                        ),
                      ],
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
}
