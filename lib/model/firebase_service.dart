import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  getSpeedQuizData() async {
    return await FirebaseFirestore.instance.collection('speedquiz').snapshots();
  }

  getSpeedMainQuestionData(String id) async {
    return await FirebaseFirestore.instance
        .collection('speedquiz')
        .doc(id)
        .get();
  }

  getSpeedQuestionData(String id) async {
    return await FirebaseFirestore.instance
        .collection("speedquiz")
        .doc(id)
        .collection("QNA")
        .doc()
        .get();
  }

  getIntelGameData() async {
    return await FirebaseFirestore.instance.collection('intelgame').snapshots();
  }

  getIntelGameMainQuestionData(String id) async {
    return await FirebaseFirestore.instance
        .collection('intelgame')
        .doc(id)
        .get();
  }

  getIntelGameQuestionData(String id) async {
    return await FirebaseFirestore.instance
        .collection("intelgame")
        .doc(id)
        .collection("QNA")
        .doc()
        .get();
  }

  getSaytoSayData() async {
    return await FirebaseFirestore.instance.collection('saytosay').snapshots();
  }

  getSaytoSayMainData(String id) async {
    return await FirebaseFirestore.instance
        .collection('saytosay')
        .doc(id)
        .get();
  }

  getSaytoSayQuestionData(String id) async {
    return await FirebaseFirestore.instance
        .collection("saytosay")
        .doc(id)
        .collection("QNA")
        .doc()
        .get();
  }
}
