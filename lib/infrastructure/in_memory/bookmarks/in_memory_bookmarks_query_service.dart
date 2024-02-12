import '../../../domain/student/models/student_id.dart';
import '../../../domain/teacher/models/teacher_id.dart';
import '../../../domain/question/models/question_id.dart';
import '../../../application/bookmarks/application_service/get_bookmark_dto.dart';
import '../../../application/bookmarks/application_service/i_get_bookmarks_query_service.dart';
import '../teacher/in_memory_teacher_repository.dart';
import '../question/in_memory_question_repository.dart';
import '../student/in_memory_student_repository.dart';
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
  List<GetBookmarkDto> getByStudentId(StudentId studentId) {
    final bookmarks = _repository.getByStudentId(studentId);
    if (bookmarks == null) return [];

    List<GetBookmarkDto> bookmarkedQuestionList = [];
    for (final QuestionId questionId in bookmarks) {
      final bookmarkedQuestion = _questionRepository.findById(questionId);
      final student = _studentRepository.findById(studentId);
      if (bookmarkedQuestion == null) continue;
      if (student == null) break;

      if (bookmarkedQuestion.answerList.isEmpty) {
        bookmarkedQuestionList.add(
          GetBookmarkDto(
              studentId: studentId,
              studentProfilePhoto: student.profilePhotoPath.value,
              questionTitle: bookmarkedQuestion.questionTitle.value,
              questionText: bookmarkedQuestion.questionText.value,
              teacherId: null,
              teacherProfilePhoto: null,
              answerText: null),
        );
      } else {
        final answer = bookmarkedQuestion.answerList.getMostLikedAnswer();
        final teacher = _teacherRepository.getByTeacherId(answer.teacherId);
        TeacherId? teacherId;
        String? teacherProfilePhotoPath;
        if (teacher != null) {
          teacherId = null;
          teacherProfilePhotoPath = null;
        }
        bookmarkedQuestionList.add(
          GetBookmarkDto(
              studentId: studentId,
              studentProfilePhoto: student.profilePhotoPath.value,
              questionTitle: bookmarkedQuestion.questionTitle.value,
              questionText: bookmarkedQuestion.questionText.value,
              teacherId: teacherId,
              teacherProfilePhoto: teacherProfilePhotoPath,
              answerText: answer.answerText.value),
        );
      }
    }

    return bookmarkedQuestionList;
  }
}
