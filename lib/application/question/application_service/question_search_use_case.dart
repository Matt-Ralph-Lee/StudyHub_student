import 'i_question_search_query_service.dart';
import 'question_search_dto.dart';

class QuestionSearchUseCase {
  final IQuestionSearchQueryService _queryService;

  QuestionSearchUseCase({
    required final IQuestionSearchQueryService queryService,
  }) : _queryService = queryService;

  List<QuestionSearchDto> execute(final String searchWord) {
    final found = _queryService.searchQuestionWithMostLikedAnswer(searchWord);
    return found;
  }
}
