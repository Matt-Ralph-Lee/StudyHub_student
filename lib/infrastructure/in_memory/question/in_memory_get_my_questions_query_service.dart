import '../../../application/question/application_service/i_get_my_questions_query_service.dart';
import '../../../application/shared/application_service/question_card_dto.dart';
import '../../../domain/question/models/question.dart';
import '../../../domain/student/models/student.dart';
import '../../../domain/student/models/student_id.dart';
import '../student/in_memory_student_repository.dart';
import '../teacher/in_memory_teacher_repository.dart';
import 'exception/question_infrastructure_exception.dart';
import 'exception/question_infrastructure_exception_detail.dart';
import 'in_memory_question_repository.dart';

class InMemoryGetMyQuestionsQueryService
    implements IGetMyQuestionsQueryService {
  final InMemoryQuestionRepository _repository;
  final InMemoryStudentRepository _studentRepository;
  final InMemoryTeacherRepository _teacherRepository;

  InMemoryGetMyQuestionsQueryService({
    required final InMemoryQuestionRepository repository,
    required final InMemoryStudentRepository studentRepository,
    required final InMemoryTeacherRepository teacherRepository,
  })  : _repository = repository,
        _studentRepository = studentRepository,
        _teacherRepository = teacherRepository;

  @override
  List<QuestionCardDto> get(final StudentId studentId) {
    final student = _studentRepository.findById(studentId);
    if (student == null) {
      throw const QuestionInfrastructureException(
          QuestionInfrastructureExceptionDetail.studentNotFound);
    }

    final questionCardDtoList = <QuestionCardDto>[];
    final myQuestions = _repository.store.values
        .where((question) => question.studentId == studentId);

    for (final question in myQuestions) {
      final dto = _toDto(
        question: question,
        student: student,
      );
      questionCardDtoList.add(dto);
    }

    return questionCardDtoList;
  }

  QuestionCardDto _toDto({
    required final Question question,
    required final Student student,
  }) {
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
