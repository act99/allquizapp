import 'dart:async';
import 'package:allquizapp/model/firebase_service.dart';
import 'package:allquizapp/speed_quiz/widget/speedbox_list.dart';
import 'package:flutter/material.dart';

class SpeedQuizHomeScreen extends StatefulWidget {
  @override
  _SpeedQuizHomeScreen createState() => _SpeedQuizHomeScreen();
}

class _SpeedQuizHomeScreen extends State<SpeedQuizHomeScreen> {
  Stream quizStream;
  DatabaseService databaseService = new DatabaseService();

  @override
  void initState() {
    databaseService.getSpeedQuizData().then((val) {
      setState(() {
        quizStream = val;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    return SafeArea(
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [
                  Color(0xFF1c2331),
                  Color(0xFFfbab66),
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 1.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              TopBar(),
              SpeedBoxList(),
            ],
          ),
        ),
      ),
    );
  }
}

class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return Container(
      padding:
          EdgeInsets.fromLTRB(width * 0.045, height * 0.05, width * 0.045, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '스피드 Quiz',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: width * 0.085),
          ),
          Container(
            padding: EdgeInsets.all(height * 0.01),
          ),
          Text(
            '뒷풀이&회식자리&MT&여행에서\nMC들을 위한 재밌고 다양한 스피드 퀴즈 제시어',
            style: TextStyle(
                color: Colors.white30,
                fontWeight: FontWeight.bold,
                fontSize: width * 0.045),
          ),
          SizedBox(
            height: height * 0.06,
          ),
          Text(
            '  주제 \n',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: width * 0.065),
          ),
        ],
      ),
    );
  }
}
