import 'package:flutter/material.dart';
import 'package:tempalteflutter/constance/themes.dart';
import 'package:provider/provider.dart';
import 'package:tempalteflutter/modules/setting/views/provider/getfaqprovider.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<FantasyFaqProvider>(context, listen: false).getfaq();
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
          'FAQ',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
      body: Consumer<FantasyFaqProvider>(
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
              return Container(
                margin: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Q: ${todo.question}",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      "A: ${todo.answer}",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              );
            },);
        },
      ),
    );
  }
}
