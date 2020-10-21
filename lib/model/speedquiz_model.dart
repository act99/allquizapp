import 'package:cloud_firestore/cloud_firestore.dart';

class Quiz {
  String id;
  String poster;
  String title;
}

class QNA {
  final String title;
  final String body;
  final String candidate;
  final String answer;
  final DocumentReference reference;

  QNA.fromMap(Map<String, dynamic> map, {this.reference})
      : title = map['title'],
        body = map['body'],
        candidate = map['candidate'],
        answer = map['answer'];

  QNA.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data(), reference: snapshot.reference);

  @override
  String toString() => "QNA<$title:$body>";
}
