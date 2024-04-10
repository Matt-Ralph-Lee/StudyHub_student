import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/blockings/models/blockings.dart';
import '../../../domain/blockings/models/i_blockings_repository.dart';
import '../../../domain/student/models/student_id.dart';
import '../../../domain/teacher/models/teacher_id.dart';

class FirebaseBlockingsRepository implements IBlockingsRepository {
  final db = FirebaseFirestore.instance;

  static final FirebaseBlockingsRepository _instance =
      FirebaseBlockingsRepository._internal();

  factory FirebaseBlockingsRepository() {
    return _instance;
  }

  FirebaseBlockingsRepository._internal();

  @override
  Future<Blockings?> getByStudentId(StudentId studentId) async {
    final docSnapshot =
        await db.collection("students").doc(studentId.value).get();

    final doc = docSnapshot.data();

    if (doc == null) {
      return null;
    }

    final blockingsIdListData = doc["blockings"];

    final blockingsIdList = <String>[];

    for (final blockingIdData in blockingsIdListData) {
      blockingsIdList.add(blockingIdData);
    }

    final blockingsIdSet = blockingsIdList
        .map((blockingsIdData) => TeacherId(blockingsIdData))
        .toSet();

    return Blockings(studentId: studentId, teacherIdList: blockingsIdSet);
  }

  @override
  Future<void> save(Blockings blockings) async {
    final docRef = db.collection("students").doc(blockings.studentId.value);

    final addDataList = <String>[];

    for (final blockings in blockings.teacherIdList) {
      addDataList.add(blockings.value);
    }

    await docRef.update({"blockings": addDataList});
  }
}
