import '../../../domain/question/models/i_question_repository.dart';
import '../../../domain/question/models/question_id.dart';
import '../../../domain/student/models/student_id.dart';
import '../../interfaces/i_logger.dart';
import '../exception/question_use_case_exception.dart';
import '../exception/question_use_case_exception_detail.dart';

class ResolveQuestionUseCase {
  final IQuestionRepository _repository;
  final ILogger _logger;

  ResolveQuestionUseCase({
    required final IQuestionRepository repository,
    required final ILogger logger,
  })  : _repository = repository,
        _logger = logger;

  Future<void> execute({
    required final StudentId studentId,
    required final QuestionId questionId,
  }) async {
    _logger.info('BEGIN $ResolveQuestionUseCase.execute()');

    final isMyQuestion = await _repository.checkIsMyQuestion(
        studentId: studentId, questionId: questionId);
    if (!isMyQuestion) {
      throw const QuestionUseCaseException(
          QuestionUseCaseExceptionDetail.notAllowedToResolve);
    }
    await _repository.resolveQuestion(questionId);

    _logger.info('END $ResolveQuestionUseCase.execute()');
  }
}
