import '../../shared/application_service/question_card_dto.dart';
import 'i_search_for_questions_query_service.dart';

class SearchForQuestionUseCase {
  final ISearchForQuestionsQueryService _queryService;

  SearchForQuestionUseCase({
    required final ISearchForQuestionsQueryService queryService,
  }) : _queryService = queryService;

  List<QuestionCardDto> execute(final String searchWord) {
    final found = _queryService.search(searchWord);
    return found;
  }
}
