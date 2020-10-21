import 'dart:async';
import 'package:allquizapp/intelligence_quiz/screen/intel_main_screen.dart';
import 'package:allquizapp/model/firebase_service.dart';
import 'package:allquizapp/speed_quiz/screen/speed_play_main_screen.dart';
import 'package:flutter/material.dart';

class IntelBoxList extends StatefulWidget {
  @override
  _IntelBoxList createState() => _IntelBoxList();
}

class _IntelBoxList extends State<IntelBoxList> {
  Stream quizStream;
  DatabaseService databaseService = new DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: StreamBuilder(
        stream: quizStream,
        builder: (context, snapshot) {
          return snapshot.data == null
              ? Container()
              : Container(
                  child: Column(children: [
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context, index) {
                          return IntelBoxTile(
                            title:
                                snapshot.data.documents[index].data()["title"],
                            poster:
                                snapshot.data.documents[index].data()["poster"],
                            id: snapshot.data.documents[index].data()["id"],
                          );
                        }),
                  ]),
                );
        },
      ),
    );
  }

  @override
  void initState() {
    databaseService.getIntelGameData().then((val) {
      setState(() {
        quizStream = val;
      });
    });
    super.initState();
  }
}

class IntelBoxTile extends StatelessWidget {
  final String title;
  final String poster;
  final String id;

  IntelBoxTile(
      {@required this.title, @required this.poster, @required this.id});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    return Container(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => IntelMainScreen(
                  id: id,
                  poster: poster,
                  title: title,
                ),
              ));
        },
        child: Container(
          margin: EdgeInsets.only(bottom: height * 0.02),
          height: height * 0.23,
          child: Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  poster,
                  width: MediaQuery.of(context).size.width - width * 0.07,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(8)),
                //color: Colors.blue,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: width * 0.07,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
