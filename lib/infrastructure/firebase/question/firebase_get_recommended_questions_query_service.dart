import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../application/question/application_service/i_get_recommended_questions_query_service.dart';
import '../../../application/shared/application_service/question_card_dto.dart';
import '../../../domain/question/models/question.dart';
import '../../../domain/question/models/question_id.dart';
import '../../../domain/shared/subject.dart';
import '../../../domain/student/default/default_student.dart';
import '../../../domain/student/models/student.dart';
import '../../../domain/student/models/student_id.dart';
import '../student/firebase_student_repository.dart';
import '../teacher/firebase_teacher_repository.dart';
import 'firebase_question_repository.dart';

class FirebaseGetRecommendedQuestionsQueryService
    implements IGetRecommendedQuestionsQueryService {
  final db = FirebaseFirestore.instance;
  final FirebaseQuestionRepository _repository;
  final FirebaseStudentRepository _studentRepository;
  final FirebaseTeacherRepository _teacherRepository;

  FirebaseGetRecommendedQuestionsQueryService({
    required final FirebaseQuestionRepository repository,
    required final FirebaseStudentRepository studentRepository,
    required final FirebaseTeacherRepository teacherRepository,
  })  : _repository = repository,
        _studentRepository = studentRepository,
        _teacherRepository = teacherRepository;

  @override
  Future<List<QuestionCardDto>> get(
      {Subject? subject, required StudentId studentId}) async {
    final questionCardDtoList = <QuestionCardDto>[];

    final querySnapshot = subject != null
        ? await db
            .collection("all_questions")
            .where("subject", isEqualTo: subject.japanese)
            .orderBy("seenCount")
            .get()
        : await db
            .collection("all_questions")
            .orderBy("seenCount")
            .limit(10)
            .get();

    final selectableQuestions = <Question>[];

    for (final docSnapshot in querySnapshot.docs) {
      final questionId = docSnapshot.reference.id;

      final question = await _repository.findById(QuestionId(questionId));

      if (question == null) continue;

      selectableQuestions.add(question);
    }

    for (final question in selectableQuestions) {
      final dto = await _toDto(question);
      questionCardDtoList.add(dto);
    }

    return questionCardDtoList;
  }

  Future<QuestionCardDto> _toDto(final Question question) async {
    Student? student = await _studentRepository.findById(question.studentId);
    student ??= student ??= Student(
      studentId: DefaultStudent.studentId,
      name: DefaultStudent.name,
      profilePhotoPath: DefaultStudent.profilePhoto,
      gender: DefaultStudent.gender,
      occupation: DefaultStudent.occupation,
      school: DefaultStudent.school,
      gradeOrGraduateStatus: DefaultStudent.gradeOrGraduateStatus,
      questionCount: DefaultStudent.questionCount,
      status: DefaultStudent.status,
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
