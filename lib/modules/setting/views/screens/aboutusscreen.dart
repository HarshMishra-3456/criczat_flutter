import 'package:flutter/material.dart';
import 'package:tempalteflutter/constance/themes.dart';
import 'package:provider/provider.dart';
import 'package:tempalteflutter/modules/setting/views/provider/aboutusprovider.dart';


class AboutUsPage extends StatefulWidget {
  @override
  State<AboutUsPage> createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<GetAboutUsProvider>(context, listen: false).getabout();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
        leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_rounded,color: Colors.white,)),
        title: Text('About Us',style: TextStyle(color: Colors.white),),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(height: 40,),
            Consumer<GetAboutUsProvider>(
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
                        todo.aboutUs,
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
