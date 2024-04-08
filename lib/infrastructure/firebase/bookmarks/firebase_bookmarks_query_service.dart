import '../../../application/bookmarks/application_service/i_get_bookmarks_query_service.dart';
import '../../../application/shared/application_service/question_card_dto.dart';
import '../../../domain/question/models/question.dart';
import '../../../domain/student/models/student_id.dart';
import '../../exceptions/bookmarks/bookmarks_infrastructure_exception.dart';
import '../../exceptions/bookmarks/bookmarks_infrastructure_exception_detail.dart';
import '../question/firebase_question_repository.dart';
import '../student/firebase_student_repository.dart';
import '../teacher/firebase_teacher_repository.dart';
import 'firebase_bookmarks_repository.dart';

class FirebaseBookmarksQueryService implements IGetBookmarksQueryService {
  final FirebaseBookmarksRepository _repository;
  final FirebaseQuestionRepository _questionRepository;
  final FirebaseStudentRepository _studentRepository;
  final FirebaseTeacherRepository _teacherRepository;

  FirebaseBookmarksQueryService({
    required final FirebaseBookmarksRepository repository,
    required final FirebaseQuestionRepository questionRepository,
    required final FirebaseStudentRepository studentRepository,
    required final FirebaseTeacherRepository teacherRepository,
  })  : _repository = repository,
        _questionRepository = questionRepository,
        _studentRepository = studentRepository,
        _teacherRepository = teacherRepository;
  @override
  Future<List<QuestionCardDto>> getByStudentId(StudentId studentId) async {
    final bookmarks = await _repository.getByStudentId(studentId);
    if (bookmarks == null) return [];

    final bookmarkedQuestionList = <QuestionCardDto>[];

    for (final questionId in bookmarks) {
      final bookmarkedQuestion = await _questionRepository.findById(questionId);
      if (bookmarkedQuestion == null) continue;

      final dto = await _toDto(bookmarkedQuestion);
      bookmarkedQuestionList.add(dto);
    }

    return bookmarkedQuestionList;
  }

  Future<QuestionCardDto> _toDto(final Question question) async {
    final student = await _studentRepository.findById(question.studentId);
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
        await _teacherRepository.getByTeacherId(mostLikedAnswer.teacherId);
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
