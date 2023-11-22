import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class FirestoreService {
  final db = FirebaseFirestore.instance;

  /* Read 読み出し */
  Future<void> read() async {
    final doc =
        await db.collection('all_questions').doc('7suE2Wo8ugMf9VhxQvEz').get();
    final question = doc.data().toString();
    debugPrint(question);
  }
}
