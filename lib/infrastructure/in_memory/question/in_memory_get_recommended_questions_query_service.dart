import '../../../application/question/application_service/i_get_recommended_questions_query_service.dart';
import '../../../application/shared/application_service/question_card_dto.dart';
import '../../../domain/question/models/question.dart';
import '../../../domain/shared/subject.dart';
import '../../../domain/student/models/student_id.dart';
import '../student/in_memory_student_repository.dart';
import '../teacher/in_memory_teacher_repository.dart';
import 'exception/question_infrastructure_exception.dart';
import 'exception/question_infrastructure_exception_detail.dart';
import 'in_memory_question_repository.dart';

class InMemoryGetRecommendedQuestionsQueryService
    implements IGetRecommendedQuestionsQueryService {
  final InMemoryQuestionRepository _repository;
  final InMemoryStudentRepository _studentRepository;
  final InMemoryTeacherRepository _teacherRepository;

  static const _maxQuestionAmount = 10;

  InMemoryGetRecommendedQuestionsQueryService({
    required final InMemoryQuestionRepository repository,
    required final InMemoryStudentRepository studentRepository,
    required final InMemoryTeacherRepository teacherRepository,
  })  : _repository = repository,
        _studentRepository = studentRepository,
        _teacherRepository = teacherRepository;

  // to implement easily, return the first few values
  @override
  List<QuestionCardDto> get({
    final Subject? subject,
    required final StudentId studentId,
  }) {
    final questionCardDtoList = <QuestionCardDto>[];
    final store = _repository.store;
    final selectableQuestions = subject == null
        ? store.values
        : store.values.where((question) => question.questionSubject == subject);

    for (final question in selectableQuestions) {
      if (questionCardDtoList.length >= _maxQuestionAmount) {
        break;
      }

      final dto = _toDto(question);
      questionCardDtoList.add(dto);
    }

    return questionCardDtoList;
  }

  QuestionCardDto _toDto(final Question question) {
    final student = _studentRepository.findById(question.studentId);
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
          answerText: null);
    }

    final teacher =
        _teacherRepository.getByTeacherId(mostLikedAnswer.teacherId);
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
        answerText: mostLikedAnswer.answerText.value);
  }
}
