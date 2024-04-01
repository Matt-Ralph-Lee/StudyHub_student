import '../../../application/shared/application_service/question_card_dto.dart';
import '../../../domain/question/models/question.dart';
import '../../../domain/student/models/student_id.dart';
import '../../../application/bookmarks/application_service/i_get_bookmarks_query_service.dart';
import '../teacher/in_memory_teacher_repository.dart';
import '../question/in_memory_question_repository.dart';
import '../student/in_memory_student_repository.dart';
import 'exception/bookmarks_infrastructure_exception.dart';
import 'exception/bookmarks_infrastructure_exception_detail.dart';
import 'in_memory_bookmarks_repository.dart';

class InMemoryBookmarksQueryService implements IGetBookmarksQueryService {
  final InMemoryBookmarksRepository _repository;
  final InMemoryQuestionRepository _questionRepository;
  final InMemoryStudentRepository _studentRepository;
  final InMemoryTeacherRepository _teacherRepository;

  InMemoryBookmarksQueryService({
    required final InMemoryBookmarksRepository repository,
    required final InMemoryQuestionRepository questionRepository,
    required final InMemoryStudentRepository studentRepository,
    required final InMemoryTeacherRepository teacherRepository,
  })  : _repository = repository,
        _questionRepository = questionRepository,
        _studentRepository = studentRepository,
        _teacherRepository = teacherRepository;

  @override
  List<QuestionCardDto> getByStudentId(final StudentId studentId) {
    final bookmarks = _repository.getByStudentId(studentId);
    if (bookmarks == null) return [];

    final bookmarkedQuestionList = <QuestionCardDto>[];

    for (final questionId in bookmarks) {
      final bookmarkedQuestion = _questionRepository.findById(questionId);
      if (bookmarkedQuestion == null) continue;

      final dto = _toDto(bookmarkedQuestion);
      bookmarkedQuestionList.add(dto);
    }

    return bookmarkedQuestionList;
  }

  QuestionCardDto _toDto(final Question question) {
    final student = _studentRepository.findById(question.studentId);
    if (student == null) {
      throw const BookmarksInfrastructureException(
          BookmarksInfrastructureExceptionDetail.studentNotFound);
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
      throw const BookmarksInfrastructureException(
          BookmarksInfrastructureExceptionDetail.teacherNotFound);
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
