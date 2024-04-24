import '../../interfaces/i_logger.dart';
import '../../shared/application_service/question_card_dto.dart';
import '../../shared/session/session.dart';
import 'i_get_my_questions_query_service.dart';

class GetMyQuestionsUseCase {
  final Session _session;
  final IGetMyQuestionsQueryService _queryService;
  final ILogger _logger;

  GetMyQuestionsUseCase({
    required final Session session,
    required final IGetMyQuestionsQueryService queryService,
    required final ILogger logger,
  })  : _session = session,
        _queryService = queryService,
        _logger = logger;

  Future<List<QuestionCardDto>> execute() async {
    _logger.info('BEGIN $GetMyQuestionsUseCase.execute()');

    final studentId = _session.studentId;
    final found = await _queryService.get(studentId);

    _logger.info('END $GetMyQuestionsUseCase.execute()');
    return found;
  }
}
