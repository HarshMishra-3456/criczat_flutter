import 'package:flutter/material.dart';
import 'package:tempalteflutter/constance/themes.dart';
import 'package:provider/provider.dart';
import 'package:tempalteflutter/modules/setting/views/provider/getfantasyhelpprovider.dart';

class FantasySelfHelp extends StatefulWidget {
  const FantasySelfHelp({super.key});

  @override
  State<FantasySelfHelp> createState() => _FantasySelfHelpState();
}

class _FantasySelfHelpState extends State<FantasySelfHelp> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<FantasyHelpProvider>(context, listen: false).gethelp();
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
          'Fantasy Self Help',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
      body: Consumer<FantasyHelpProvider>(
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
            itemBuilder: (context, index) {
              final todo = terms[index];
              return Padding(
                padding: const EdgeInsets.only(left: 15, right: 15,top: 40),
                child: Text(
                  todo.privacy,
                  textAlign: TextAlign.center,
                ),
              );
            },);
        },
      ),

    );
  }
}
