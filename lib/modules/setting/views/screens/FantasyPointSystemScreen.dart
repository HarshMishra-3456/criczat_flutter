// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:tempalteflutter/constance/themes.dart';
import 'package:provider/provider.dart';
import 'package:tempalteflutter/modules/setting/views/provider/privacypolicyprovider.dart';
import 'package:tempalteflutter/modules/setting/views/provider/termsandconditionprovider.dart';

class FantasyPointSystemScreen extends StatefulWidget {
  @override
  _FantasyPointSystemScreenState createState() => _FantasyPointSystemScreenState();
}

class _FantasyPointSystemScreenState extends State<FantasyPointSystemScreen> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<PrivacyPolicyProvider>(context, listen: false).getprivacy();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back_outlined,
              color: Colors.white,
            )),
        backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
        title: Text(
          'Privacy & Policy',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            Consumer<PrivacyPolicyProvider>(
              builder: (context, value, child) {
                if (value.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final terms = value.todos;
                if (terms == null) {
                  return const Center(
                    child: Text('No data found'),
                  );
                }

                return ListView.builder(
                  itemCount: terms.length,
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final todo = terms[index];
                  return Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15,top: 10),
                    child: Text(
                      todo.privacy,
                      textAlign: TextAlign.center,
                    ),
                  );
                },);
              },
            ),
          ],
        ),
      ),
    );
  }
}
