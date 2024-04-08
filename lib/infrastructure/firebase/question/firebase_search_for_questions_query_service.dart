import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../application/question/application_service/i_search_for_questions_query_service.dart';
import '../../../application/shared/application_service/question_card_dto.dart';
import '../../../domain/question/models/question.dart';
import '../../../domain/question/models/question_id.dart';
import '../../../domain/shared/subject.dart';
import '../../exceptions/question/question_infrastructure_exception.dart';
import '../../exceptions/question/question_infrastructure_exception_detail.dart';
import '../student/firebase_student_repository.dart';
import '../teacher/firebase_teacher_repository.dart';
import 'firebase_question_repository.dart';

class FirebaseSearchForQuestionsQueryService
    implements ISearchForQuestionsQueryService {
  final db = FirebaseFirestore.instance;
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

    final querySnapshot = subject != null
        ? await db
            .collection("all_questions")
            .where("subject", isEqualTo: subject.japanese)
            .where("textTokenMap.$searchWord", isEqualTo: true)
            .limit(100)
            .get()
        : await db
            .collection("all_questions")
            .where("textTokenMap.$searchWord", isEqualTo: true)
            .limit(100)
            .get();

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
    final student = await _studentRepository.findById(question.studentId);
    if (student == null) {
      throw const QuestionInfrastructureException(
          QuestionInfrastructureExceptionDetail.studentNotFound);
    }

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
    if (teacher == null) {
      throw const QuestionInfrastructureException(
          QuestionInfrastructureExceptionDetail.teacherNotFound);
    }
    return QuestionCardDto(
      questionId: question.questionId,
      studentProfilePhotoPath: student.profilePhotoPath.value,
      questionTitle: question.questionTitle.value,
      questionText: question.questionText.value,
      teacherProfilePhotoPath: teacher.profilePhotoPath.value,
      answerText: mostLikedAnswer.answerText.value,
      isMine: question.studentId == student.studentId,
    );
  }
}
