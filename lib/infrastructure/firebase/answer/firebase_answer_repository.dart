import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studyhub/domain/answer_list/models/answer_like.dart';
import 'package:studyhub/domain/answer_list/models/answer_photo_path.dart';
import 'package:studyhub/domain/answer_list/models/answer_photo_path_list.dart';
import 'package:studyhub/domain/answer_list/models/answer_text.dart';
import 'package:studyhub/domain/teacher/models/teacher_id.dart';

import '../../../domain/answer_list/models/answer.dart';
import '../../../domain/answer_list/models/answer_id.dart';
import '../../../domain/answer_list/models/i_answer_repository.dart';
import '../../../domain/question/models/question_id.dart';

class FirebaseAnswerRepository implements IAnswerRepository {
  final db = FirebaseFirestore.instance;

  static final FirebaseAnswerRepository _instance =
      FirebaseAnswerRepository._internal();

  factory FirebaseAnswerRepository() {
    return _instance;
  }

  FirebaseAnswerRepository._internal();

  @override
  Future<void> incrementAnswerLike({
    required AnswerId answerId,
    required QuestionId questionId,
  }) async {
    final docRef = db
        .collection("all_questions")
        .doc(questionId.value)
        .collection("answer")
        .doc(answerId.value);

    await docRef.update({"like": FieldValue.increment(1)});
  }

  @override
  Future<void> decrementAnswerLike({
    required AnswerId answerId,
    required QuestionId questionId,
  }) async {
    final docRef = db
        .collection("all_questions")
        .doc(questionId.value)
        .collection("answer")
        .doc(answerId.value);

    await docRef.update({"like": FieldValue.increment(-1)});
  }

  @override
  Future<void> evaluated({
    required final AnswerId answerId,
    required final QuestionId questionId,
  }) async {
    final docRef = db
        .collection("all_questions")
        .doc(questionId.value)
        .collection("answer")
        .doc(answerId.value);

    await docRef.update({"evaluated": true});
  }

  @override
  Future<List<Answer>> getByQuestionId(QuestionId questionId) async {
    final collectionRef = db
        .collection("all_questions")
        .doc(questionId.value)
        .collection("answer");

    final answerSnapshot = await collectionRef.get();
    final answers = <Answer>[];

    for (final docSnapshot in answerSnapshot.docs) {
      final doc = docSnapshot.data();

      final answerId = docSnapshot.reference.id;
      final evaluated = doc["evaluated"] as bool;
      final images = doc["images"] as List<dynamic>;
      final like = doc["like"] as int;
      final teacherId = doc["teacherId"] as String;
      final text = doc["text"] as String;

      final answer = Answer(
        answerId: AnswerId(answerId),
        questionId: questionId,
        answerText: AnswerText(text),
        answerPhotoPathList: AnswerPhotoPathList(
            [for (final imagePath in images) AnswerPhotoPath(imagePath)]),
        like: AnswerLike(like),
        teacherId: TeacherId(teacherId),
        evaluated: evaluated,
      );

      answers.add(answer);
    }

    return answers;
  }
}
