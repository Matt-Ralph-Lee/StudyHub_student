import '../../../domain/question/models/question_id.dart';
import '../../interfaces/i_logger.dart';
import 'answer_dto.dart';
import 'i_get_answer_query_service.dart';

class GetAnswerUseCase {
  final IGetAnswerQueryService _queryService;
  final ILogger _logger;

  GetAnswerUseCase({
    required final IGetAnswerQueryService queryService,
    required final ILogger logger,
  })  : _queryService = queryService,
        _logger = logger;

  Future<List<AnswerDto>> execute(final QuestionId questionId) async {
    _logger.info('BEGIN $GetAnswerUseCase.execute()');

    final answers = await _queryService.getById(questionId);

    _logger.info('END $GetAnswerUseCase.execute()');
    return answers;
  }
}
