import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:studyhub/application/question/application_service/question_create_use_case.dart';
import 'package:studyhub/application/shared/session/i_session.dart';
import 'package:studyhub/domain/question/exception/question_domain_exception.dart';
import 'package:studyhub/domain/question/exception/question_domain_exception_detail.dart';
import 'package:studyhub/domain/question/models/question_subject.dart';
import 'package:studyhub/domain/student/models/student_id.dart';
import 'package:studyhub/infrastructure/in_memory/photo/in_memory_photo_repository.dart';
import 'package:studyhub/infrastructure/in_memory/question/in_memory_question_factory.dart';
import 'package:studyhub/infrastructure/in_memory/question/in_memory_question_repository.dart';

void main() {
  final session = MockSession();
  var repository = InMemoryQuestionRepository();
  final factory = InMemoryQuestionFactory(repository);
  final phototReposiory = InMemoryPhotoRepository();

  setUp(() {
    repository = InMemoryQuestionRepository();
  });

  group('create use case', () {
    test('should create a new question without any photo', () async {
      String questionTitleData = "数学がわからない";
      String questionTextData = "分数の割り算ができない";
      List<String> localPathList = [];
      QuestionSubject questionSubject = QuestionSubject.highEng;
      final useCase = QuestionCreateUseCase(
          session: session,
          repository: repository,
          factory: factory,
          photoRepository: phototReposiory);
      await useCase.execute(
          questionTitleData: questionTitleData,
          questionTextData: questionTextData,
          localPathList: localPathList,
          questionSubject: questionSubject);
      debugPrint(repository.store.toString());
    });

    test('should create a new question with some picture', () async {
      String questionTitleData = "数学がわからない";
      String questionTextData = "分数の割り算ができない";
      List<String> localPathList = [
        "assets/images/sample_user_icon.jpg",
        "assets/images/sample_user_icon2.jpg"
      ];
      QuestionSubject questionSubject = QuestionSubject.highEng;
      final useCase = QuestionCreateUseCase(
          session: session,
          repository: repository,
          factory: factory,
          photoRepository: phototReposiory);
      await useCase.execute(
          questionTitleData: questionTitleData,
          questionTextData: questionTextData,
          localPathList: localPathList,
          questionSubject: questionSubject);
      debugPrint(repository.store.toString());
    });

    test(
        'should create a new question with a different type of picture(png) and has big size',
        () async {
      String questionTitleData = "数学がわからない";
      String questionTextData = "分数の割り算ができない";
      List<String> localPathList = [
        "assets/images/sample_picture_hd.png",
      ];
      QuestionSubject questionSubject = QuestionSubject.highEng;
      final useCase = QuestionCreateUseCase(
          session: session,
          repository: repository,
          factory: factory,
          photoRepository: phototReposiory);
      await useCase.execute(
          questionTitleData: questionTitleData,
          questionTextData: questionTextData,
          localPathList: localPathList,
          questionSubject: questionSubject);
      debugPrint(repository.store.toString());
    });

    test('invalid title too long', () async {
      String questionTitleData = "数学がわからない。ほんとうにわからない。たすけて。むり。";
      String questionTextData = "分数の割り算ができない";
      List<String> localPathList = [
        "assets/images/sample_picture_hd.png",
      ];
      QuestionSubject questionSubject = QuestionSubject.highEng;
      final useCase = QuestionCreateUseCase(
          session: session,
          repository: repository,
          factory: factory,
          photoRepository: phototReposiory);

      expect(() async {
        await useCase.execute(
            questionTitleData: questionTitleData,
            questionTextData: questionTextData,
            localPathList: localPathList,
            questionSubject: questionSubject);
      },
          throwsA(const QuestionDomainException(
              QuestionDomainExceptionDetail.titleInvalidLength)));
    });

    test('invalid empty title', () async {
      String questionTitleData = "";
      String questionTextData = "分数の割り算ができない";
      List<String> localPathList = [
        "assets/images/sample_picture_hd.png",
      ];
      QuestionSubject questionSubject = QuestionSubject.highEng;
      final useCase = QuestionCreateUseCase(
          session: session,
          repository: repository,
          factory: factory,
          photoRepository: phototReposiory);

      expect(() async {
        await useCase.execute(
            questionTitleData: questionTitleData,
            questionTextData: questionTextData,
            localPathList: localPathList,
            questionSubject: questionSubject);
      },
          throwsA(const QuestionDomainException(
              QuestionDomainExceptionDetail.titleInvalidLength)));
    });

    test('invalid text too long', () async {
      String questionTitleData = "数学がわからない";
      String questionTextData = List.generate(500, (index) => 'a').join();
      List<String> localPathList = [
        "assets/images/sample_picture_hd.png",
      ];
      QuestionSubject questionSubject = QuestionSubject.highEng;
      final useCase = QuestionCreateUseCase(
          session: session,
          repository: repository,
          factory: factory,
          photoRepository: phototReposiory);

      expect(() async {
        await useCase.execute(
            questionTitleData: questionTitleData,
            questionTextData: questionTextData,
            localPathList: localPathList,
            questionSubject: questionSubject);
      },
          throwsA(const QuestionDomainException(
              QuestionDomainExceptionDetail.textInvalidLength)));
    });

    test('invalid empty text', () async {
      String questionTitleData = "数学がわからない";
      String questionTextData = "";
      List<String> localPathList = [
        "assets/images/sample_picture_hd.png",
      ];
      QuestionSubject questionSubject = QuestionSubject.highEng;
      final useCase = QuestionCreateUseCase(
          session: session,
          repository: repository,
          factory: factory,
          photoRepository: phototReposiory);

      expect(() async {
        await useCase.execute(
            questionTitleData: questionTitleData,
            questionTextData: questionTextData,
            localPathList: localPathList,
            questionSubject: questionSubject);
      },
          throwsA(const QuestionDomainException(
              QuestionDomainExceptionDetail.textEmptyLength)));
    });
  });
}

class MockSession implements ISession {
  @override
  bool get isVerified => true;

  @override
  StudentId get studentId => StudentId('teststudent1234567890');
}
