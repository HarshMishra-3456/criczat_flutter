import 'package:flutter/material.dart';
import 'package:tempalteflutter/constance/themes.dart';

class PointSystemScreen extends StatelessWidget {
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
        title: Text('Point System',style: TextStyle(color: Colors.white),),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          Text(
            'Cricket Fantasy Point System',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10.0),
          PointCategory(
            title: 'Batting',
            points: {
              'Runs': '1 point',
              'Four Bonus': '1 point',
              'Six Bonus': '2 points',
              '30 runs bonus': '4 points',
              'Half-century Bonus': '8 points',
              'Century Bonus': '16 points',
              'Dismissal for duck (excluding bowlers)': '-2 points',
            },
          ),
          PointCategory(
            title: 'Bowling',
            points: {
              'Wicket (except run-out)': '25 points',
              'Maiden over Bonus': '12 points',
              'LBW/Bowled Bonus': '8 points',
              '3-wicket haul Bonus': '4 points',
              '4-wicket haul Bonus': '8 points',
              '5-wicket haul Bonus': '16 points',
            },
          ),
          PointCategory(
            title: 'Fielding',
            points: {
              'Catch': '8 points',
              '3 catch bonus': '4 points',
              'Stumping': '12 points',
              'Run-out (Direct)': '12 points',
              'Run-out (Multiple players involved)': '6 points',
            },
          ),
        ],
      ),
    );
  }
}

class PointCategory extends StatelessWidget {
  final String title;
  final Map<String, String> points;

  PointCategory({required this.title, required this.points});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,fontFamily: 'Times New Roman', ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: points.entries.map((entry) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    entry.key,
                    style:
                        TextStyle(fontFamily: 'Times New Roman', fontSize: 14),
                  ),
                  Text(
                    entry.value,
                    style:
                        TextStyle(fontFamily: 'Times New Roman', fontSize: 14),
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
