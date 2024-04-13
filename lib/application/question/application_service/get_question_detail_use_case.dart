import '../../../domain/bookmarks/models/i_bookmarks_repository.dart';
import '../../../domain/question/models/question_id.dart';
import '../../../domain/student/default/default_student.dart';
import '../../../domain/student/models/i_student_repository.dart';
import 'i_get_question_detail_query_service.dart';
import 'question_detail_dto.dart';

class GetQuestionDetailUseCase {
  final IGetQuestionDetailQueryService _queryService;
  final IBookmarksRepository _bookmarksRepository;
  final IStudentRepository _studentRepository;

  GetQuestionDetailUseCase({
    required final IGetQuestionDetailQueryService queryService,
    required final IBookmarksRepository bookmarksRepository,
    required final IStudentRepository studentRepository,
  })  : _queryService = queryService,
        _bookmarksRepository = bookmarksRepository,
        _studentRepository = studentRepository;
  Future<QuestionDetailDto> execute(final QuestionId questionId) async {
    final question = await _queryService.getByQuestionId(questionId);
    final student = await _studentRepository.findById(question.studentId);
    if (student == null) {
      return QuestionDetailDto(
        questionId: question.questionId,
        studentProfilePhotoPath: DefaultStudent.profilePhoto.value,
        questionTitle: question.questionTitle.value,
        questionText: question.questionText.value,
        questionPhotoPathList: question.questionPhotoPathList
            .map((photoPath) => photoPath.value)
            .toList(),
        isBookmarked: false,
      );
    }

    final isBookmarked = await _bookmarksRepository.checkIsBookmarked(
        questionId: question.questionId, studentId: student.studentId);

    return QuestionDetailDto(
      questionId: question.questionId,
      studentProfilePhotoPath: student.profilePhotoPath.value,
      questionTitle: question.questionTitle.value,
      questionText: question.questionText.value,
      questionPhotoPathList: question.questionPhotoPathList
          .map((photoPath) => photoPath.value)
          .toList(),
      isBookmarked: isBookmarked,
    );
  }
}
