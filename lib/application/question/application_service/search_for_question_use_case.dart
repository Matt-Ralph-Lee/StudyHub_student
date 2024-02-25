import '../../shared/application_service/question_card_dto.dart';
import 'i_question_search_query_service.dart';

class SearchForQuestionUseCase {
  final IQuestionSearchQueryService _queryService;

  SearchForQuestionUseCase({
    required final IQuestionSearchQueryService queryService,
  }) : _queryService = queryService;

  List<QuestionCardDto> execute(final String searchWord) {
    final found = _queryService.searchQuestionWithMostLikedAnswer(searchWord);
    return found;
  }
}
