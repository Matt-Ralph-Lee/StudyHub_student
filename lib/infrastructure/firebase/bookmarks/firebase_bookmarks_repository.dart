import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studyhub/domain/bookmarks/models/bookmarks.dart';
import 'package:studyhub/domain/student/models/student_id.dart';

import '../../../domain/bookmarks/models/i_bookmarks_repository.dart';
import '../../../domain/question/models/question_id.dart';

class FirebaseBookmarksRepository implements IBookmarksRepository {
  final db = FirebaseFirestore.instance;

  static final FirebaseBookmarksRepository _instance =
      FirebaseBookmarksRepository._internal();

  factory FirebaseBookmarksRepository() {
    return _instance;
  }

  FirebaseBookmarksRepository._internal();

  @override
  Future<Bookmarks?> getByStudentId(StudentId studentId) async {
    final docSnapshot =
        await db.collection("students").doc(studentId.value).get();

    final doc = docSnapshot.data();

    if (doc == null) {
      return null;
    }

    final bookmarkIdListData = doc["bookmarks"];

    final bookmarkIdList = <String>[];

    for (final bookmarkIdData in bookmarkIdListData) {
      bookmarkIdList.add(bookmarkIdData);
    }

    final bookmarkIdSet = bookmarkIdList
        .map((bookmarkIdData) => QuestionId(bookmarkIdData))
        .toSet();

    return Bookmarks(studentId: studentId, questionIdSet: bookmarkIdSet);
  }

  @override
  Future<void> save(Bookmarks bookmarks) async {
    final docRef = db.collection("students").doc(bookmarks.studentId.value);

    final addDataList = <String>[];

    for (final bookmark in bookmarks.questionIdSet) {
      addDataList.add(bookmark.value);
    }

    await docRef.update({"bookmarks": addDataList});
  }
}
