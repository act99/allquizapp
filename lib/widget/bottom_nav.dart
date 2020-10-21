import 'package:flutter/material.dart';

class Bottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double width = screenSize.width;
    double height = screenSize.height;
    return Container(
      color: Colors.black,
      child: Container(
        height: height * 0.09,
        child: TabBar(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white60,
          indicatorColor: Colors.transparent,
          tabs: <Widget>[
            Tab(
              icon: Icon(Icons.videogame_asset),
              child: Text(
                '스피드 퀴즈',
                style: TextStyle(fontSize: width * 0.038),
              ),
            ),
            Tab(
              icon: Icon(Icons.videogame_asset),
              child: Text(
                '이어 말하기',
                style: TextStyle(fontSize: width * 0.038),
              ),
            ),
            Tab(
              icon: Icon(Icons.videogame_asset),
              child: Text(
                '지식배틀',
                style: TextStyle(fontSize: width * 0.038),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
