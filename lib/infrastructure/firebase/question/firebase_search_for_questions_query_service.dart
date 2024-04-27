import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../database.dart';

import '../../../application/question/application_service/i_search_for_questions_query_service.dart';
import '../../../application/shared/application_service/question_card_dto.dart';
import '../../../domain/question/models/question.dart';
import '../../../domain/question/models/question_id.dart';
import '../../../domain/shared/subject.dart';
import '../../../domain/student/default/default_student.dart';
import '../../../domain/student/models/student.dart';
import '../student/firebase_student_repository.dart';
import '../teacher/firebase_teacher_repository.dart';
import 'firebase_question_repository.dart';

class FirebaseSearchForQuestionsQueryService
    implements ISearchForQuestionsQueryService {
  final db = Database.db;
  final FirebaseQuestionRepository _repository;
  final FirebaseStudentRepository _studentRepository;
  final FirebaseTeacherRepository _teacherRepository;

  FirebaseSearchForQuestionsQueryService({
    required final FirebaseQuestionRepository repository,
    required final FirebaseStudentRepository studentRepository,
    required final FirebaseTeacherRepository teacherRepository,
  })  : _repository = repository,
        _studentRepository = studentRepository,
        _teacherRepository = teacherRepository;

  @override
  Future<List<QuestionCardDto>> search({
    required String searchWord,
    required Subject? subject,
  }) async {
    final questionCardDtoList = <QuestionCardDto>[];

    Query<Map<String, dynamic>> query = subject != null
        ? db
            .collection("all_questions")
            .where("subject", isEqualTo: subject.japanese)
        : db.collection("all_questions");

    final searchWordToken = [
      for (int i = 0; i < min(searchWord.length - 1, 25); i++)
        searchWord.substring(i, i + 2)
    ];

    for (final token in searchWordToken) {
      query = query.where("textTokenMap.$token", isEqualTo: true);
    }

    final querySnapshot = await query.limit(20).get();

    for (final docSnapshot in querySnapshot.docs) {
      final questionId = docSnapshot.reference.id;

      final question = await _repository.findById(QuestionId(questionId));

      if (question == null) continue;

      final dto = await _toDto(question);

      questionCardDtoList.add(dto);
    }

    return questionCardDtoList;
  }

  Future<QuestionCardDto> _toDto(final Question question) async {
    Student? student = await _studentRepository.findById(question.studentId);
    student ??= Student(
      studentId: DefaultStudent.studentId,
      name: DefaultStudent.name,
      profilePhotoPath: DefaultStudent.profilePhoto,
      gender: DefaultStudent.gender,
      occupation: DefaultStudent.occupation,
      school: DefaultStudent.school,
      gradeOrGraduateStatus: DefaultStudent.gradeOrGraduateStatus,
      questionCount: DefaultStudent.questionCount,
      status: DefaultStudent.status,
      emailAddress: DefaultStudent.emailAddress,
    );

    final mostLikedAnswer = question.getMostLikedAnswer();
    if (mostLikedAnswer == null) {
      return QuestionCardDto(
        questionId: question.questionId,
        studentProfilePhotoPath: student.profilePhotoPath.value,
        questionTitle: question.questionTitle.value,
        questionText: question.questionText.value,
        teacherProfilePhotoPath: null,
        answerText: null,
        isMine: question.studentId == student.studentId,
      );
    }

    final teacher =
        await _teacherRepository.getByTeacherId(mostLikedAnswer.teacherId);

    return QuestionCardDto(
      questionId: question.questionId,
      studentProfilePhotoPath: student.profilePhotoPath.value,
      questionTitle: question.questionTitle.value,
      questionText: question.questionText.value,
      teacherProfilePhotoPath: teacher?.profilePhotoPath.value,
      answerText: mostLikedAnswer.answerText.value,
      isMine: question.studentId == student.studentId,
    );
  }
}
