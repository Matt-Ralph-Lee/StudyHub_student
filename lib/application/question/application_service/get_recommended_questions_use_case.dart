import '../../../domain/shared/subject.dart';
import '../../interfaces/i_logger.dart';
import '../../shared/application_service/question_card_dto.dart';
import '../../shared/session/session.dart';
import 'i_get_recommended_questions_query_service.dart';

class GetRecommendedQuestionsUseCase {
  final Session _session;
  final IGetRecommendedQuestionsQueryService _queryService;
  final ILogger _logger;

  GetRecommendedQuestionsUseCase({
    required final Session session,
    required final IGetRecommendedQuestionsQueryService queryService,
    required final ILogger logger,
  })  : _session = session,
        _queryService = queryService,
        _logger = logger;

  Future<List<QuestionCardDto>> execute(final Subject? subject) async {
    _logger.info('BEGIN $GetRecommendedQuestionsUseCase.execute()');

    final studentId = _session.studentId;
    final recommended = await _queryService.get(
      subject: subject,
      studentId: studentId,
    );

    _logger.info('END $GetRecommendedQuestionsUseCase.execute()');
    return recommended;
  }
}
