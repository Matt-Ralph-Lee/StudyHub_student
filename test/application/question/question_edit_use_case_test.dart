import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:studyhub/application/question/application_service/question_edit_command.dart';
import 'package:studyhub/application/question/application_service/question_edit_use_case.dart';
import 'package:studyhub/application/shared/session/session.dart';
import 'package:studyhub/domain/answer_list/models/answer.dart';
import 'package:studyhub/domain/answer_list/models/answer_list.dart';
import 'package:studyhub/domain/question/models/question.dart';
import 'package:studyhub/domain/question/models/question_id.dart';
import 'package:studyhub/domain/question/models/question_photo_path.dart';
import 'package:studyhub/domain/question/models/question_photo_path_list.dart';
import 'package:studyhub/domain/question/models/question_text.dart';
import 'package:studyhub/domain/question/models/question_title.dart';
import 'package:studyhub/domain/question/models/seen_count.dart';
import 'package:studyhub/domain/question/models/selected_teacher_list.dart';
import 'package:studyhub/domain/shared/subject.dart';
import 'package:studyhub/domain/student/models/student_id.dart';
import 'package:studyhub/infrastructure/in_memory/photo/in_memory_photo_repository.dart';
import 'package:studyhub/infrastructure/in_memory/question/in_memory_question_repository.dart';

void main() {
  final session = MockSession();
  final repository = InMemoryQuestionRepository();
  final photoRepository = InMemoryPhotoRepository();

  final questionId = QuestionId('01234567890123456789');
  final questionTitle = QuestionTitle("数学がわからない");
  final questionText = QuestionText("ほんとうにわからない。");
  const questionSubject = Subject.highEng;
  final List<QuestionPhotoPath> questionPhotoPathListData = [];
  final questionPhotoPathList =
      QuestionPhotoPathList(questionPhotoPathListData);
  final studentId = session.studentId;
  final List<Answer> answerListData = [];
  final answerList = AnswerList(answerListData);
  final seenCount = SeenCount(0);
  const resolved = false;
  final selectedTeacherList = SelectedTeacherList(selectedTeacherList: []);
  final question = Question(
      questionId: questionId,
      questionSubject: questionSubject,
      questionTitle: questionTitle,
      questionText: questionText,
      questionPhotoPathList: questionPhotoPathList,
      studentId: studentId,
      answerList: answerList,
      seenCount: seenCount,
      resolved: resolved,
      selectedTeacherList: selectedTeacherList);
  repository.store[questionId] = question;

  tearDown(() {
    repository.store[questionId] = question;
  });

  group('question edit use case', () {
    test('should edit question except photo and selected teacher', () {
      final command = QuestionEditCommand(
          questionId: questionId,
          questionTitleData: "英語がわからん",
          questionTextData: "わりとわからん",
          localPathList: null,
          selectedTeacherList: null);
      final useCase = QuestionEditUseCase(
          session: session,
          repository: repository,
          photoRepository: photoRepository);

      useCase.execute(command);
      debugPrint(repository.store.toString());
    });

    test('should edit question photo', () {
      final command = QuestionEditCommand(
          questionId: questionId,
          questionTitleData: null,
          questionTextData: null,
          localPathList: ["assets/photos/profile_photo/sample_picture_hd.png"],
          selectedTeacherList: null);
      final useCase = QuestionEditUseCase(
          session: session,
          repository: repository,
          photoRepository: photoRepository);

      useCase.execute(command);
      debugPrint(repository.store.toString());
    });

    test('should edit selected teacher', () {
      final command = QuestionEditCommand(
          questionId: questionId,
          questionTitleData: null,
          questionTextData: null,
          localPathList: null,
          selectedTeacherList: ["01234567890123456789"]);
      final useCase = QuestionEditUseCase(
          session: session,
          repository: repository,
          photoRepository: photoRepository);

      useCase.execute(command);
      debugPrint(repository.store.toString());
    });
  });
}

class MockSession implements Session {
  @override
  bool get isVerified => true;

  @override
  StudentId get studentId => StudentId('teststudent1234567890');
}
