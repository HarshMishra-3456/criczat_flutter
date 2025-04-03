import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tempalteflutter/constance/themes.dart';
import 'package:tempalteflutter/core/Utils/constants.dart';
import 'package:tempalteflutter/modules/myProfile/views/provider/getuserprovider.dart';
import 'package:provider/provider.dart';

class ReferAndPrograms extends StatefulWidget {
  const ReferAndPrograms({super.key});

  @override
  State<ReferAndPrograms> createState() => _ReferAndProgramsState();
}

class _ReferAndProgramsState extends State<ReferAndPrograms> {
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
          'Refer & Earn',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Center(
                child: Image.asset(
              'assets/offerprograms.png',
              fit: BoxFit.cover,
            )),
            SizedBox(
              height: 20,
            ),
            Text(
              'Earn Money',
              style: TextStyle(
                  color: AllCoustomTheme.getThemeData().primaryColor,
                  fontSize: 32,
                  fontWeight: FontWeight.w700),
            ),
            Text(
              'By Refer',
              style: TextStyle(
                  color: AllCoustomTheme.getThemeData().primaryColor,
                  fontSize: 32,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 20,
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
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Container(
                        height: 50,
                        width: 250,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              todo.refferalCode ?? '',
                              style: TextStyle(
                                color: AllCoustomTheme.getThemeData().primaryColor,
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(width: 8),
                            GestureDetector(
                              onTap: () {
                                Clipboard.setData(ClipboardData(text: todo.refferalCode));
                                constToast('Copied to clipboard');
                              },
                              child: Text(
                                'Copy',
                                style: TextStyle(
                                  color: AllCoustomTheme.getThemeData().primaryColor,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        ByteData imagebyte =
                            await rootBundle.load('assets/appicon.png');
                        final temp = await getTemporaryDirectory();
                        final path = '${temp.path}/appicon.png';
                        File(path)
                            .writeAsBytesSync(imagebyte.buffer.asUint8List());
                        await Share.shareFiles([path],
                            text: 'Ready to play? '
                                'Use my invite code ${todo.refferalCode}');
                      },
                      child: Container(
                        height: 50,
                        width: 70,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: AllCoustomTheme.getThemeData().primaryColor,
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          'SHARE',
                          style: TextStyle(color: Colors.white, fontSize: 14),
                        ),
                      ),
                    )
                  ],
                );
              },
            ),
            SizedBox(
              height: 20,
            ),
            // ListView.builder(
            //   itemCount: 5,
            //   shrinkWrap: true,
            //   itemBuilder: (context, index) {
            //     return Padding(
            //       padding: const EdgeInsets.only(top: 10,left: 30,right: 30),
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Row(
            //             children: [
            //               CircleAvatar(
            //                 backgroundColor: Colors.red,
            //               ),
            //               SizedBox(
            //                 width: 20,
            //               ),
            //               Column(
            //                 crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   Text(
            //                     'TongKun Lee',
            //                     style:
            //                     TextStyle(color: Colors.black, fontSize: 18),
            //                   ),
            //                   Text(
            //                     'Facebook',
            //                     style:
            //                     TextStyle(color: Colors.grey, fontSize: 16),
            //                   ),
            //                 ],
            //               )
            //             ],
            //           ),
            //           Container(
            //             height: 45,
            //             width: 70,
            //             decoration: BoxDecoration(
            //               color: Colors.pink.shade50,
            //               borderRadius: BorderRadius.circular(20)
            //             ),
            //             alignment: Alignment.center,
            //             child: Text(
            //               'Invite',
            //               style: TextStyle(color: Colors.black, fontSize: 18),
            //             ),
            //           ),
            //         ],
            //       ),
            //     );
            //   },
            // )
          ],
        ),
      ),
    );
  }
}
