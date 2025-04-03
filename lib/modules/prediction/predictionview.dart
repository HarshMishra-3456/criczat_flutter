import 'package:flutter/material.dart';
import 'package:tempalteflutter/constance/themes.dart';

class PredictionScreen extends StatefulWidget {
  const PredictionScreen({Key? key}) : super(key: key);

  @override
  State<PredictionScreen> createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  bool no = false;
  bool yes = false;
  bool yes1 = false;
  bool no1 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AllCoustomTheme.getThemeData().primaryColor,
        title: Text(
          'Prediction Q&A',
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
        child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20,bottom: 40),
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      '1.  Which Team will win the Match?',
                      style: TextStyle(
                          fontFamily: 'Mulish',
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          'WI',
                          style: TextStyle(
                              fontFamily: 'Mulish',
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              no = !no;
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 70,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: no ? Colors.white : Color(0xFF064475)),
                              borderRadius: BorderRadius.circular(10),
                              color: no ? Color(0xFF064475) : Colors.white,
                            ),
                            child: Text(
                              'Yes',
                              style: TextStyle(
                                  color: no ? Colors.white : Color(0xFF064475),
                                  fontSize: 15),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Visibility(
                          visible: no,
                          child: Container(
                            width: 70,
                            height: 8,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 2.0),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: 0.9,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFF064475),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              no1 = !no1;
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 70,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: no1 ? Colors.white : Color(0xFF064475)),
                              borderRadius: BorderRadius.circular(10),
                              color: no1 ? Color(0xFF064475) : Colors.white,
                            ),
                            child: Text(
                              'No',
                              style: TextStyle(
                                  color: no1 ? Colors.white : Color(0xFF064475),
                                  fontSize: 15),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Visibility(
                          visible: no1,
                          child: Container(
                            width: 70,
                            height: 8,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 2.0),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: 0.9,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFF064475),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          'WI',
                          style: TextStyle(
                              fontFamily: 'Mulish',
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              yes = !yes;
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 70,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: yes ? Colors.white : Color(0xFF064475)),
                              borderRadius: BorderRadius.circular(10),
                              color: yes ? Color(0xFF064475) : Colors.white,
                            ),
                            child: Text(
                              'Yes',
                              style: TextStyle(
                                  color: yes ? Colors.white : Color(0xFF064475),
                                  fontSize: 15),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Visibility(
                          visible: yes,
                          child: Container(
                            width: 70,
                            height: 8,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 2.0),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: 0.9,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFF064475),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              yes1 = !yes1;
                            });
                          },
                          child: Container(
                            height: 40,
                            width: 70,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: yes1 ? Colors.white : Color(0xFF064475)),
                              borderRadius: BorderRadius.circular(10),
                              color: yes1 ? Color(0xFF064475) : Colors.white,
                            ),
                            child: Text(
                              'No',
                              style: TextStyle(
                                  color: yes1 ? Colors.white : Color(0xFF064475),
                                  fontSize: 15),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Visibility(
                          visible: yes1,
                          child: Container(
                            width: 70,
                            height: 8,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 2.0),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: FractionallySizedBox(
                              alignment: Alignment.centerLeft,
                              widthFactor: 0.9,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFF064475),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          'Current Prediction',
                          style: TextStyle(
                            fontFamily: 'Mulish',
                            fontSize: 12,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Image.asset(
                          'assets/Group 185.png',
                          fit: BoxFit.cover,
                          height: 30,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          '120 members',
                          style: TextStyle(
                            fontFamily: 'Mulish',
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            )),
      ),
    );
  }
}
