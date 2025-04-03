import 'package:flutter/material.dart';
import 'package:tempalteflutter/constance/themes.dart';
import 'package:provider/provider.dart';
import 'package:tempalteflutter/modules/setting/views/provider/getlegalityprovider.dart';

class LegalityScreen extends StatefulWidget {
  const LegalityScreen({Key? key}) : super(key: key);

  @override
  State<LegalityScreen> createState() => _LegalityScreenState();
}

class _LegalityScreenState extends State<LegalityScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<FantasyLegalityProvider>(context, listen: false)
          .getlegality();
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
            child: Icon(Icons.arrow_back_rounded,color: Colors.white,)),
        backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
        title: Text(
          'Legality',
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
        child: Consumer<FantasyLegalityProvider>(
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
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 40),
                  child: Text(
                    todo.privacy,
                    textAlign: TextAlign.center,
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
