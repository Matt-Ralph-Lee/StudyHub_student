import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:studyhub/application/question/application_service/get_my_questions_use_case.dart';
import 'package:studyhub/application/shared/application_service/question_card_dto.dart';
import 'package:studyhub/application/shared/session/session.dart';
import 'package:studyhub/domain/answer_list/models/answer.dart';
import 'package:studyhub/domain/answer_list/models/answer_id.dart';
import 'package:studyhub/domain/answer_list/models/answer_like.dart';
import 'package:studyhub/domain/answer_list/models/answer_list.dart';
import 'package:studyhub/domain/answer_list/models/answer_photo_path_list.dart';
import 'package:studyhub/domain/answer_list/models/answer_text.dart';
import 'package:studyhub/domain/question/models/question.dart';
import 'package:studyhub/domain/question/models/question_id.dart';
import 'package:studyhub/domain/question/models/question_photo_path_list.dart';
import 'package:studyhub/domain/question/models/question_text.dart';
import 'package:studyhub/domain/question/models/question_title.dart';
import 'package:studyhub/domain/question/models/seen_count.dart';
import 'package:studyhub/domain/question/models/selected_teacher_list.dart';
import 'package:studyhub/domain/school/models/school.dart';
import 'package:studyhub/domain/shared/name.dart';
import 'package:studyhub/domain/shared/profile_photo_path.dart';
import 'package:studyhub/domain/shared/subject.dart';
import 'package:studyhub/domain/student/models/gender.dart';
import 'package:studyhub/domain/student/models/grade_or_graduate_status.dart';
import 'package:studyhub/domain/student/models/occupation.dart';
import 'package:studyhub/domain/student/models/question_count.dart';
import 'package:studyhub/domain/student/models/status.dart';
import 'package:studyhub/domain/student/models/student.dart';
import 'package:studyhub/domain/student/models/student_id.dart';
import 'package:studyhub/domain/student_auth/models/email_address.dart';
import 'package:studyhub/domain/teacher/models/bio.dart';
import 'package:studyhub/domain/teacher/models/graduated.dart';
import 'package:studyhub/domain/teacher/models/high_school.dart';
import 'package:studyhub/domain/teacher/models/introduction.dart';
import 'package:studyhub/domain/teacher/models/rating.dart';
import 'package:studyhub/domain/teacher/models/teacher.dart';
import 'package:studyhub/domain/teacher/models/teacher_id.dart';
import 'package:studyhub/domain/teacher/models/university.dart';
import 'package:studyhub/infrastructure/in_memory/question/in_memory_get_my_questions_query_service.dart';
import 'package:studyhub/infrastructure/in_memory/question/in_memory_question_repository.dart';
import 'package:studyhub/infrastructure/in_memory/student/in_memory_student_repository.dart';
import 'package:studyhub/infrastructure/in_memory/teacher/in_memory_teacher_repository.dart';
import 'package:studyhub/infrastructure/repositories/in_memory_logger.dart';

void main() {
  final session1 = MockSession1();
  final session2 = MockSession2();
  final session3 = MockSession3();
  final questionRepository = InMemoryQuestionRepository();
  final studentRepository = InMemoryStudentRepository();
  final teacherRepository = InMemoryTeacherRepository();
  final logger = InMemoryLogger();
  final queryService = InMemoryGetMyQuestionsQueryService(
    repository: questionRepository,
    studentRepository: studentRepository,
    teacherRepository: teacherRepository,
  );

  setUp(() {
    // student1 has 2 questions
    final studentId1 = StudentId('teststudent12345678901');
    final student1 = Student(
      studentId: studentId1,
      name: Name('teststudent1'),
      profilePhotoPath:
          ProfilePhotoPath('photos/profile_photo/initial_photo.jpg'),
      gender: Gender.male,
      occupation: Occupation.student,
      school: School('第一高校'),
      gradeOrGraduateStatus: GradeOrGraduateStatus.first,
      questionCount: QuestionCount(2),
      status: Status.beginner,
    );
    studentRepository.create(student1);

    // student2 has 1 question
    final studentId2 = StudentId('teststudent12345678902');
    final student2 = Student(
      studentId: studentId2,
      name: Name('teststudent2'),
      profilePhotoPath:
          ProfilePhotoPath('photos/profile_photo/initial_photo.jpg'),
      gender: Gender.male,
      occupation: Occupation.student,
      school: School('第一高校'),
      gradeOrGraduateStatus: GradeOrGraduateStatus.first,
      questionCount: QuestionCount(1),
      status: Status.beginner,
    );
    studentRepository.create(student2);

    // student3 has no questions
    final studentId3 = StudentId('teststudent12345678903');
    final student3 = Student(
      studentId: studentId3,
      name: Name('teststudent3'),
      profilePhotoPath:
          ProfilePhotoPath('photos/profile_photo/initial_photo.jpg'),
      gender: Gender.male,
      occupation: Occupation.student,
      school: School('第一高校'),
      gradeOrGraduateStatus: GradeOrGraduateStatus.first,
      questionCount: QuestionCount(1),
      status: Status.beginner,
    );
    studentRepository.create(student3);

    final teacherId1 = TeacherId('testteacher12345678901');
    final teacher1 = Teacher(
        teacherId: teacherId1,
        name: Name('testteacher1'),
        highSchool: HighSchool('第一高校'),
        university: University(
            school: '東京大学', enrollmentStatus: EnrollmentStatus.enrolled),
        bio: Bio('Hello!'),
        introduction: Introduction('丁寧に教えます'),
        rating: Rating(4.0),
        bestSubjects: [Subject.highEng],
        profilePhotoPath:
            ProfilePhotoPath('photos/profile_photo/initial_photo.jpg'));
    teacherRepository.store[teacherId1] = teacher1;

    final teacherId2 = TeacherId('testteacher12345678902');
    final teacher2 = Teacher(
        teacherId: teacherId2,
        name: Name('testteacher2'),
        highSchool: HighSchool('第二高校'),
        university: University(
            school: '京都大学', enrollmentStatus: EnrollmentStatus.enrolled),
        bio: Bio('Hello!'),
        introduction: Introduction('厳密に教えます'),
        rating: Rating(4.2),
        bestSubjects: [Subject.highMath],
        profilePhotoPath:
            ProfilePhotoPath('photos/profile_photo/initial_photo.jpg'));
    teacherRepository.store[teacherId2] = teacher2;

    // a question with 2 answers
    final questionId1 = QuestionId('testquestion12345678901');
    final answer1 = Answer(
        answerId: AnswerId('testanswer12345678901'),
        questionId: questionId1,
        answerText: AnswerText('強調構文とは、、、'),
        answerPhotoPathList: AnswerPhotoPathList([]),
        like: AnswerLike(2),
        teacherId: teacherId1,
        evaluated: false);
    final answer2 = Answer(
        answerId: AnswerId('testanswer12345678902'),
        questionId: questionId1,
        answerText: AnswerText('まずthatについて、、、'),
        answerPhotoPathList: AnswerPhotoPathList([]),
        like: AnswerLike(10),
        teacherId: teacherId2,
        evaluated: false);
    final questionWithAnswers = Question(
        questionId: questionId1,
        questionSubject: Subject.highEng,
        questionTitle: QuestionTitle('文法について'),
        questionText: QuestionText('強調構文がわかりません'),
        questionPhotoPathList: QuestionPhotoPathList([]),
        studentId: studentId1,
        answerList: AnswerList([answer1, answer2]),
        seenCount: SeenCount(5),
        selectedTeacherList: SelectedTeacherList([]),
        resolved: false);
    questionRepository.save(questionWithAnswers);

    // a question with no answers
    final questionWithNoAnswers = Question(
        questionId: QuestionId('testquestion12345678902'),
        questionSubject: Subject.highMath,
        questionTitle: QuestionTitle('積分について'),
        questionText: QuestionText('この積分の解き方がわかりません'),
        questionPhotoPathList: QuestionPhotoPathList([]),
        studentId: studentId1,
        answerList: AnswerList([]),
        seenCount: SeenCount(1),
        selectedTeacherList: SelectedTeacherList([]),
        resolved: false);
    questionRepository.save(questionWithNoAnswers);

    // a question made by student2
    final questionMadeByStudent2 = Question(
        questionId: QuestionId('testquestion12345678903'),
        questionSubject: Subject.highMath,
        questionTitle: QuestionTitle('微分について'),
        questionText: QuestionText('この微分の解き方がわかりません'),
        questionPhotoPathList: QuestionPhotoPathList([]),
        studentId: studentId2,
        answerList: AnswerList([]),
        seenCount: SeenCount(1),
        selectedTeacherList: SelectedTeacherList([]),
        resolved: false);
    questionRepository.save(questionMadeByStudent2);
  });

  group('get my questions properly', () {
    test('questions of student1 (session 1)', () async {
      final usecase = GetMyQuestionsUseCase(
        session: session1,
        queryService: queryService,
        logger: logger,
      );
      final questionCardList = await usecase.execute();
      debugPrint('student 1');
      printQuestionCardList(questionCardList);
      expect(questionCardList.length, 2);
    });

    test('questions of student2 (session 2)', () async {
      final usecase = GetMyQuestionsUseCase(
        session: session2,
        queryService: queryService,
        logger: logger,
      );
      final questionCardList = await usecase.execute();
      debugPrint('student 2');
      printQuestionCardList(questionCardList);
      expect(questionCardList.length, 1);
    });

    test('questions of student3 (session 3) (no questions)', () async {
      final usecase = GetMyQuestionsUseCase(
        session: session3,
        queryService: queryService,
        logger: logger,
      );
      final questionCardList = await usecase.execute();
      debugPrint('student 3');
      printQuestionCardList(questionCardList);
      expect(questionCardList.length, 0);
    });
  });
}

class MockSession1 implements Session {
  @override
  bool get isVerified => true;

  @override
  StudentId get studentId => StudentId('teststudent12345678901');

  @override
  EmailAddress get emailAddress => EmailAddress("test@email.com");
}

class MockSession2 implements Session {
  @override
  bool get isVerified => true;

  @override
  StudentId get studentId => StudentId('teststudent12345678902');

  @override
  EmailAddress get emailAddress => EmailAddress("test1@email.com");
}

class MockSession3 implements Session {
  @override
  bool get isVerified => true;

  @override
  StudentId get studentId => StudentId('teststudent12345678903');

  @override
  EmailAddress get emailAddress => EmailAddress("test2@email.com");
}

void printQuestionCardList(final List<QuestionCardDto> questionCardList) {
  for (final dto in questionCardList) {
    debugPrint('questionTitle : ${dto.questionTitle}');
  }
}
