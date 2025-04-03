import 'package:flutter/material.dart';
import 'package:tempalteflutter/constance/themes.dart';
import 'package:provider/provider.dart';
import 'package:tempalteflutter/modules/drawer/views/provider/getoffersprovider.dart';

class OfferAndPrograms extends StatefulWidget {
  const OfferAndPrograms({super.key});

  @override
  State<OfferAndPrograms> createState() => _OfferAndProgramsState();
}

class _OfferAndProgramsState extends State<OfferAndPrograms> {


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<GetOffersandProgramProvider>(context, listen: false).getoffer();
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
          'Offer & Programs',
          style: TextStyle(
            fontFamily: 'Poppins',
            color: Colors.white,
          ),
        ),
      ),
      body: Consumer<GetOffersandProgramProvider>(
        builder: (context, value, child) {
          if (value.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final offers = value.todos;
          if (offers == null) {
            return const Center(
              child: Text('No data found'),
            );
          }

          return ListView.builder(
            itemCount: offers.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final todo = offers[index];
              return Padding(
                padding: const EdgeInsets.only(left: 20,right: 20),
                child: Image.network(todo.image,fit: BoxFit.cover,),
              );
            },);
        },
      ),

    );
  }
}
