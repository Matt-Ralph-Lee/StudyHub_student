import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/answer_list/models/answer_id.dart';
import '../../../domain/liked_answer/models/i_liked_answers_repository.dart';
import '../../../domain/liked_answer/models/liked_answers.dart';
import '../../../domain/student/models/student_id.dart';
import '../../exceptions/liked_answers/liked_answers_infrastructure_exception.dart';
import '../../exceptions/liked_answers/liked_answers_infrastructure_exception_detail.dart';

class FirebaseLikedAnswersRepository implements ILikedAnswersRepository {
  final db = FirebaseFirestore.instance;

  static final FirebaseLikedAnswersRepository _instance =
      FirebaseLikedAnswersRepository._internal();

  factory FirebaseLikedAnswersRepository() {
    return _instance;
  }

  FirebaseLikedAnswersRepository._internal();

  @override
  Future<void> add(StudentId studentId, AnswerId answerId) async {
    final docRef = db.collection("students").doc(studentId.value);

    await docRef.update({
      "likedAnswers": FieldValue.arrayUnion([answerId.value])
    });
  }

  @override
  Future<void> delete(StudentId studentId, AnswerId answerId) async {
    final docRef = db.collection("students").doc(studentId.value);

    await docRef.update({
      "likedAnswers": FieldValue.arrayRemove([answerId.value])
    });
  }

  @override
  Future<LikedAnswers> getByStudentId(StudentId studentId) async {
    final docSnapshot =
        await db.collection("students").doc(studentId.value).get();
    final doc = docSnapshot.data();

    if (doc == null) {
      throw const LikedAnswersInfrastructureException(
          LikedAnswersInfrastructureExceptionDetail.likedAnswersNotFound);
    }

    final likedAnswersData = doc["likedAnswers"] as List<dynamic>;

    final likedAnswers = <AnswerId>{};

    for (final likedAnswerData in likedAnswersData) {
      final likedAnswer = AnswerId(likedAnswerData);
      likedAnswers.add(likedAnswer);
    }

    return LikedAnswers(likedAnswers);
  }
}
