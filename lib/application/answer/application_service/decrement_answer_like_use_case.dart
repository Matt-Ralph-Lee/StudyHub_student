import '../../../domain/answer_list/models/answer_id.dart';
import '../../../domain/answer_list/models/i_answer_repository.dart';
import '../../../domain/liked_answer/models/i_liked_answers_repository.dart';
import '../../../domain/question/models/question_id.dart';
import '../../../domain/student/models/student_id.dart';
import '../../interfaces/i_logger.dart';

class DecrementAnswerLikeUseCase {
  final IAnswerRepository _repository;
  final ILikedAnswersRepository _likedAnswersRepository;
  final ILogger _logger;

  DecrementAnswerLikeUseCase({
    required final IAnswerRepository repository,
    required final ILikedAnswersRepository likedAnswersRepository,
    required final ILogger logger,
  })  : _repository = repository,
        _likedAnswersRepository = likedAnswersRepository,
        _logger = logger;

  Future<void> execute({
    required final AnswerId answerId,
    required final QuestionId questionId,
    required final StudentId studentId,
  }) async {
    _logger.info('BEGIN $DecrementAnswerLikeUseCase.execute()');

    await _repository.decrementAnswerLike(
        answerId: answerId, questionId: questionId);
    await _likedAnswersRepository.delete(studentId, answerId);

    _logger.info('END $DecrementAnswerLikeUseCase.execute()');
  }
}
