import 'dart:ui';

import 'package:allquizapp/main.dart';
import 'package:allquizapp/model/firebase_service.dart';
import 'package:allquizapp/model/speedquiz_model.dart';
import 'package:allquizapp/widget/all_admob.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class SpeedPlayQuizScreen extends StatefulWidget {
  List<QNA> qnas;
  final String id;
  final String poster;
  final String title;
  SpeedPlayQuizScreen({
    @required this.id,
    @required this.poster,
    @required this.title,
    this.qnas,
  });

  @override
  _SpeedPlayQuizScreen createState() => _SpeedPlayQuizScreen();
}

class _SpeedPlayQuizScreen extends State<SpeedPlayQuizScreen> {
  DatabaseService databaseService = new DatabaseService();
  Stream<QuerySnapshot> streamData;
  SwiperController _controller = SwiperController();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    streamData = FirebaseFirestore.instance
        .collection('speedquiz')
        .doc(widget.id)
        .collection('QNA')
        .snapshots();
  }

  Widget _fetchData(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('speedquiz')
          .doc(widget.id)
          .collection('QNA')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return _buildBody(context, snapshot.data.docs);
      },
    );
  }

  Widget _buildBody(BuildContext context, List<DocumentSnapshot> snapshot) {
    List<QNA> qnas = snapshot.map((d) => QNA.fromSnapshot(d)).toList()
      ..shuffle();
    String poster = widget.poster;
    return SpeedQuizList(qnas: qnas, poster: poster);
  }

  @override
  Widget build(BuildContext context) {
    return _fetchData(context);
  }
}

class SpeedQuizList extends StatefulWidget {
  final List<QNA> qnas;
  final String poster;
  SpeedQuizList({this.qnas, this.poster});

  @override
  _SpeedQuizListState createState() => _SpeedQuizListState();
}

class _SpeedQuizListState extends State<SpeedQuizList> {
  final ams = AdMobService();
  List<QNA> qnas;
  List<String> body;
  List<String> candidate;
  List<String> answer;
  int _currentPage = 0;
  SwiperController _controller = SwiperController();
  String _currentbody;
  String _currentcandidate;
  String _currentanswer;

  @override
  void initState() {
    super.initState();
    qnas = widget.qnas;
    body = qnas.map((e) => e.body).toList();
    candidate = qnas.map((e) => e.candidate).toList();
    answer = qnas.map((e) => e.answer).toList();
    _currentbody = body[0];
    _currentcandidate = candidate[0];
    _currentanswer = answer[0];
  }

  @override
  Widget build(BuildContext context) {
    InterstitialAd newItemAd = ams.getNewItemInterstitial();
    newItemAd.load();
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: Stack(
          children: [
            Container(
              width: double.maxFinite,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.poster),
                  fit: BoxFit.cover,
                ),
              ),
              child: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    alignment: Alignment.center,
                    color: Colors.black.withOpacity(0.1),
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              width: width * 0.85,
                              height: height * 0.5,
                              child: Swiper(
                                controller: _controller,
                                physics: NeverScrollableScrollPhysics(),
                                loop: false,
                                itemCount: 10,
                                onIndexChanged: (index) {
                                  setState(() {
                                    _currentPage = index;
                                    _currentbody = body[_currentPage];
                                    _currentcandidate = candidate[_currentPage];
                                    _currentanswer = answer[_currentPage];
                                  });
                                },
                                itemBuilder: (context, index) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.fromLTRB(
                                          0, width * 0.024, 0, width * 0.024),
                                      child: Text(
                                        'Q' +
                                            (_currentPage + 1).toString() +
                                            '.',
                                        style: TextStyle(
                                          fontSize: width * 0.06,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(),
                                    ),
                                    Container(
                                      width: width * 0.8,
                                      padding:
                                          EdgeInsets.only(top: width * 0.042),
                                      child: AutoSizeText(
                                        "${answer[_currentPage]}",
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        style: TextStyle(
                                          fontSize: width * 0.078,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(width * 0.024),
                                      child: Center(
                                        child: ButtonTheme(
                                          minWidth: width * 0.5,
                                          height: height * 0.05,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: RaisedButton(
                                            child: _currentPage == 9
                                                ? Text('홈으로')
                                                : Text('다음문제'),
                                            textColor: Colors.white,
                                            color: Colors.deepPurple,
                                            onPressed: () async {
                                              if (_currentPage == 9) {
                                                newItemAd.show(
                                                  anchorType: AnchorType.bottom,
                                                  anchorOffset: 0.0,
                                                  horizontalCenterOffset: 0.0,
                                                );
                                                Navigator.of(context).popUntil(
                                                    (route) => route.isFirst);
                                              } else {
                                                _currentPage += 1;
                                                _controller.next();
                                              }
                                            },
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
