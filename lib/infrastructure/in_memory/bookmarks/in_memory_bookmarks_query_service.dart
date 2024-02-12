import '../../../domain/answer_list/models/answer.dart';
import '../../../domain/question/models/question_id.dart';
import '../../../application/bookmarks/application_service/get_bookmarks_dto.dart';
import '../../../application/bookmarks/application_service/i_get_bookmarks_query_service.dart';
import '../../../domain/student/models/student_id.dart';
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
  List<GetBookmarksDto> getByStudentId(StudentId studentId) {
    final bookmarkIds = _repository.getByStudentId(studentId);
    if (bookmarkIds == null) return [];

    List<GetBookmarksDto> bookmarks = [];
    for (final QuestionId bookmarkId in bookmarkIds) {
      final bookmark = _questionRepository.findById(bookmarkId);
      final student = _studentRepository.findById(studentId);
      if (bookmark == null) return [];
      if (student == null) return [];

      if (bookmark.questionResolved) {
        Answer mostLikedAnswer = bookmark.answerList.answerList.first;
        for (final Answer answer in bookmark.answerList.answerList) {
          if (mostLikedAnswer.like.value < answer.like.value) {
            mostLikedAnswer = answer;
          }
        }

        final teacher =
            _teacherRepository.getByTeacherId(mostLikedAnswer.teacherId);
        if (teacher == null) return [];

        bookmarks.add(
          GetBookmarksDto(
            studentId: studentId,
            studentProfilePhoto: student.profilePhotoPath.value,
            questionTitle: bookmark.questionTitle.value,
            questionText: bookmark.questionText.value,
            teacherId: mostLikedAnswer.teacherId,
            teacherProfilePhoto: teacher.profilePhotoPath.value,
            answerText: mostLikedAnswer.answerText.value,
            resolve: bookmark.questionResolved,
          ),
        );
      } else {
        bookmarks.add(
          GetBookmarksDto(
            studentId: studentId,
            studentProfilePhoto: student.profilePhotoPath.value,
            questionTitle: bookmark.questionTitle.value,
            questionText: bookmark.questionText.value,
            teacherId: null,
            teacherProfilePhoto: null,
            answerText: null,
            resolve: bookmark.questionResolved,
          ),
        );
      }
    }

    return bookmarks;
  }
}
