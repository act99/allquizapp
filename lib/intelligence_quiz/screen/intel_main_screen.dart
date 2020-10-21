import 'package:allquizapp/intelligence_quiz/screen/intel_play_quiz.dart';
import 'package:allquizapp/model/firebase_service.dart';
import 'package:allquizapp/model/speedquiz_model.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class IntelMainScreen extends StatefulWidget {
  final String id;
  final String poster;
  final String title;
  IntelMainScreen(
      {@required this.id, @required this.poster, @required this.title});
  @override
  _IntelMainScreen createState() => _IntelMainScreen();
}

class _IntelMainScreen extends State<IntelMainScreen> {
  DatabaseService databaseService = new DatabaseService();
  DocumentSnapshot questionSnapshot;
  List<QNA> qnas = [];

  Quiz getQuizModelFromDataSnapshot(DocumentSnapshot quizSnapshot) {
    Quiz quiz = Quiz();
    quiz.title = quizSnapshot.data()["title"];
    quiz.poster = quizSnapshot.data()["poster"];
    quiz.id = quizSnapshot.data()["id"];

    return quiz;
  }

  @override
  void initState() {
    databaseService.getIntelGameMainQuestionData(widget.id).then((val) {
      questionSnapshot = val;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                widget.poster,
                width: MediaQuery.of(context).size.width - width * 0.3,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(width * 0.024),
            ),
            AutoSizeText(
              "지식배틀 : ${widget.title}",
              style: TextStyle(
                fontSize: width * 0.065,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
            ),
            Text(
              ' \n퀴즈를 풀기 전 안내사항입니다.',
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: EdgeInsets.all(width * 0.028),
            ),
            _buildStep(width, '1. 사회자가 문제를 출제하는 퀴즈입니다.'),
            _buildStep(width, '2. 정답을 맞추면 다음 문제 버튼을 눌러주세요.'),
            _buildStep(width, '3. 총 10문제 입니다. 만점을 향해 도전하세요!'),
            Padding(
              padding: EdgeInsets.all(width * 0.048),
            ),
            Container(
              padding: EdgeInsets.only(bottom: width * 0.036),
              child: Center(
                child: ButtonTheme(
                  minWidth: width * 0.8,
                  height: height * 0.05,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: RaisedButton(
                      child: Text(
                        '시작하기',
                        style: TextStyle(color: Colors.white),
                      ),
                      color: Colors.deepPurple,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => IntelPlayQuiz(
                                    id: widget.id,
                                    poster: widget.poster,
                                    title: widget.title,
                                    qnas: qnas)));
                      }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget _buildStep(double width, String title) {
  return Container(
    padding: EdgeInsets.fromLTRB(
      width * 0.048,
      width * 0.024,
      width * 0.048,
      width * 0.024,
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Icon(
          Icons.check_box,
          size: width * 0.04,
        ),
        Padding(
          padding: EdgeInsets.only(right: width * 0.024),
        ),
        Text(title),
      ],
    ),
  );
}
