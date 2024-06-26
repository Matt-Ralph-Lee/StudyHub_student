import '../../../domain/shared/subject.dart';
import '../../interfaces/i_logger.dart';
import '../../shared/application_service/question_card_dto.dart';
import 'i_search_for_questions_query_service.dart';

class SearchForQuestionUseCase {
  final ISearchForQuestionsQueryService _queryService;
  final ILogger _logger;

  SearchForQuestionUseCase({
    required final ISearchForQuestionsQueryService queryService,
    required final ILogger logger,
  })  : _queryService = queryService,
        _logger = logger;

  Future<List<QuestionCardDto>> execute({
    required final String searchWord,
    required final Subject? subject,
  }) async {
    _logger.info('BEGIN $SearchForQuestionUseCase.execute()');

    final found =
        await _queryService.search(searchWord: searchWord, subject: subject);

    _logger.info('END $SearchForQuestionUseCase.execute()');
    return found;
  }
}
