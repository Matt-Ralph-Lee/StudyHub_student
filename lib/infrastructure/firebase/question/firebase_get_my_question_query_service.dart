import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../application/question/application_service/i_get_my_questions_query_service.dart';
import '../../../application/shared/application_service/question_card_dto.dart';
import '../../../domain/question/models/question.dart';
import '../../../domain/question/models/question_id.dart';
import '../../../domain/student/models/student.dart';
import '../../../domain/student/models/student_id.dart';
import '../../exceptions/question/question_infrastructure_exception.dart';
import '../../exceptions/question/question_infrastructure_exception_detail.dart';
import '../student/firebase_student_repository.dart';
import '../teacher/firebase_teacher_repository.dart';
import 'firebase_question_repository.dart';

class FirebaseGetMyQuestionQueryService implements IGetMyQuestionsQueryService {
  final db = FirebaseFirestore.instance;
  final FirebaseQuestionRepository _repository;
  final FirebaseStudentRepository _studentRepository;
  final FirebaseTeacherRepository _teacherRepository;

  FirebaseGetMyQuestionQueryService({
    required final FirebaseQuestionRepository repository,
    required final FirebaseStudentRepository studentRepository,
    required final FirebaseTeacherRepository teacherRepository,
  })  : _repository = repository,
        _studentRepository = studentRepository,
        _teacherRepository = teacherRepository;

  @override
  Future<List<QuestionCardDto>> get(StudentId studentId) async {
    final student = await _studentRepository.findById(studentId);
    if (student == null) {
      throw const QuestionInfrastructureException(
          QuestionInfrastructureExceptionDetail.studentNotFound);
    }

    final questionCardDtoList = <QuestionCardDto>[];

    final querySnapshot = await db
        .collection("all_questions")
        .where("studentId", isEqualTo: studentId.value)
        .get();
    final myQuestions = <Question>[];

    for (final docSnapshot in querySnapshot.docs) {
      final questionIdData = docSnapshot.reference.id;
      final questionId = QuestionId(questionIdData);
      final question = await _repository.findById(questionId);

      if (question == null) continue;

      myQuestions.add(question);
    }

    for (final question in myQuestions) {
      final dto = await _toDto(
        question: question,
        student: student,
      );
      questionCardDtoList.add(dto);
    }

    return questionCardDtoList;
  }

  Future<QuestionCardDto> _toDto({
    required final Question question,
    required final Student student,
  }) async {
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
