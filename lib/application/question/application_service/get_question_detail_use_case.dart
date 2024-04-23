import '../../../domain/bookmarks/models/i_bookmarks_repository.dart';
import '../../../domain/question/models/question_id.dart';
import '../../../domain/student/default/default_student.dart';
import '../../../domain/student/models/i_student_repository.dart';
import '../../../domain/student/models/student_id.dart';
import '../../interfaces/i_logger.dart';
import 'i_get_question_detail_query_service.dart';
import 'question_detail_dto.dart';

class GetQuestionDetailUseCase {
  final IGetQuestionDetailQueryService _queryService;
  final IBookmarksRepository _bookmarksRepository;
  final IStudentRepository _studentRepository;
  final ILogger _logger;

  GetQuestionDetailUseCase({
    required final IGetQuestionDetailQueryService queryService,
    required final IBookmarksRepository bookmarksRepository,
    required final IStudentRepository studentRepository,
    required final ILogger logger,
  })  : _queryService = queryService,
        _bookmarksRepository = bookmarksRepository,
        _studentRepository = studentRepository,
        _logger = logger;

  Future<QuestionDetailDto> execute({
    required final QuestionId questionId,
    required final StudentId studentId,
  }) async {
    _logger.info('BEGIN $GetQuestionDetailUseCase.execute()');

    final question = await _queryService.getByQuestionId(questionId);
    final isBookmarked = await _bookmarksRepository.checkIsBookmarked(
        questionId: question.questionId, studentId: studentId);

    final student = await _studentRepository.findById(question.studentId);

    final QuestionDetailDto questionDetailDto;
    if (student == null) {
      questionDetailDto = QuestionDetailDto(
        questionId: question.questionId,
        studentProfilePhotoPath: DefaultStudent.profilePhoto.value,
        questionTitle: question.questionTitle.value,
        questionText: question.questionText.value,
        questionPhotoPathList: question.questionPhotoPathList
            .map((photoPath) => photoPath.value)
            .toList(),
        isBookmarked: isBookmarked,
      );
    } else {
      questionDetailDto = QuestionDetailDto(
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

    _logger.info('END $GetQuestionDetailUseCase.execute()');
    return questionDetailDto;
  }
}
