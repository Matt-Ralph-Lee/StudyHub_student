import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:studyhub/application/question/application_service/question_edit_command.dart';
import 'package:studyhub/application/question/application_service/question_edit_use_case.dart';
import 'package:studyhub/application/shared/session/i_session.dart';
import 'package:studyhub/domain/answer_list/models/answer.dart';
import 'package:studyhub/domain/answer_list/models/answer_list.dart';
import 'package:studyhub/domain/question/models/question.dart';
import 'package:studyhub/domain/question/models/question_id.dart';
import 'package:studyhub/domain/question/models/question_photo_path.dart';
import 'package:studyhub/domain/question/models/question_photo_path_list.dart';
import 'package:studyhub/domain/question/models/question_subject.dart';
import 'package:studyhub/domain/question/models/question_text.dart';
import 'package:studyhub/domain/question/models/question_title.dart';
import 'package:studyhub/domain/question/models/seen_count.dart';
import 'package:studyhub/domain/student/models/student_id.dart';
import 'package:studyhub/infrastructure/in_memory/photo/in_memory_photo_repository.dart';
import 'package:studyhub/infrastructure/in_memory/question/in_memory_question_repository.dart';

void main() {
  final session = MockSession();
  final repository = InMemoryQuestionRepository();
  final photoRepository = InMemoryPhotoRepository();

  const String questionIdData = '01234567890123456789';
  final questionId = QuestionId(questionIdData);
  final questionTitle = QuestionTitle("数学がわからない");
  final questionText = QuestionText("ほんとうにわからない。");
  const questionSubject = QuestionSubject.highEng;
  final List<QuestionPhotoPath> questionPhotoPathListData = [];
  final questionPhotoPathList =
      QuestionPhotoPathList(questionPhotoPathList: questionPhotoPathListData);
  final studentId = session.studentId;
  final List<Answer> answerListData = [];
  final answerList = AnswerList(answerList: answerListData);
  final seenCount = SeenCount(0);
  const questionResolved = false;
  final question = Question(
      questionId: questionId,
      questionSubject: questionSubject,
      questionTitle: questionTitle,
      questionText: questionText,
      questionPhotoPathList: questionPhotoPathList,
      studentId: studentId,
      answerList: answerList,
      seenCount: seenCount,
      questionResolved: questionResolved);
  repository.store[questionId] = question;

  tearDown(() {
    repository.store[questionId] = question;
  });

  group('questin edit use case', () {
    test('should edit question except photo', () {
      final command = QuestionEditCommand(
          questionId: questionIdData,
          questionTitleData: "英語がわからん",
          questionTextData: "わりとわからん",
          localPathList: null);
      final useCase = QuestionEditUseCase(
          session: session,
          repository: repository,
          photoRepository: photoRepository);

      useCase.execute(command);
      debugPrint(repository.store.toString());
    });

    test('should edit question photo', () {
      final command = QuestionEditCommand(
          questionId: questionIdData,
          questionTitleData: null,
          questionTextData: null,
          localPathList: ["assets/images/sample_picture_hd.png"]);
      final useCase = QuestionEditUseCase(
          session: session,
          repository: repository,
          photoRepository: photoRepository);

      useCase.execute(command);
      debugPrint(repository.store.toString());
    });
  });
}

class MockSession implements ISession {
  @override
  bool get isVerified => true;

  @override
  StudentId get studentId => StudentId('teststudent1234567890');
}
