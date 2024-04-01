import '../../../application/question/application_service/i_get_trending_question_query_service.dart';
import '../../../application/shared/application_service/question_card_dto.dart';
import '../../../domain/question/models/question.dart';
import '../../../domain/shared/subject.dart';
import '../student/in_memory_student_repository.dart';
import '../teacher/in_memory_teacher_repository.dart';
import 'exception/question_infrastructure_exception.dart';
import 'exception/question_infrastructure_exception_detail.dart';
import 'in_memory_question_repository.dart';

class InMemoryGetTrendingQuestionQueryService
    implements IGetTrendingQuestionQueryService {
  final InMemoryQuestionRepository _repository;
  final InMemoryStudentRepository _studentRepository;
  final InMemoryTeacherRepository _teacherRepository;

  InMemoryGetTrendingQuestionQueryService({
    required final InMemoryQuestionRepository repository,
    required final InMemoryStudentRepository studentRepository,
    required final InMemoryTeacherRepository teacherRepository,
  })  : _repository = repository,
        _studentRepository = studentRepository,
        _teacherRepository = teacherRepository;

  @override
  List<QuestionCardDto> get(Subject? subject) {
    final questionCardDtoList = <QuestionCardDto>[];

    final result = _repository.store.values.where((question) {
      if (subject != null) {
        return question.questionSubject == subject;
      }
      return true;
    }).toList();

    result.sort((a, b) => a.seenCount.value.compareTo(b.seenCount.value));

    for (final question in result) {
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
        answerText: null,
        isMine: question.studentId == student.studentId,
      );
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
      answerText: mostLikedAnswer.answerText.value,
      isMine: question.studentId == student.studentId,
    );
  }
}
