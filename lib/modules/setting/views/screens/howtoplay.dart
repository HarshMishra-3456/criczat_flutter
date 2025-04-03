import 'package:flutter/material.dart';

class HowToPlayScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('How to Play Cricket'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'How to Play Fantasy Cricket on Howzat Fantasy App',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Cricket is more of a religion than a sport for its millions of fans based in India. As a result, fantasy cricket has gained extreme popularity in the country within a short period of time. Indians rarely love anything as passionately as cricket and they ensure to learn even the smallest stats or detail about their favorite player.',
              ),
              Text(
                'Various Indian fantasy league platforms have tapped into the passion of such fans and helped them become winners in different fantasy cricket leagues like the Indian T20 League and the T20 World Cup.',
              ),
              SizedBox(height: 16),
              Text(
                'How Fantasy Cricket Works?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'In the fantasy cricket game, you select a virtual team by picking players from the two teams who will play the live match and compete with other participants. Your team scores points based on your players’ performance in the match. If you are a beginner, you should check out the game rules and the fantasy points system. With practice, you can easily understand how to choose the right players and become a highly-skilled player.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
