import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:studyhub/application/question/application_service/question_create_use_case.dart';
import 'package:studyhub/application/shared/session/session.dart';
import 'package:studyhub/domain/question/exception/question_domain_exception.dart';
import 'package:studyhub/domain/question/exception/question_domain_exception_detail.dart';
import 'package:studyhub/domain/shared/subject.dart';
import 'package:studyhub/domain/student/models/student_id.dart';
import 'package:studyhub/domain/student_auth/models/email_address.dart';
import 'package:studyhub/domain/teacher/models/teacher_id.dart';
import 'package:studyhub/infrastructure/in_memory/notification/in_memory_notification_factory.dart';
import 'package:studyhub/infrastructure/in_memory/notification/in_memory_notification_repository.dart';
import 'package:studyhub/infrastructure/in_memory/photo/in_memory_photo_repository.dart';
import 'package:studyhub/infrastructure/in_memory/question/in_memory_question_create_query_service.dart';
import 'package:studyhub/infrastructure/in_memory/question/in_memory_question_factory.dart';
import 'package:studyhub/infrastructure/in_memory/question/in_memory_question_repository.dart';
import 'package:studyhub/infrastructure/in_memory/student/in_memory_student_repository.dart';
import 'package:studyhub/infrastructure/in_memory/teacher/in_memory_teacher_repository.dart';
import 'package:studyhub/infrastructure/repositories/in_memory_logger.dart';

void main() {
  final session = MockSession();
  var repository = InMemoryQuestionRepository();
  final factory = InMemoryQuestionFactory(repository);
  final photoReposiory = InMemoryPhotoRepository();
  final notificationRepository = InMemoryNotificationRepository();
  final studentRepository = InMemoryStudentRepository();
  final notificationFactory =
      InMemoryNotificationFactory(repository: notificationRepository);
  final queryService =
      InMemoryQuestionCreateQueryService(repository: studentRepository);
  final logger = InMemoryLogger();
  final useCase = QuestionCreateUseCase(
    session: session,
    repository: repository,
    factory: factory,
    photoRepository: photoReposiory,
    notificationRepository: notificationRepository,
    notificationFactory: notificationFactory,
    queryService: queryService,
    studentRepository: studentRepository,
    logger: logger,
  );

  setUp(() {});

  group('create use case', () {
    test('should create a new question without any photo', () async {
      String questionTitleData = "数学がわからない";
      String questionTextData = "分数の割り算ができない";
      List<String> localPathList = [];
      Subject questionSubject = Subject.highEng;
      List<TeacherId> selectedTeacherList = [];

      await useCase.execute(
          questionTitleData: questionTitleData,
          questionTextData: questionTextData,
          localPathList: localPathList,
          questionSubject: questionSubject,
          selectedTeacherListData: selectedTeacherList);

      repository.store.forEach((key, value) {
        debugPrint(value.questionTitle.value);
      });
    });

    test('should create a new question with some picture', () async {
      String questionTitleData = "数学がわからない";
      String questionTextData = "分数の割り算ができない";
      List<String> localPathList = [
        "assets/photos/profile_photo/sample_user_icon.jpg",
        "assets/photos/profile_photo/sample_user_icon2.jpg"
      ];
      Subject questionSubject = Subject.highEng;
      List<TeacherId> selectedTeacherList = [];

      await useCase.execute(
          questionTitleData: questionTitleData,
          questionTextData: questionTextData,
          localPathList: localPathList,
          questionSubject: questionSubject,
          selectedTeacherListData: selectedTeacherList);

      repository.store.forEach((key, value) {
        debugPrint(value.questionTitle.value);
      });
    });

    test(
        'should create a new question with a different type of picture(png) and has big size',
        () async {
      String questionTitleData = "数学がわからない";
      String questionTextData = "分数の割り算ができない";
      List<String> localPathList = [
        "assets/images/sample_picture_hd.png",
      ];
      Subject questionSubject = Subject.highEng;
      List<TeacherId> selectedTeacherList = [];

      await useCase.execute(
          questionTitleData: questionTitleData,
          questionTextData: questionTextData,
          localPathList: localPathList,
          questionSubject: questionSubject,
          selectedTeacherListData: selectedTeacherList);

      repository.store.forEach((key, value) {
        debugPrint(value.questionTitle.value);
      });
    });

    test('should create a new question with a single selected teacher',
        () async {
      String questionTitleData = "数学がわからない";
      String questionTextData = "分数の割り算ができない";
      List<String> localPathList = [];
      Subject questionSubject = Subject.highEng;
      List<TeacherId> selectedTeacherList = [
        InMemoryTeacherInitialValue.teacher1.teacherId
      ];

      await useCase.execute(
          questionTitleData: questionTitleData,
          questionTextData: questionTextData,
          localPathList: localPathList,
          questionSubject: questionSubject,
          selectedTeacherListData: selectedTeacherList);

      repository.store.forEach((key, value) {
        debugPrint(value.questionTitle.value);
      });

      notificationRepository.store.forEach((key, value) {
        debugPrint(
            'title: ${value.title.value}\nfrom: ${value.sender.senderId?.value}\nto: ');
        debugPrint(value.receiver.receiverId.value);
      });
    });

    test('should create a new question with multiple selected teacher',
        () async {
      String questionTitleData = "数学がわからない";
      String questionTextData = "分数の割り算ができない";
      List<String> localPathList = [];
      Subject questionSubject = Subject.highEng;
      List<TeacherId> selectedTeacherList = [
        InMemoryTeacherInitialValue.teacher1.teacherId,
        InMemoryTeacherInitialValue.teacher2.teacherId,
      ];

      await useCase.execute(
          questionTitleData: questionTitleData,
          questionTextData: questionTextData,
          localPathList: localPathList,
          questionSubject: questionSubject,
          selectedTeacherListData: selectedTeacherList);

      repository.store.forEach((key, value) {
        debugPrint(value.questionTitle.value);
      });

      notificationRepository.store.forEach((key, value) {
        debugPrint(
            'title: ${value.title.value}\nfrom: ${value.sender.senderId?.value}\nto: ');
        debugPrint(value.receiver.receiverId.value);
      });
    });

    test('invalid title too long', () async {
      String questionTitleData = "数学がわからない。ほんとうにわからない。たすけて。むり。";
      String questionTextData = "分数の割り算ができない";
      List<String> localPathList = [
        "assets/photos/profile_photo/sample_picture_hd.png",
      ];
      Subject questionSubject = Subject.highEng;
      List<TeacherId> selectedTeacherList = [];

      expect(() async {
        await useCase.execute(
            questionTitleData: questionTitleData,
            questionTextData: questionTextData,
            localPathList: localPathList,
            questionSubject: questionSubject,
            selectedTeacherListData: selectedTeacherList);
      },
          throwsA(const QuestionDomainException(
              QuestionDomainExceptionDetail.titleInvalidLength)));
    });

    test('invalid empty title', () async {
      String questionTitleData = "";
      String questionTextData = "分数の割り算ができない";
      List<String> localPathList = [
        "assets/photos/profile_photo/sample_picture_hd.png",
      ];
      Subject questionSubject = Subject.highEng;
      List<TeacherId> selectedTeacherList = [];

      expect(() async {
        await useCase.execute(
            questionTitleData: questionTitleData,
            questionTextData: questionTextData,
            localPathList: localPathList,
            questionSubject: questionSubject,
            selectedTeacherListData: selectedTeacherList);
      },
          throwsA(const QuestionDomainException(
              QuestionDomainExceptionDetail.titleInvalidLength)));
    });

    test('invalid text too long', () async {
      String questionTitleData = "数学がわからない";
      String questionTextData = List.generate(1000, (index) => 'a').join();
      List<String> localPathList = [
        "assets/images/sample_picture_hd.png",
      ];
      Subject questionSubject = Subject.highEng;
      List<TeacherId> selectedTeacherList = [];

      expect(() async {
        await useCase.execute(
            questionTitleData: questionTitleData,
            questionTextData: questionTextData,
            localPathList: localPathList,
            questionSubject: questionSubject,
            selectedTeacherListData: selectedTeacherList);
      },
          throwsA(const QuestionDomainException(
              QuestionDomainExceptionDetail.textInvalidLength)));
    });

    test('invalid empty text', () async {
      String questionTitleData = "数学がわからない";
      String questionTextData = "";
      List<String> localPathList = [
        "assets/photos/profile_photo/sample_picture_hd.png",
      ];
      Subject questionSubject = Subject.highEng;
      List<TeacherId> selectedTeacherList = [];

      expect(() async {
        await useCase.execute(
            questionTitleData: questionTitleData,
            questionTextData: questionTextData,
            localPathList: localPathList,
            questionSubject: questionSubject,
            selectedTeacherListData: selectedTeacherList);
      },
          throwsA(const QuestionDomainException(
              QuestionDomainExceptionDetail.textEmptyLength)));
    });

    test('invalid teacher length', () async {
      String questionTitleData = "数学がわからない";
      String questionTextData = "分数の割り算ができない";
      List<String> localPathList = [];
      Subject questionSubject = Subject.highEng;
      List<TeacherId> selectedTeacherList = [
        for (int i = 0; i < 10; i++)
          TeacherId(List.generate(20, (index) => index.toString()).join())
      ];

      expect(() async {
        await useCase.execute(
            questionTitleData: questionTitleData,
            questionTextData: questionTextData,
            localPathList: localPathList,
            questionSubject: questionSubject,
            selectedTeacherListData: selectedTeacherList);
      },
          throwsA(const QuestionDomainException(
              QuestionDomainExceptionDetail.invalidTeacherLength)));
    });
  });
}

class MockSession implements Session {
  @override
  bool get isVerified => true;

  @override
  StudentId get studentId => InMemoryStudentInitialValue.student1.studentId;

  @override
  EmailAddress get emailAddress => EmailAddress("test@email.com");
}
