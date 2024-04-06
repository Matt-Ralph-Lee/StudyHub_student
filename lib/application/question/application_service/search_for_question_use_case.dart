import '../../../domain/shared/subject.dart';
import '../../shared/application_service/question_card_dto.dart';
import 'i_search_for_questions_query_service.dart';

class SearchForQuestionUseCase {
  final ISearchForQuestionsQueryService _queryService;

  SearchForQuestionUseCase({
    required final ISearchForQuestionsQueryService queryService,
  }) : _queryService = queryService;

  Future<List<QuestionCardDto>> execute(
      {required final String searchWord,
      required final Subject? subject}) async {
    final found =
        await _queryService.search(searchWord: searchWord, subject: subject);
    return found;
  }
}
