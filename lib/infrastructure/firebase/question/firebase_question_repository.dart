import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/answer_list/models/answer_id.dart';
import '../../../domain/answer_list/models/answer_list.dart';
import '../../../domain/question/models/i_question_repository.dart';
import '../../../domain/question/models/question.dart';
import '../../../domain/question/models/question_id.dart';
import '../../../domain/question/models/question_photo_path.dart';
import '../../../domain/question/models/question_photo_path_list.dart';
import '../../../domain/question/models/question_text.dart';
import '../../../domain/question/models/question_title.dart';
import '../../../domain/question/models/seen_count.dart';
import '../../../domain/question/models/selected_teacher_list.dart';
import '../../../domain/shared/subject.dart';
import '../../../domain/student/models/student_id.dart';
import '../../../domain/teacher/models/teacher_id.dart';
import '../../shared/utils/create_token_map.dart';
import '../answer/firebase_answer_repository.dart';

class FirebaseQuestionRepository implements IQuestionRepository {
  final db = FirebaseFirestore.instance;
  final FirebaseAnswerRepository _answerRepository = FirebaseAnswerRepository();

  static final FirebaseQuestionRepository _instance =
      FirebaseQuestionRepository._internal();

  factory FirebaseQuestionRepository() {
    return _instance;
  }

  FirebaseQuestionRepository._internal();

  @override
  Future<void> delete(QuestionId questionId) async {
    final docRef = db.collection("all_questions").doc(questionId.value);
    await docRef.delete();
  }

  @override
  Future<Question?> findById(QuestionId questionId) async {
    final docSnapshot =
        await db.collection("all_questions").doc(questionId.value).get();
    final doc = docSnapshot.data();

    if (doc == null) return null;

    final answerListData = await _answerRepository.getByQuestionId(questionId);
    final answerList = AnswerList(answerListData);

    final imagesData = doc["images"] as List<dynamic>;
    final questionPhotoPathListData =
        imagesData.map((imageData) => QuestionPhotoPath(imageData)).toList();
    final questionPhotoPathList =
        QuestionPhotoPathList(questionPhotoPathListData);

    final resolved = doc["resolved"] as bool;

    final seenCoundData = doc["seenCount"] as int;
    final seenCount = SeenCount(seenCoundData);

    final selectedTeacherData = doc["selectedTeacher"] as List<dynamic>;
    final selectedTeacherListData = selectedTeacherData
        .map((selectedTeacher) => TeacherId(selectedTeacher))
        .toList();
    final selectedTeacherList = SelectedTeacherList(selectedTeacherListData);

    final studentIdData = doc["studentId"] as String;
    final studentId = StudentId(studentIdData);

    final subjectData = doc["subject"];
    Subject subject = Subject.highEng;
    if (subjectData == Subject.highEng.japanese) {
      subject = Subject.highEng;
    }
    if (subjectData == Subject.highMath.japanese) {
      subject = Subject.highMath;
    }
    if (subjectData == Subject.midEng.japanese) {
      subject = Subject.midEng;
    }
    if (subjectData == Subject.midMath.japanese) {
      subject = Subject.midMath;
    }

    final textData = doc["text"] as String;
    final text = QuestionText(textData);

    final titleData = doc["title"] as String;
    final title = QuestionTitle(titleData);

    final question = Question(
      questionId: questionId,
      questionSubject: subject,
      questionTitle: title,
      questionText: text,
      questionPhotoPathList: questionPhotoPathList,
      studentId: studentId,
      answerList: answerList,
      seenCount: seenCount,
      selectedTeacherList: selectedTeacherList,
      resolved: resolved,
    );

    return question;
  }

  @override
  Future<QuestionId> generateId() async {
    final docRef = db.collection("all_questions").doc();
    final id = docRef.id;

    return QuestionId(id);
  }

  @override
  Future<void> save(Question question) async {
    final addData = <String, dynamic>{};

    final answerIdList = <AnswerId>[];
    for (final answerId in question.answerList) {
      answerIdList.add(answerId.answerId);
    }

    addData["answerList"] = [
      for (final answerId in answerIdList) answerId.value
    ];

    addData["createdAt"] = FieldValue.serverTimestamp();
    addData["images"] = [
      for (final photoPath in question.questionPhotoPathList) photoPath.value
    ];

    addData["resolved"] = question.resolved;
    addData["seenCount"] = question.seenCount.value;

    addData["selectedTeacher"] = [
      for (final selectedTeacher in question.selectedTeacherList)
        selectedTeacher.value
    ];

    addData["studentId"] = question.studentId.value;
    addData["subject"] = question.questionSubject.japanese;
    addData["text"] = question.questionText.value;
    addData["textTokenMap"] = createTokenMap(question.questionText.value);
    addData["title"] = question.questionTitle.value;
    addData["titleTokenMap"] = createTokenMap(question.questionTitle.value);

    await db
        .collection("all_questions")
        .doc(question.questionId.value)
        .set(addData);
  }

  @override
  Future<void> resolveQuestion(QuestionId questionId) async {
    await db
        .collection("all_questions")
        .doc(questionId.value)
        .update({"resolved": true});
  }

  @override
  Future<bool> checkIsMyQuestion(
      {required StudentId studentId, required QuestionId questionId}) async {
    final docSnapshot =
        await db.collection("all_questions").doc(questionId.value).get();
    final doc = docSnapshot.data();
    if (doc == null) {
      return false;
    }

    return doc["studentId"] == studentId.value;
  }
}
