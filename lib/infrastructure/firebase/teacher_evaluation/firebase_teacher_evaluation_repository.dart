import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studyhub/domain/student/models/student_id.dart';
import 'package:studyhub/domain/teacher/models/teacher_id.dart';
import 'package:studyhub/domain/teacher_evaluation/models/teacher_evaluation.dart';
import 'package:studyhub/domain/teacher_evaluation/models/teacher_evaluation_comment.dart';
import 'package:studyhub/domain/teacher_evaluation/models/teacher_evaluation_id.dart';
import 'package:studyhub/domain/teacher_evaluation/models/teacher_evaluation_rating.dart';

import '../../../domain/teacher_evaluation/models/i_teacher_evaluation_repository.dart';

class FirebaseTeacherEvaluationRepository
    implements ITeacherEvaluationRepository {
  final db = FirebaseFirestore.instance;

  static final FirebaseTeacherEvaluationRepository _instance =
      FirebaseTeacherEvaluationRepository._internal();

  factory FirebaseTeacherEvaluationRepository() {
    return _instance;
  }

  FirebaseTeacherEvaluationRepository._internal();

  @override
  Future<TeacherEvaluationId> generateId() async {
    final docRef = db.collection("teachers").doc();
    final id = docRef.id;

    return TeacherEvaluationId(id);
  }

  @override
  Future<List<TeacherEvaluation>?> getByTeacherId(TeacherId teacherId) async {
    final querySnapshot = await db
        .collection("teachers")
        .doc(teacherId.value)
        .collection("evaluation")
        .get();

    final evaluationList = <TeacherEvaluation>[];

    for (final docSnapshot in querySnapshot.docs) {
      final doc = docSnapshot.data();

      final id = docSnapshot.reference.id;
      final from = doc["from"] as String;
      final rating = doc["rating"] as int;
      final comment = doc["comment"] as String;
      final createdAt = (doc["createdAt"] as Timestamp).toDate();

      final evaluation = TeacherEvaluation(
        id: TeacherEvaluationId(id),
        from: StudentId(from),
        to: teacherId,
        rating: TeacherEvaluationRating(rating),
        comment: TeacherEvaluationComment(comment),
        createdAt: createdAt,
      );

      evaluationList.add(evaluation);
    }

    return evaluationList;
  }

  @override
  Future<void> save(TeacherEvaluation evaluation) async {
    final teacherId = evaluation.to;

    final addData = <String, dynamic>{};

    addData["from"] = evaluation.from.value;
    addData["rating"] = evaluation.rating.value;
    addData["comment"] = evaluation.comment.value;
    addData["createdAt"] = FieldValue.serverTimestamp();

    final docRef = db
        .collection("teachers")
        .doc(teacherId.value)
        .collection("evaluation")
        .doc(evaluation.id.value);

    await docRef.set(addData);
  }
}
