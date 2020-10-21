import 'package:allquizapp/intelligence_quiz/screen/intel_home_screen.dart';
import 'package:allquizapp/saytosay_quiz/screen/saytosay_home_screen.dart';
import 'package:allquizapp/speed_quiz/screen/speed_quiz_home_screen.dart';
import 'package:allquizapp/widget/all_admob.dart';
import 'package:allquizapp/widget/bottom_nav.dart';
import 'package:firebase_admob/firebase_admob.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseAdMob.instance.initialize(appId: AdMobService().getAdMobAppId());
  await Firebase.initializeApp();
  runApp(Myapp());
}

class Myapp extends StatefulWidget {
  @override
  _MyappState createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  TabController controller;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        accentColor: Colors.white,
      ),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          body: SafeArea(
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: <Widget>[
                SpeedQuizHomeScreen(),
                SaytoSayHomeScreen(),
                IntelHomeScreen(),
              ],
            ),
          ),
          bottomNavigationBar: Bottom(),
        ),
      ),
    );
  }
}
